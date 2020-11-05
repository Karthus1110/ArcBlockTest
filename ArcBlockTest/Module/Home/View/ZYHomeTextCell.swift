//
//  ZYHomeTextCell.swift
//  ArcBlockTest
//
//  Created by zY on 2020/11/4.
//

import UIKit

class ZYHomeTextCell: ZYHomeCell {
    
    private let contentLbl = UILabel()

    override var model: ZYTestModel? {
        didSet {
            contentLbl.text = model?.content
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
