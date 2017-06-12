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
    var store:String
    var name: String
    var number: Int
    var price: Int
    var destination: String
    var purchacePlace: String
    var deadLine: String
    var buyer: UserData?
    var picture: String
    var offerPrice:Int
    
    var total: Int
    var broker: UserData?
    
    override init(){
        store = "init"
        name = "init"
        number = 0
        price = 0
        destination = "init"
        purchacePlace = "init"
        buyer = nil
        picture = "init"
        deadLine = "init"
        offerPrice = 0
        
        total = 0
        broker = nil
    }
    
    init(initStore: String, initName: String, initNumber: Int, initPrice: Int, initDestination: String, initPurchacePlace: String, initBuyer: UserData, initPicture: String, initDeadLine: String, initOfferPrice:Int) {
        store = initStore
        name = initName
        number = initNumber
        price = initPrice
        destination = initDestination
        purchacePlace = initPurchacePlace
        buyer = initBuyer
        picture = initPicture
        deadLine = initDeadLine
        offerPrice = initOfferPrice
        
        total = initNumber * initPrice
        broker = nil
    }
    
    required public convenience init(coder aDecoder: NSCoder) {
        self.init()
        self.store = aDecoder.decodeObject(forKey: "store") as! String!
        self.name = aDecoder.decodeObject(forKey: "name") as! String!
        self.number = aDecoder.decodeInteger(forKey: "number") as Int!
        self.price = aDecoder.decodeInteger(forKey: "price") as Int!
        self.destination = aDecoder.decodeObject(forKey: "destination") as! String!
        self.purchacePlace = aDecoder.decodeObject(forKey: "purchacePlace") as! String!
        self.buyer = aDecoder.decodeObject(forKey: "buyer") as! UserData!
        self.picture = aDecoder.decodeObject(forKey: "picture") as! String!
        self.deadLine = aDecoder.decodeObject(forKey: "deadLine") as! String!
        self.offerPrice = aDecoder.decodeInteger(forKey: "offerPrice") as Int!
        
        self.total = self.number * self.price
        self.broker = aDecoder.decodeObject(forKey: "broker") as! UserData!
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.store, forKey: "store")
        aCoder.encode(self.name, forKey: "name")
        aCoder.encodeCInt(Int32(self.number), forKey: "number")
        aCoder.encodeCInt(Int32(self.price), forKey: "price")
        aCoder.encode(self.destination, forKey: "destination")
        aCoder.encode(self.purchacePlace, forKey: "purchacePlace")
        aCoder.encode(self.deadLine, forKey: "deadLine")
        aCoder.encode(self.buyer, forKey: "buyer")
        aCoder.encode(self.picture, forKey: "picture")
        aCoder.encodeCInt(Int32(self.offerPrice), forKey: "offerPrice")

        aCoder.encodeCInt(Int32(self.total), forKey: "total")
        aCoder.encode(self.broker, forKey: "broker")
    }
    public func setBroker(brokerCatch: UserData)
    {
        broker = brokerCatch
    }
}
