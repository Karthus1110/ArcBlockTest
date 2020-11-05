//
//  ZYHomeSingleImageCell.swift
//  ArcBlockTest
//
//  Created by zY on 2020/11/4.
//

import UIKit

class ZYHomeSingleImageCell: ZYHomeCell {

    private let imgView = UIImageView()
    private let contentLbl = UILabel()

    override var model: ZYTestModel? {
        didSet {
            contentLbl.text = model?.content

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
            make.left.equalTo(offset)
            make.height.equalTo(imgHeight)
            make.width.equalTo(imgWidth)
        }
        
        contentLbl.font = kBoldFont16
        contentLbl.textColor = kCommonBlackColor
        contentLbl.numberOfLines = 0
        contentLbl.lineBreakMode = .byWordWrapping
        self.contentView.addSubview(contentLbl)
        contentLbl.snp.makeConstraints { (make) in
            make.top.equalTo(imgView.snp.bottom).offset(30)
            make.left.equalTo(30)
            make.right.equalToSuperview().offset(-30)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-30)
        }
    }

}
