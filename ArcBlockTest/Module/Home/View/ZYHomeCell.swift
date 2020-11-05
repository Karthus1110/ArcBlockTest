//
//  ZYHomeCell.swift
//  ArcBlockTest
//
//  Created by zY on 2020/11/4.
//

import UIKit

class ZYHomeCell: UITableViewCell {
    
    var model: ZYTestModel?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        
        let shadowView = UIView()
        shadowView.backgroundColor = UIColor.white
        shadowView.layer.shadowColor = kCommonBlackColor.cgColor
        shadowView.layer.shadowOpacity = 0.3
        shadowView.layer.shadowOffset = CGSize.init(width: 3, height: 3)
        shadowView.layer.shadowRadius = 8
        shadowView.layer.cornerRadius = 8        
        self.contentView.addSubview(shadowView)
        shadowView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.init(top: 15, left: 15, bottom: 15, right: 15))
        }
        
    }
    
}
