//
//  ZYHomeImageCell.swift
//  ArcBlockTest
//
//  Created by zY on 2020/11/4.
//

import UIKit
import Kingfisher

class ZYHomeImageCell: ZYHomeCell {
    
    private let imgView = UIImageView()

    override var model: ZYTestModel? {
        didSet {
            guard let url = model?.imgUrls.first else {
                return
            }
            imgView.kf.setImage(with: URL(string: url))
        }
    }
 
    override func commonInit() {
        super.commonInit()
        
        let offset: CGFloat = 15
        
        let imgWidth = kScreenWidth - offset*2
        let imgHeight = imgWidth*(9/16)
        
        imgView.layer.cornerRadius = 8
        imgView.clipsToBounds = true
        imgView.backgroundColor = kMaskColor
        self.contentView.addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView.snp.top).offset(offset)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-offset)
            make.left.equalTo(offset)
            make.height.equalTo(imgHeight)
            make.width.equalTo(imgWidth)
        }
    }
}
