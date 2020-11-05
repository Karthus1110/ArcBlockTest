//
//  ZYRootViewController.swift
//  ArcBlockTest
//
//  Created by zY on 2020/11/4.
//

import UIKit

class ZYRootViewController: ZYBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let homeVC = ZYHomeViewController()
                
        let nav = ZYBaseNavigationViewController.init(rootViewController: homeVC)
        self.view.addSubview(nav.view)
        self.addChild(nav)

    }
    
}
