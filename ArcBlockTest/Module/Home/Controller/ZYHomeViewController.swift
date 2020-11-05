//
//  ZYHomeViewController.swift
//  ArcBlockTest
//
//  Created by zY on 2020/11/4.
//

import UIKit
import SwiftyJSON
import SafariServices
import MJRefresh
import DZNEmptyDataSet

class ZYHomeViewController: ZYBaseViewController {
    
    private var tableView: UITableView!
    private var dataArr = [ZYTestModel]()
    
    private var clearBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func initNavigationBar() {
        super.initNavigationBar()
        let configuration = UIImage.SymbolConfiguration(scale: .large)

        clearBtn = UIButton.init(type: .custom)
        clearBtn.setImage(UIImage.init(systemName: "clear", withConfiguration: configuration), for: .normal)
        clearBtn.setImage(UIImage.init(systemName: "clear.fill", withConfiguration: configuration), for: .selected)
        clearBtn.addTarget(self, action: #selector(clearClick(_:)), for: .touchUpInside)
        clearBtn.frame = CGRect.init(x: 0, y: 0, width: 30, height: 44)
        
        let clearItem = UIBarButtonItem.init(customView: clearBtn)
        
        self.navigationItem.rightBarButtonItems = [clearItem]
    }

    override func initSubviews() {

        self.view.backgroundColor = .white

        self.title = "ArcBlock"
        self.navigationController?.navigationBar.prefersLargeTitles = true

        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
                        
        let cellsArr = [ZYHomeTextCell.self, ZYHomeImageCell.self, ZYHomeImageCell.self, ZYHomeSingleImageCell.self, ZYHomeMultiImageCell.self, ZYHomeLinkCell.self]
        
        for cell in cellsArr {
            tableView.register(cell, forCellReuseIdentifier: NSStringFromClass(cell))
        }
    }
    
    override func loadData() {
        guard let path = Bundle.main.path(forResource: "data", ofType: "json") else {
            return
        }
        
        do {
            let jsonStr = try String.init(contentsOfFile: path)
            let json = JSON.init(parseJSON: jsonStr)
            if json["code"].intValue == 0 {
                // success
                dataArr = json["data"].map {
                    ZYTestModel.init(fromJson: $1)
                }
                tableView.reloadData()
            } else {
                // failed
            }
        } catch _ {
            
        }
    }
    
    
    func getIdentifier(_ model: ZYTestModel) -> String {
        var identifier = ""
        
        switch model.type {
        case "text":
            identifier = NSStringFromClass(ZYHomeTextCell.self)
        case "img" :
            identifier = NSStringFromClass(ZYHomeImageCell.self)
        case "text-img" :
            if model.imgUrls.count > 1 {
                identifier = NSStringFromClass(ZYHomeMultiImageCell.self)
            } else if model.imgUrls.count == 0 {
                identifier = NSStringFromClass(ZYHomeTextCell.self)
            } else {
                identifier = NSStringFromClass(ZYHomeSingleImageCell.self)
            }
        case "text-link" :
            identifier = NSStringFromClass(ZYHomeLinkCell.self)
        default:
            identifier = ""
        }
        
        return identifier
    }
    
    //MARK: - Actions
   @objc func clearClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected

        if sender.isSelected {
            clearData()
        } else {
            loadData()
        }

    }
    
    func clearData() {
        dataArr.removeAll()
        self.tableView.reloadData()
    }
    
}

extension ZYHomeViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = dataArr[indexPath.section]
        let identifier = getIdentifier(model)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ZYHomeCell
        cell.model = model
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = dataArr[indexPath.section]
        switch model.type {
        case "text":
            let textVC = ZYTextController()
            textVC.model = model
            self.navigationController?.pushViewController(textVC, animated: true)
        case "img":
            let previewVC = ZYImgPreviewController()
            previewVC.preview.imgURL = model.imgUrls.first
            previewVC.modalPresentationStyle = .fullScreen
            self.present(previewVC, animated: true, completion: nil)
        case "text-link":
            let safariVC = SFSafariViewController(url: URL(string: model.link)!)
            safariVC.modalPresentationStyle = .fullScreen
            self.present(safariVC, animated: true, completion: nil)
        case "text-img":
            let imgTextVC = ZYImgTextController()
            imgTextVC.model = model
            self.navigationController?.pushViewController(imgTextVC, animated: true)
        default:
            return
        }
    }
    
}


extension ZYHomeViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let mutableStr = NSMutableAttributedString.init(string: "暂无数据或网络出错")
        mutableStr.addAttributes([.font : kContentFont14, .foregroundColor : kCommonGrayColor], range: NSRange(location: 0, length: mutableStr.length))
        return mutableStr
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "table_blank")
    }
    
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView!, for state: UIControl.State) -> NSAttributedString! {
        let mutableStr = NSMutableAttributedString.init(string: "点击重试")
        mutableStr.addAttributes([.font : kContentFont16, .foregroundColor : kCommonBlueColor], range: NSRange(location: 0, length: mutableStr.length))
        return mutableStr
    }
    
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        clearBtn.isSelected = false
        loadData()
    }
    
}
