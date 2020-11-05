//
//  ZYAutoBannerView.swift
//  ArcBlockTest
//
//  Created by zY on 2020/11/5.
//

import UIKit

enum ZYAutoBannerSourceType {
    case name
    case url
}

class ZYAutoBannerView: UIView {
    
    var isAutoScroll = true
    
    var clickClosure: ((_ index: Int) -> Void)?
    
    private var dataSource = [String]()
    private var images = [String]()
    private var sourceType: ZYAutoBannerSourceType?
    private var placeholderImage: UIImage?
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.width, height: self.height)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView.init(frame: self.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        self.addSubview(collectionView)
        return collectionView
    }()
    private lazy var timer: Timer = {
        let timer = Timer(timeInterval: 3, target: self, selector: #selector(timerHandle), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: .common)
        return timer
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        let width = CGFloat(self.dataSource.count*20)
        pageControl.frame = CGRect(x: (self.width - width)/2, y: self.height - 20, width: width, height: 20)
        pageControl.numberOfPages = self.dataSource.count
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = .red
        pageControl.pageIndicatorTintColor = .blue
        pageControl.tintColor = .green
        pageControl.isUserInteractionEnabled = false
        pageControl.hidesForSinglePage = true
        self.addSubview(pageControl)
        return pageControl
    }()
    
    
    init(frame: CGRect, dataSource: Array<String>, sourceType: ZYAutoBannerSourceType, placeholder: UIImage?) {
        super.init(frame: frame)
        setDataSource(dataSource: dataSource, sourceType: sourceType, placeholder: placeholder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {

    }
    
    func setDataSource(dataSource: Array<String>, sourceType: ZYAutoBannerSourceType, placeholder: UIImage?) {
        guard dataSource.count > 0 else {
            return
        }
        
        self.dataSource = dataSource
        self.sourceType = sourceType
        self.placeholderImage = placeholder
        self.images = Array.init(dataSource)
        self.images.insert(self.dataSource.last!, at: 0)
        self.images.append(self.dataSource.first!)
        self.pageControl.currentPage = 0
        self.pageControl.numberOfPages = self.dataSource.count
        self.collectionView.reloadData()
        
        if dataSource.count == 1 {
            self.collectionView.isScrollEnabled = false
        } else {
            self.collectionView.isScrollEnabled = true
            self.collectionView.scrollToItem(at: IndexPath(row: 1, section: 0), at: .centeredHorizontally, animated: false)
        }
        
        self.bringSubviewToFront(pageControl)
        
        if isAutoScroll {
            startTimer()
        }
        
    }
    
    
    //MARK: - Timer

    @objc private func timerHandle() {
        if self.dataSource.count <= 1 {
            return
        }
        
        let currentPage = Int(self.collectionView.contentOffset.x/self.collectionView.width)
        var nextPage = 0
        
        nextPage = currentPage + 1
        if nextPage == self.images.count {
            nextPage = 2
        }
        self.collectionView.scrollToItem(at: IndexPath(row: nextPage, section: 0), at: .centeredHorizontally, animated: false)

    }

    private func startTimer() {
        guard isAutoScroll else {
            return
        }
        
        timer.fire()
    }

    private func stopTimer() {
        timer.invalidate()
    }
}

extension ZYAutoBannerView: UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.contentView.backgroundColor = .white
        for subView in cell.contentView.subviews {
            subView.removeFromSuperview()
        }
        
        let imageView = UIImageView()
        imageView.frame = cell.contentView.bounds
        if sourceType == ZYAutoBannerSourceType.name {
            imageView.image = UIImage(named: images[indexPath.item])
        } else {
            imageView.kf.setImage(with: URL(string: images[indexPath.item])!)
        }
        cell.contentView.addSubview(imageView)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let closure = clickClosure  else {
            return
        }
        
        var index = 0
        let item = indexPath.item
        
        if item == 0 {
            index = dataSource.count - 1
        } else if item == images.count - 1 {
            index = 0
        } else {
            index = item - 1
        }
        
        closure(index)
    }
    
    //MARK: - ScrollView
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPage = Int(scrollView.contentOffset.x/self.width - 1)
        pageControl.currentPage = currentPage
        
        if currentPage < 0 {
            pageControl.currentPage = dataSource.count - 1
            self.collectionView.scrollToItem(at: IndexPath(row: self.dataSource.count, section: 0), at: .centeredHorizontally, animated: false)
            return
        } else if currentPage == dataSource.count {
            pageControl.currentPage = 0
            self.collectionView.scrollToItem(at: IndexPath(row: 1, section: 0), at: .centeredHorizontally, animated: false)
            return
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        stopTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        startTimer()
    }
}
