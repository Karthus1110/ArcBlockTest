//
//  ZYHomeMultiImageCell.swift
//  ArcBlockTest
//
//  Created by zY on 2020/11/4.
//

import UIKit
import Kingfisher

class ZYHomeMultiImageCell: ZYHomeCell {

    private let stackView = UIStackView()
    private let contentLbl = UILabel()

    override var model: ZYTestModel? {
        didSet {
            contentLbl.text = model?.content
            
            stackView.removeAllArrangedSubviews()
            for imgUrl in model!.imgUrls {
                let imgView = UIImageView.init()
                imgView.contentMode = .scaleAspectFill
                imgView.clipsToBounds = true
                imgView.layer.cornerRadius = 5
                imgView.kf.setImage(with: URL(string: imgUrl)!)
                stackView.addArrangedSubview(imgView)
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
        }
        
        stackView.spacing = 10
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually

        self.contentView.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(contentLbl.snp.bottom).offset(10)
            make.left.right.equalTo(contentLbl)
            make.right.equalToSuperview().offset(-offset)
            make.height.equalTo(100)
            
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-offset)
        }
        
    }

}

extension UIStackView {
    
    func removeAllArrangedSubviews() {
        
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        
        // Deactivate all constraints
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
        
        // Remove the views from self
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
}
