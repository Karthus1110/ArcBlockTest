//
//  ZYHomeLinkCell.swift
//  ArcBlockTest
//
//  Created by zY on 2020/11/4.
//

import UIKit

class ZYHomeLinkCell: ZYHomeCell {
    private let contentLbl = UILabel()

    override var model: ZYTestModel? {
        didSet {
            if let content = model?.content {
                let attStr = NSMutableAttributedString(string: content)
//                attStr.addAttributes([.underlineStyle : NSUnderlineStyle.single.rawValue, .underlineColor : kCommonBlueColor], range: NSRange(location: 0, length: content.count))
                attStr.addAttributes([.link : kCommonBlueColor], range: NSRange(location: 0, length: content.count))
                contentLbl.attributedText = attStr
            }
            
        }
    }
 
    override func commonInit() {
        super.commonInit()
        
        let offset = 30
        
        contentLbl.font = kBoldFont16
        contentLbl.textColor = kCommonBlackColor
        contentLbl.numberOfLines = 0
        contentLbl.lineBreakMode = .byWordWrapping
        self.contentView.addSubview(contentLbl)
        contentLbl.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView.snp.top).offset(offset)
            make.left.equalTo(offset)
            make.right.equalToSuperview().offset(-offset)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-offset)
        }
    }

}
