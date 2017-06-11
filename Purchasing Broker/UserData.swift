//
//  UserData.swift
//  Purchasing Broker
//
//  Created by Adam Hung on 2017/4/25.
//  Copyright © 2017年 Adam Hung. All rights reserved.
//

import Foundation

public class UserData:NSObject,NSCoding
{
    var name: String
    var account: String
    var password: String
    var hometown: String
    var phone: String
    
    var credit: Int

    override init(){
        name = "init"
        account = "init"
        password = "init"
        hometown = "init"
        credit = 0
        phone = "init"
    }
    
    init(initName: String, initAccount: String, initPassword: String, initHometown: String, initCredit: Int, initPhone: String) {
        name = initName
        account = initAccount
        password = initPassword
        hometown = initHometown
        phone = initPhone
        credit = initCredit
    }
    
    required public convenience init(coder aDecoder: NSCoder) {
        self.init()
        self.name = aDecoder.decodeObject(forKey: "name") as! String!
        self.account = aDecoder.decodeObject(forKey: "account") as! String!
        self.password = aDecoder.decodeObject(forKey: "password") as! String!
        self.hometown = aDecoder.decodeObject(forKey: "hometown") as! String!
        self.phone = aDecoder.decodeObject(forKey: "phone") as! String!

        self.credit = aDecoder.decodeInteger(forKey: "credit") as Int!
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.account, forKey: "account")
        aCoder.encode(self.password, forKey: "password")
        aCoder.encode(self.hometown, forKey: "hometown")
        aCoder.encode(self.phone, forKey: "phone")
        
        aCoder.encodeCInt(Int32(self.credit), forKey: "credit")
    }
}
