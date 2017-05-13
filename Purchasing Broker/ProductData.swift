//
//  ProductData.swift
//  Purchasing Broker
//
//  Created by Adam Hung on 2017/4/24.
//  Copyright © 2017年 Adam Hung. All rights reserved.
//

import Foundation

public class ProductData
    
{
    var name: String
    var number: Int
    var price: Int
    var destination: String
    var purchacePlace: String
    var deadLine: String
    var buyer: UserData
    var picture: String
    
    var total: Int
    var broker: UserData?
    
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
}
