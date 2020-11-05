//
//  ZYHelper.swift
//  MeowCam
//
//  Created by zY on 2019/11/11.
//  Copyright © 2019 zY. All rights reserved.
//

import UIKit
import Foundation

class ZYHelper: NSObject {
    
    static func isIpad() -> Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }

    static func isNotchedScreen() -> Bool {
         if #available(iOS 11.0, *) {
             guard let w = UIApplication.shared.delegate?.window, let unwrapedWindow = w else {
                 return false
             }
             if unwrapedWindow.safeAreaInsets.left > 0 || unwrapedWindow.safeAreaInsets.bottom > 0 {
                     return true
             }
         }
         return false
     }
    
    @available(iOS, deprecated: 13.0)
    static func safeAreaInsetsForDeviceWithNotch() -> UIEdgeInsets {
        if self.isNotchedScreen() == false {
            return .zero
        }
        
        if self.isIpad() {
            return UIEdgeInsets.init(top: 0, left: 0, bottom: 20, right: 0)
        }        
        
        let orientation = UIApplication.shared.statusBarOrientation
        
        switch orientation {
        case .portrait:
            return UIEdgeInsets.init(top: 44, left: 0, bottom: 34, right: 0)
        case .portraitUpsideDown:
            return UIEdgeInsets.init(top: 34, left: 0, bottom: 44, right: 0)
        case .landscapeLeft, .landscapeRight:
            return UIEdgeInsets.init(top: 0, left: 44, bottom: 21, right: 44)
        default:
            return UIEdgeInsets.init(top: 44, left: 0, bottom: 34, right: 0)
        }
    }
}
