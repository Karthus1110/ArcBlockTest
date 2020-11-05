//
//  ZYImgPreviewController.swift
//  ArcBlockTest
//
//  Created by zY on 2020/11/5.
//

import UIKit

class ZYImgPreviewController: ZYBaseViewController {
    
    private var backBtn: UIButton!
    
    lazy var preview: ZYZoomImageView = {
        let preview = ZYZoomImageView.init(frame: self.view.bounds, rect: self.view.bounds)
        self.view.addSubview(preview)
        preview.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        self.view.bringSubviewToFront(backBtn)
        return preview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @available(iOS, deprecated: 13.0)
    override func initSubviews() {
        self.view.backgroundColor = .black
        
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        var icon = UIImage(systemName: "xmark", withConfiguration: configuration)
        icon = icon?.withTintColor(.white, renderingMode: .alwaysOriginal)
        

        backBtn = UIButton.init(type: .custom)
        backBtn.setImage(icon, for: .normal)
        backBtn.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        self.view.addSubview(backBtn)
        backBtn.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(kStatusBarHeight)
            make.width.height.equalTo(44)
            make.right.equalToSuperview().offset(-15)
        }
    }
    
    @objc func backAction() {
        self.dismiss(animated: true, completion: nil)
    }


}
