//
//  ZYImgTextController.swift
//  ArcBlockTest
//
//  Created by zY on 2020/11/5.
//

import UIKit

class ZYImgTextController: ZYBaseViewController {
    
    let titleLbl = UILabel()
    let contentLbl = UILabel()

    let scrollView = UIScrollView()
    var bannerView: ZYAutoBannerView!
    
    var model: ZYTestModel? {
        didSet {
            guard let content = model?.content else { return }
                        
            let attStr = NSMutableAttributedString(string: content)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 5
            paragraphStyle.paragraphSpacing = 20
            attStr.addAttributes([.paragraphStyle : paragraphStyle], range: NSRange(location: 0, length: content.count))
            contentLbl.attributedText = attStr            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }

    @available(iOS, deprecated: 13.0)
    override func initSubviews() {
        
        let offset = 15
        
        self.view.backgroundColor = .white
        
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(kNavigationContentTop)
            make.left.right.bottom.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        bannerView = ZYAutoBannerView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 260), dataSource: ((model?.imgUrls)!), sourceType: .url, placeholder: nil)
        bannerView.clickClosure = {[weak self] index in
            let previewVC = ZYImgPreviewController()
            previewVC.preview.imgURL = self?.model?.imgUrls[index]
            previewVC.modalPresentationStyle = .fullScreen
            self?.present(previewVC, animated: true, completion: nil)
        }
        self.view.addSubview(bannerView)
        
        titleLbl.font = kBoldFont20
        titleLbl.textColor = .black
        titleLbl.numberOfLines = 0
        titleLbl.lineBreakMode = .byTruncatingTail
        titleLbl.text = "也许有个标题更好看"
        scrollView.addSubview(titleLbl)
        titleLbl.snp.makeConstraints { (make) in
            make.left.equalTo(offset)
            make.top.equalTo(bannerView.snp.bottom).offset(offset)
            make.right.equalTo(self.view.snp.right).offset(-offset)
        }
        
        contentLbl.font = kContentFont16
        contentLbl.textColor = kCommonBlackColor
        contentLbl.numberOfLines = 0
        contentLbl.lineBreakMode = .byWordWrapping
        scrollView.addSubview(contentLbl)
        contentLbl.snp.makeConstraints { (make) in
            make.left.equalTo(offset)
            make.top.equalTo(titleLbl.snp.bottom).offset(offset)
            make.right.equalTo(self.view.snp.right).offset(-offset)
            make.bottom.equalToSuperview().offset(-offset)
        }
    }
    
}
