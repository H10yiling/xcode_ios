//
//  PasswordListModel.swift
//  AutoFillTest
//
//  Created by 侯懿玲 on 2022/7/6.
//

import Foundation

struct PasswordListModel: Identifiable {
    
    var id = UUID().uuidString
    
    var title: String
    
    var account: String
    
    var password: String
}

class AutoFillArray {
    
    static let shared = AutoFillArray()
    
    // 這邊未來會改成撈資料庫資料
    var autofillArray: [PasswordListModel] =
    [
        PasswordListModel(title: "5music", account: "zaqxsw0218", password: "zaqxsw0218"),
        PasswordListModel(title: "5music", account: "zaqxsw0219", password: "0219"),
        PasswordListModel(title: "5music", account: "zaqxsw0220", password: "0220")
    ]
}

class IdAndURLText {
    static let shared = IdAndURLText()
    var text = String()
}
