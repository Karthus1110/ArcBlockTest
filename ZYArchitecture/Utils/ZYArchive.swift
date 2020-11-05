//
//  ZYArchive.swift
//  PixHall
//
//  Created by zY on 2019/8/12.
//  Copyright © 2019 zY. All rights reserved.
//

import UIKit

class ZYArchive: NSObject {
    
    @available(iOS, deprecated: 12.0)
    public class func archiveObject(object: AnyObject, filePaht: String) -> Bool {
        return NSKeyedArchiver.archiveRootObject(object, toFile: filePaht)
    }
    
    @available(iOS, deprecated: 12.0)
    public class func unarchiveObject(filePath: String) -> Any? {
        let object = NSKeyedUnarchiver.unarchiveObject(withFile: filePath)
        return object
    }

}
