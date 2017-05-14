//
//  ProductData.swift
//  Purchasing Broker
//
//  Created by Adam Hung on 2017/4/24.
//  Copyright © 2017年 Adam Hung. All rights reserved.
//

import Foundation

public class ProductData: NSObject, NSCoding
    
{
    var name: String
    var number: Int
    var price: Int
    var destination: String
    var purchacePlace: String
    var deadLine: String
    var buyer: UserData?
    var picture: String
    
    var total: Int
    var broker: UserData?
    
    override init(){
        name = "init"
        number = 0
        price = 0
        destination = "init"
        purchacePlace = "init"
        buyer = nil
        picture = "init"
        deadLine = "init"
        
        total = 0
        broker = nil
    }
    
    init(initName: String, initNumber: Int, initPrice: Int, initDestination: String, initPurchacePlace: String, initBuyer: UserData, initPicture: String, initDeadLine: String) {
        name = initName
        number = initNumber
        price = initPrice
        destination = initDestination
        purchacePlace = initPurchacePlace
        buyer = initBuyer
        picture = initPicture
        deadLine = initDeadLine
        
        total = initNumber * initPrice
        broker = nil
    }
    
    required public convenience init(coder aDecoder: NSCoder) {
        self.init()
        self.name = aDecoder.decodeObject(forKey: "name") as! String!
        self.number = aDecoder.decodeInteger(forKey: "number") as Int!
        self.price = aDecoder.decodeInteger(forKey: "price") as Int!
        self.destination = aDecoder.decodeObject(forKey: "destination") as! String!
        self.purchacePlace = aDecoder.decodeObject(forKey: "purchacePlace") as! String!
        self.buyer = aDecoder.decodeObject(forKey: "buyer") as! UserData!
        self.picture = aDecoder.decodeObject(forKey: "picture") as! String!
        self.deadLine = aDecoder.decodeObject(forKey: "deadLine") as! String!
        
        self.total = self.number * self.price
        self.broker = nil
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encodeCInt(Int32(self.number), forKey: "number")
        aCoder.encodeCInt(Int32(self.price), forKey: "price")
        aCoder.encode(self.destination, forKey: "destination")
        aCoder.encode(self.purchacePlace, forKey: "purchacePlace")
        aCoder.encode(self.deadLine, forKey: "deadLine")
        aCoder.encode(self.buyer, forKey: "buyer")
        aCoder.encode(self.picture, forKey: "picture")

        aCoder.encodeCInt(Int32(self.total), forKey: "total")
        aCoder.encode(self.broker, forKey: "broker")
    }
}
