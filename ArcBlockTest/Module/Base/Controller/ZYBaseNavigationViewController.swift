//
//  ZYBaseNavigationViewController.swift
//  Prompt
//
//  Created by zY on 2020/7/31.
//  Copyright © 2020 zY. All rights reserved.
//

import UIKit

class ZYBaseNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.tintColor = kCommonBlackColor
        self.navigationBar.barTintColor = .white
        self.navigationBar.shadowImage = UIImage()
    }
    
    
    override var prefersStatusBarHidden: Bool {
        return self.topViewController?.prefersStatusBarHidden ?? true
    }
    

}
