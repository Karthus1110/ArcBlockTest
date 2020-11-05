//
//  ZYZoomImageView.swift
//  ArcBlockTest
//
//  Created by zY on 2020/11/5.
//

import UIKit
import Kingfisher


class ZYZoomImageView: UIView {
    
    private var scrollView: UIScrollView!
    private var imageView: UIImageView!
    private var emptyView: UIView!
    private var indicator: UIActivityIndicatorView!
        
    private var maxZoomScale: CGFloat = 2.0
    
     var viewRect: CGRect?
    
    var imgURL: String? {
        didSet {
            guard let imageURL = imgURL else { return }
            self.showEmptyLoading()
            //            let cache = KingfisherManager.shared.cache
                        let cache = ImageCache.default
                        let plachehodlerImage = cache.retrieveImageInMemoryCache(forKey: imageURL)

                        self.setNeedsLayout()
                        self.layoutIfNeeded()                        

                        imageView.kf.setImage(with: URL(string: imageURL),
                                              placeholder: plachehodlerImage,
                                              options: nil,
                                              progressBlock: nil) {[weak self] (result) in
                                                self?.hideEmptyView()
                                                switch result {
                                                case .success(let response):
                                                    let scale = response.image.size.height/response.image.size.width
                                                    let imageWidth = kScreenWidth
                                                    let imageHeight = imageWidth*scale
                                                    self?.imageView.frame = CGRect.init(x: 0, y: 0, width: imageWidth, height: imageHeight)
                                                    
                                                    self?.revertZooming()
                                                    break
                                                case .failure(let error):
                                                    if error.isNotCurrentTask == false {
                                                        self?.showEmptyError()
                                                    }
                                                    break
                                                }
                        }
        }
    }


    init(frame: CGRect, rect: CGRect) {
        super.init(frame: frame)
        self.viewRect = rect
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        self.contentMode = .center
        
        scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = self.maxZoomScale
        scrollView.pinchGestureRecognizer?.isEnabled = true
        scrollView.panGestureRecognizer.isEnabled = true
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            // Fallback on earlier versions
        }
        self.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        scrollView.addSubview(imageView)
        
        let doubleTapGesture = UITapGestureRecognizer.init(target: self, action: #selector(doubleTap(gesture:)))
        doubleTapGesture.numberOfTapsRequired = 2
        doubleTapGesture.numberOfTouchesRequired = 1
        imageView.addGestureRecognizer(doubleTapGesture)
        
        emptyView = UIView()
        emptyView.isHidden = true
        self.addSubview(emptyView)
        emptyView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        let titleLbl = UILabel.init(font: kContentFont13, textColor: .white)
        titleLbl.text = NSLocalizedString("Image Load Error", comment: "")
        emptyView.addSubview(titleLbl)
        titleLbl.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.bottom.equalTo(self.snp.centerY).offset(-4)
        }
        
        let retryBtn = UIButton.init(type: .custom)
        retryBtn.titleLabel?.font = kContentFont13
        retryBtn.setTitleColor(.white, for: .normal)
        retryBtn.setTitle(NSLocalizedString("Retry", comment: ""), for: .normal)
        retryBtn.addTarget(self, action: #selector(reloadImage), for: .touchUpInside)
        emptyView.addSubview(retryBtn)
        retryBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(self.snp.centerY).offset(4)
        }
        
        indicator = UIActivityIndicatorView.init(style: .large)
        indicator.isHidden = true
        self.addSubview(indicator)
        indicator.snp.makeConstraints { (make) in
            make.center.equalTo(self)
        }
        
    }
    
    @objc func reloadImage() {
//        imageModel = self.imageModel?.copyable()
    }
    
    //MARK: - Gesture
    @objc func doubleTap(gesture: UITapGestureRecognizer) {
        let gesturePoint = gesture.location(in: gesture.view)
        
        // 如果图片被压缩了，则第一次放大到原图大小，第二次放大到最大倍数
        if (self.scrollView.zoomScale >= self.scrollView.maximumZoomScale) {
            setZoomScale(zoomScale: scrollView.minimumZoomScale, animated: true)
        } else {
            var newZoomScale: CGFloat = 0;
            if (scrollView.zoomScale < 1) {
                // 如果目前显示的大小比原图小，则放大到原图
                newZoomScale = 1;
            } else {
                // 如果当前显示原图，则放大到最大的大小
                newZoomScale = self.scrollView.maximumZoomScale;
            }
            
            var zoomRect = CGRect.zero;
            let tapPoint = imageView.convert(gesturePoint, to: gesture.view)
            zoomRect.size.width = self.bounds.width / newZoomScale;
            zoomRect.size.height = self.bounds.height / newZoomScale;
            zoomRect.origin.x = tapPoint.x - zoomRect.width / 2;
            zoomRect.origin.y = tapPoint.y - zoomRect.height / 2;
            self.zoomToRect(rect: zoomRect, animated: true)
        }
        
    }

    //MARK: - Empty
    func showEmptyLoading() {
        self.bringSubviewToFront(indicator)
        indicator.isHidden = false
        emptyView.isHidden = true
        indicator.startAnimating()
    }
    
    func showEmptyError() {
        self.bringSubviewToFront(emptyView)
        emptyView.isHidden = false
        indicator.isHidden = true
    }
    
    func hideEmptyView() {
        emptyView.isHidden = true
        indicator.isHidden = true
        indicator.stopAnimating()
    }
}


