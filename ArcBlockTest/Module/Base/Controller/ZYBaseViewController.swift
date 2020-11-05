//
//  ZYBaseViewController.swift
//  Prompt
//
//  Created by zY on 2020/7/31.
//  Copyright © 2020 zY. All rights reserved.
//

import UIKit

class ZYBaseViewController: UIViewController {

    private var hud: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
        initSubviews()
        initHud()
        loadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startLoading(false)
    }
    
    func initNavigationBar() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem.init(title: "", style: .plain, target: self, action: nil)
    }
    
    func initSubviews() {}
    
    func loadData() {}
    
    func initHud() {
        hud = UIView()
        hud.isHidden = true
        hud.layer.cornerRadius = 8
        hud.clipsToBounds = true
        hud.backgroundColor = UIColor.init(white: 0.3, alpha: 0.7)
        self.view.addSubview(hud)
        hud.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.height.equalTo(80)
        }
        
        let indictor = UIActivityIndicatorView.init(style: .large)
        indictor.startAnimating()
        hud.addSubview(indictor)
        indictor.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    
    func startLoading(_ start: Bool) {
        if start {
            hud.isHidden = false
            self.view.bringSubviewToFront(hud)
        } else {
            hud.isHidden = true
        }
    }
    

}
