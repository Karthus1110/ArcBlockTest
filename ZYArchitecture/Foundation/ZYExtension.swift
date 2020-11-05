//
//  ZYExtension.swift
//  PixHall
//
//  Created by zY on 2019/7/11.
//  Copyright © 2019 zY. All rights reserved.
//

import Foundation
import UIKit

extension Array {
    func objectAtIndexSafely(index: Int) -> Element? {
        if index >= self.count {
            return nil
        }
        return self[index]
    }
}

extension UILabel {
    convenience init(font: UIFont, textColor: UIColor) {
        self.init()
        self.font = font
        self.textColor = textColor
    }
}

extension Notification.Name {
    // 已购买Pro
    static let isPro = Notification.Name(rawValue:"kIsPro")
    
    // 新增文案
    static let addPrompt = Notification.Name(rawValue:"addPrompt")

}

extension String {
    
}

extension UIColor {
    convenience init?(red: Int, green: Int, blue: Int, transparency: CGFloat = 1) {
        guard red >= 0 && red <= 255 else { return nil }
        guard green >= 0 && green <= 255 else { return nil }
        guard blue >= 0 && blue <= 255 else { return nil }

        var trans = transparency
        if trans < 0 { trans = 0 }
        if trans > 1 { trans = 1 }

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: trans)
    }
    
    convenience init?(hexString: String, transparency: CGFloat = 1) {
        var string = ""
        if hexString.lowercased().hasPrefix("0x") {
            string =  hexString.replacingOccurrences(of: "0x", with: "")
        } else if hexString.hasPrefix("#") {
            string = hexString.replacingOccurrences(of: "#", with: "")
        } else {
            string = hexString
        }

        if string.count == 3 { // convert hex to 6 digit format if in short format
            var str = ""
            string.forEach { str.append(String(repeating: String($0), count: 2)) }
            string = str
        }

        guard let hexValue = Int(string, radix: 16) else { return nil }

        var trans = transparency
        if trans < 0 { trans = 0 }
        if trans > 1 { trans = 1 }

        let red = (hexValue >> 16) & 0xff
        let green = (hexValue >> 8) & 0xff
        let blue = hexValue & 0xff
        self.init(red: red, green: green, blue: blue, transparency: trans)
    }
    
}

extension UIView {
    /// X
      public var x: CGFloat{
          get{
              return self.frame.origin.x
          }
          set{
              var r = self.frame
              r.origin.x = newValue
              self.frame = r
          }
      }
      
      /// Y
      public var y: CGFloat{
          get{
              return self.frame.origin.y
          }
          set{
              var r = self.frame
              r.origin.y = newValue
              self.frame = r
          }
      }
      
      /// 右边界的X值
      public var rightX: CGFloat{
          get{
              return self.x + self.width
          }
          set{
              var r = self.frame
              r.origin.x = newValue - frame.size.width
              self.frame = r
          }
      }
      
      /// 下边界的Y值
      public var bottomY: CGFloat{
          get{
              return self.y + self.height
          }
          set{
              var r = self.frame
              r.origin.y = newValue - frame.size.height
              self.frame = r
          }
      }
      
      /// centerX
      public var centerX : CGFloat{
          get{
              return self.center.x
          }
          set{
              self.center = CGPoint(x: newValue, y: self.center.y)
          }
      }
      
      /// centerY
      public var centerY : CGFloat{
          get{
              return self.center.y
          }
          set{
              self.center = CGPoint(x: self.center.x, y: newValue)
          }
      }
      
      /// width
      public var width: CGFloat{
          get{
              return self.frame.size.width
          }
          set{
              var r = self.frame
              r.size.width = newValue
              self.frame = r
          }
      }
      /// height
      public var height: CGFloat{
          get{
              return self.frame.size.height
          }
          set{
              var r = self.frame
              r.size.height = newValue
              self.frame = r
          }
      }
      
      /// origin
      public var origin: CGPoint{
          get{
              return self.frame.origin
          }
          set{
              self.x = newValue.x
              self.y = newValue.y
          }
      }
      
      /// size
      public var size: CGSize{
          get{
              return self.frame.size
          }
          set{
              self.width = newValue.width
              self.height = newValue.height
          }
      }
}
