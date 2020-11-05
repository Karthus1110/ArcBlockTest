//
//  ZYTextController.swift
//  ArcBlockTest
//
//  Created by zY on 2020/11/5.
//

import UIKit

class ZYTextController: ZYBaseViewController {
    
    let titleLbl = UILabel()
    let authorLbl = UILabel()
    let timeLbl = UILabel()
    let contentLbl = UILabel()

    let scrollView = UIScrollView()
    
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
        
        titleLbl.font = kBoldFont20
        titleLbl.textColor = .black
        titleLbl.numberOfLines = 2
        titleLbl.lineBreakMode = .byTruncatingTail
        titleLbl.text = "也许有个标题更好看，加了段落间隔，增加了行间距，要是有分段会更清晰"
        scrollView.addSubview(titleLbl)
        titleLbl.snp.makeConstraints { (make) in
            make.left.equalTo(offset)
            make.top.equalTo(offset)
            make.right.equalTo(self.view.snp.right).offset(-offset)
        }
        
        authorLbl.font = kContentFont15
        authorLbl.textColor = .black
        authorLbl.text = "karthus"
        scrollView.addSubview(authorLbl)
        authorLbl.snp.makeConstraints { (make) in
            make.left.equalTo(offset)
            make.top.equalTo(titleLbl.snp.bottom).offset(offset)
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        timeLbl.font = kContentFont13
        timeLbl.textColor = .black
        timeLbl.text = dateFormatter.string(from: Date())
        scrollView.addSubview(timeLbl)
        timeLbl.snp.makeConstraints { (make) in
            make.right.equalTo(self.view.snp.right).offset(-offset)
            make.centerY.equalTo(authorLbl)
        }
        
        contentLbl.font = kContentFont16
        contentLbl.textColor = kCommonBlackColor
        contentLbl.numberOfLines = 0
        contentLbl.lineBreakMode = .byWordWrapping
        scrollView.addSubview(contentLbl)
        contentLbl.snp.makeConstraints { (make) in
            make.left.equalTo(offset)
            make.top.equalTo(timeLbl.snp.bottom).offset(offset)
            make.right.equalTo(self.view.snp.right).offset(-offset)
            make.bottom.equalToSuperview().offset(-offset)
        }

    }
    
    
}
