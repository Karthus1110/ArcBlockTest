//
//  ZYFoundation.swift
//  PixHall
//
//  Created by zY on 2019/7/8.
//  Copyright © 2019 zY. All rights reserved.
//

import UIKit
@_exported import SnapKit

// MARK: - 常用宏
let kScreenWidth = UIScreen.main.bounds.size.width
let kScreenHeight = UIScreen.main.bounds.size.height

/// 是否横竖屏
/// 用户界面横屏了才会返回YES
@available(iOS, deprecated: 13.0)
let kIsLandscape = UIApplication.shared.statusBarOrientation.isLandscape

/// 状态栏高度(来电等情况下，状态栏高度会发生变化，所以应该实时计算)
@available(iOS, deprecated: 13.0)
let kStatusBarHeight = (UIApplication.shared.isStatusBarHidden ? 0 : UIApplication.shared.statusBarFrame.size.height)

let kIsNotchedScreen = ZYHelper.isNotchedScreen()

/// 代表(导航栏+状态栏)，这里用于获取其高度
@available(iOS, deprecated: 13.0)
let kNavigationContentTop = (kStatusBarHeight + 44)

/// tabBar相关frame
@available(iOS, deprecated: 13.0)
let kTabBarHeight = (ZYHelper.isIpad() ? (kIsNotchedScreen ? 65 : 50) : (kIsNotchedScreen ? (kIsLandscape ? 32 : 49) : 49) + ZYHelper.safeAreaInsetsForDeviceWithNotch().bottom)

// MARK: - 颜色
let kCommonBlackColor:UIColor = UIColor.init(hexString: "2c2c2c")!
let kCommonGrayColor:UIColor = UIColor.init(hexString: "8a8a8a")!
let kCommonLightGrayColor:UIColor = UIColor.init(hexString: "e6e6e6")!
let kCommonBlueColor:UIColor = UIColor.init(hexString: "4188D2")!

let kMaskColor:UIColor = UIColor.init(white: 0.3, alpha: 0.3)

// MARK: - Block
typealias CompleteClosure = () -> Void
typealias BoolClosure = (_ value: Bool) -> Void

// MARK: - 字体
let kContentFont11:UIFont = UIFont.systemFont(ofSize: 11)
let kContentFont12:UIFont = UIFont.systemFont(ofSize: 12)
let kContentFont13:UIFont = UIFont.systemFont(ofSize: 13)
let kContentFont14:UIFont = UIFont.systemFont(ofSize: 14)
let kContentFont15:UIFont = UIFont.systemFont(ofSize: 15)
let kContentFont16:UIFont = UIFont.systemFont(ofSize: 16)
let kContentFont17:UIFont = UIFont.systemFont(ofSize: 17)
let kContentFont18:UIFont = UIFont.systemFont(ofSize: 18)

let kBoldFont14:UIFont = UIFont.boldSystemFont(ofSize: 14)
let kBoldFont16:UIFont = UIFont.boldSystemFont(ofSize: 16)
let kBoldFont18:UIFont = UIFont.boldSystemFont(ofSize: 18)
let kBoldFont20:UIFont = UIFont.boldSystemFont(ofSize: 20)

// MARK: - 通知&UserDefaults

let kaddHistory = "kaddHistory"

let kFirstInstallVersion = "kFirstInstallVersion" // 第一次安装的版本
let kLastVersion = "kLastVersion" // 上次打开版本
let kOpenAppCount = "kOpenAppCount"
let kLastSaveTime = "kLastSaveTime" // 上次保存视频时间
let kIsPro = "kIsPro"

let videoPath: String = String(ZYFileHelper.documentPath()! + "/video.mp4")

// MARK: - 更新
func isUpdate() -> Bool {
    let defaults = UserDefaults.standard
    
    guard let lastVersion: String = defaults.string(forKey: kLastVersion)  else {
        defaults.set(Bundle.main.infoDictionary!["CFBundleShortVersionString"], forKey: kLastVersion)
        return false
    }
    
    let currentVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    
    let lastVersionValue = Int(lastVersion.components(separatedBy: ".").joined(separator: ""))!
    
    let currentVersionValue = Int(currentVersion.components(separatedBy: ".").joined(separator: ""))!
    
    if currentVersionValue > lastVersionValue {
        return true
    }
    
    return false
}
