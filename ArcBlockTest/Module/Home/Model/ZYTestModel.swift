//
//  ZYTestModel.swift
//  ArcBlockTest
//
//  Created by zY on 2020/11/4.
//

import Foundation
import SwiftyJSON

class ZYTestModel : NSObject, NSCoding{

    var content: String!
    var id: Int!
    var imgUrls: [String]!
    var link: String!
    var type: String!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        content = json["content:"].stringValue
        id = json["id"].intValue
        imgUrls = [String]()
        let imgUrlsArray = json["imgUrls"].arrayValue
        for imgUrlsJson in imgUrlsArray{
            imgUrls.append(imgUrlsJson.stringValue)
        }
        link = json["link"].stringValue
        type = json["type"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if content != nil{
            dictionary["content:"] = content
        }
        if id != nil{
            dictionary["id"] = id
        }
        if imgUrls != nil{
            dictionary["imgUrls"] = imgUrls
        }
        if link != nil{
            dictionary["link"] = link
        }
        if type != nil{
            dictionary["type"] = type
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
        content = aDecoder.decodeObject(forKey: "content:") as? String
        id = aDecoder.decodeObject(forKey: "id") as? Int
        imgUrls = aDecoder.decodeObject(forKey: "imgUrls") as? [String]
        link = aDecoder.decodeObject(forKey: "link") as? String
        type = aDecoder.decodeObject(forKey: "type") as? String
    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if content != nil{
            aCoder.encode(content, forKey: "content:")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if imgUrls != nil{
            aCoder.encode(imgUrls, forKey: "imgUrls")
        }
        if link != nil{
            aCoder.encode(link, forKey: "link")
        }
        if type != nil{
            aCoder.encode(type, forKey: "type")
        }

    }

}
