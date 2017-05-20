//
//  dataBaseData.swift
//  Purchasing Broker
//
//  Created by 連翊涵 on 2017/5/19.
//  Copyright © 2017年 Adam Hung. All rights reserved.
//

import Foundation
public class dataBaseData: NSObject, NSCoding
{
    var store:String
    var name: String
    var price: Int
    var purchacePlace: String
    var picture: String

    
    override init(){
        store = "init"
        name = "init"
        price = 0
        purchacePlace = "init"
        picture = "init"
    }
    
    init(initStore: String, initName: String,initPrice: Int, initPurchacePlace: String, initPicture: String) {
        store = initStore
        name = initName
        price = initPrice
        purchacePlace = initPurchacePlace
        picture = initPicture

    }
    
    required public convenience init(coder aDecoder: NSCoder) {
        self.init()
        self.store = aDecoder.decodeObject(forKey: "store") as! String!
        self.name = aDecoder.decodeObject(forKey: "name") as! String!
        self.price = aDecoder.decodeInteger(forKey: "price") as Int!
        self.purchacePlace = aDecoder.decodeObject(forKey: "purchacePlace") as! String!
        self.picture = aDecoder.decodeObject(forKey: "picture") as! String!
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.store, forKey: "store")
        aCoder.encode(self.name, forKey: "name")
        aCoder.encodeCInt(Int32(self.price), forKey: "price")
        aCoder.encode(self.purchacePlace, forKey: "purchacePlace")
        aCoder.encode(self.picture, forKey: "picture")    }
}