extension ZYZoomImageView: UIScrollViewDelegate
{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        handleZooming()
    }
    
    func zoomToRect(rect: CGRect, animated: Bool) {
        if animated == true {
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: {
                self.scrollView.zoom(to: rect, animated: animated)
            }, completion: nil)
        } else {
            self.scrollView.zoom(to: rect, animated: false)
        }
    }
    
    func setZoomScale(zoomScale: CGFloat, animated: Bool) {
        if animated == true {
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: {
                self.scrollView.zoomScale = zoomScale
            }, completion: nil)
        } else {
            scrollView.zoomScale = zoomScale
        }
    }
    
    func handleZooming() {
        let viewport = finalViewportRect()
        
        let contentView = self.imageView!
        // 强制 layout 以确保下面的一堆计算依赖的都是最新的 frame 的值
        self.layoutIfNeeded()
        let contentViewFrame = convert(contentView.frame, from: contentView.superview)
        
        var contentInset = UIEdgeInsets.zero;
        
        contentInset.top = viewport.minY
        contentInset.left = viewport.minX
        contentInset.right = self.bounds.width - viewport.maxX
        contentInset.bottom = self.bounds.height - viewport.maxY;
        
        // 图片 height 比选图框(viewport)的 height 小，这时应该把图片纵向摆放在选图框中间，且不允许上下移动
        if (viewport.height > contentViewFrame.height) {
            // 用 floor 而不是 flat，是因为 flat 本质上是向上取整，会导致 top + bottom 比实际的大，然后 scrollView 就认为可滚动了
            contentInset.top = floor(viewport.midY - contentViewFrame.height / 2.0);
            contentInset.bottom = floor(self.bounds.height - viewport.midY - contentViewFrame.height / 2.0);
        }
        
        // 图片 width 比选图框的 width 小，这时应该把图片横向摆放在选图框中间，且不允许左右移动
        if (viewport.width > contentViewFrame.width) {
            contentInset.left = floor(viewport.midX - contentViewFrame.width / 2.0);
            contentInset.right = floor(self.bounds.width - viewport.midX - contentViewFrame.width / 2.0);
        }
        
        self.scrollView.contentInset = contentInset;
        self.scrollView.contentSize = contentView.frame.size;
    }
    
    func revertZooming(){
        
        let contentView = imageView!

        let minZoomScale = self.minZoomScale()
        
        let shouldFireHandleZooming = (minZoomScale == self.scrollView.zoomScale)
        
        scrollView.panGestureRecognizer.isEnabled = true
        scrollView.pinchGestureRecognizer?.isEnabled = true
        scrollView.maximumZoomScale = self.maxZoomScale
        scrollView.minimumZoomScale = minZoomScale
//        contentView.frame = contentView.bounds
        setZoomScale(zoomScale: minZoomScale, animated: false)
        
        // setZoomScale后会导致contentFrame为.zero

        if shouldFireHandleZooming == true {
            handleZooming()
        }
        
        // 当内容比 viewport 的区域更大时，要把内容放在 viewport 正中间
        var x = self.scrollView.contentOffset.x;
        var y = self.scrollView.contentOffset.y;
        let viewport = finalViewportRect()
        if (!viewport.isEmpty) {
            if (viewport.width < contentView.frame.width) {
                x = (contentView.frame.width / 2 - viewport.width / 2) - viewport.minX;
            }
            if (viewport.height < contentView.frame.height) {
                y = (contentView.frame.height / 2 - viewport.height / 2) - viewport.minY;
            }
        }
        
        scrollView.contentOffset = CGPoint(x: x, y: y)
    }
    
    func minZoomScale() -> CGFloat {
        var scale: CGFloat = 1.0
        let viewport = self.finalViewportRect()
        var mediaSize = CGSize.zero
        
        if imageView.image != nil {
            mediaSize = imageView.image!.size
        }
        
        let scaleX = viewport.width / mediaSize.width
        let scaleY = viewport.height / mediaSize.height
        
        if self.contentMode == .scaleAspectFit {
            scale = min(scaleX, scaleY)
        } else if self.contentMode == .scaleAspectFill {
            scale = max(scaleX, scaleY)
        } else if self.contentMode == .center {
            if scaleX >= 1 && scaleY >= 1 {
                scale = 1
            } else {
                scale = max(min(scaleX, scaleY), 1)
            }
        }
        
        return scale
    }
    
    func finalViewportRect() -> CGRect {
        var rect = (self.viewRect != nil) ? self.viewRect! : CGRect.zero
        if self.bounds.isEmpty == false {
            if self.scrollView.bounds.size != self.bounds.size {
                self.setNeedsLayout()
                self.layoutIfNeeded()
            }
            rect = CGRect(x: 0, y: 0, width: self.scrollView.bounds.size.width, height: self.scrollView.bounds.size.height)
        }
        return rect
    }

    
}
