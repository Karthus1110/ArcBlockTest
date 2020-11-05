//
//  ZYAlertView.swift
//  PixHall
//
//  Created by zY on 2019/7/23.
//  Copyright © 2019 zY. All rights reserved.
//

import UIKit

class ZYAlertView: NSObject {
    
    class func showAlert(
        title: String?,
        message: String?,
        ensureTitle: String?,
        cancelTitle: String?,
        controller: UIViewController,
        ensureAction: (() -> Void)? = nil,
        cancelAction: (() -> Void)? = nil)
    {
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        
        if ensureTitle != nil {
            let ensureAct = UIAlertAction.init(title: ensureTitle, style: .default) { (action) in
                if ensureAction != nil {
                    ensureAction!()
                }
            }
            
            alertController.addAction(ensureAct)
        }
        
        if cancelTitle != nil {
            let cancelAct = UIAlertAction.init(title: cancelTitle, style: .cancel) { (action) in
                if cancelAction != nil {
                    cancelAction!()
                }
            }
            alertController.addAction(cancelAct)
        }
        
        controller.present(alertController, animated: true, completion: nil)
    }
    
    class func showAlert(
        title: String?,
        message: String?,
        controller: UIViewController,
        ensureAction: (() -> Void)? = nil,
        cancelAction: (() -> Void)? = nil)
    {
        self.showAlert(title: title, message: message, ensureTitle: "确定", cancelTitle: "取消", controller: controller, ensureAction: ensureAction, cancelAction: cancelAction)
    }
    
    class func showEnsureAlert(
        title: String?,
        message: String?,
        controller: UIViewController,
        ensureAction: (() -> Void)? = nil
        )
    {
        self.showAlert(title: title, message: message, ensureTitle: "确定", cancelTitle: nil, controller: controller, ensureAction: ensureAction, cancelAction: nil)
    }
    
}
