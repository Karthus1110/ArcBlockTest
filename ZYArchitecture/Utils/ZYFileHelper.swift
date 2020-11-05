//
//  ZYFileHelper.swift
//  PixHall
//
//  Created by zY on 2019/8/12.
//  Copyright © 2019 zY. All rights reserved.
//

import UIKit

class ZYFileHelper: NSObject {
    
    class func mainBundlePath(fileName: String) -> String? {
        if fileName.isEmpty == false {
            let resources = fileName.components(separatedBy: ".")
            if resources.count > 1 {
                let filePath = Bundle.main.path(forResource: resources.objectAtIndexSafely(index: 0), ofType: resources.objectAtIndexSafely(index: 1))
                return filePath
            }
        }
        return nil
    }

    // document文件路径
    class func documentPath() -> String? {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let filePath = paths.objectAtIndexSafely(index: 0)
        return filePath
    }
    
}

