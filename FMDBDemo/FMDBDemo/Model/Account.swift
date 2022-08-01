//
//  Account.swift
//  FMDBDemo
//
//  Created by 呂淳昇 on 2022/6/29.
//

import Foundation
import CloudKit

class Account:NSObject{
    var account:String
    var password:String
    
    init(account:String,password:String){
        self.account = account
        self.password = password
    }
//    func toDictionary() ->[String:Any]{
//        return["account":account,"password":password]
//    }
    static func fromRecord(_ record:CKRecord) -> Account?{
        guard let account = record.value(forKey: "account") as? String,let password = record.value(forKey: "password") as? String
        else{
            return nil
        }
        return Account(account: account, password: password)
    }
}
