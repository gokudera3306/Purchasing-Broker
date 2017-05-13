//
//  UserData.swift
//  Purchasing Broker
//
//  Created by Adam Hung on 2017/4/25.
//  Copyright © 2017年 Adam Hung. All rights reserved.
//

import Foundation

public class UserData:NSObject
{
    var name: String
    var account: String
    var password: String
    var hometown: String
    
    var credit: Int

    init(initName: String, initAccount: String, initPassword: String, initHometown: String, initCredit: Int) {
        name = initName
        account = initAccount
        password = initPassword
        hometown = initHometown
        
        credit = initCredit
    }
}
