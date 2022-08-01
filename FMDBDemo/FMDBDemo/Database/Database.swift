//
//  Database.swift
//  FMDBDemo
//
//  Created by 呂淳昇 on 2022/6/29.
//

import Foundation
import FMDB

class Database:NSObject{
    static let shared = Database()
    private let encryptKey:String = "123"
    var fileName:String = "testDB.db"
    var filePath:String = ""
    var database:FMDatabase!
    
    private override init(){
        super.init()
        self.filePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] + "/" + self.fileName
        print(self.filePath)
    }
    deinit{
        print("deinit:\(self)")
    }
    //是否連線
    func connectDB() -> Bool{
        self.database = FMDatabase(path: self.filePath)
        if self.database.open(){
            database.setKey(encryptKey)
            return true
        }else{
            return false
        }
    }
    //建立資料表
    func createTable(){
        let fileManager:FileManager = FileManager.default
        
        if !fileManager.fileExists(atPath: self.filePath){
            if connectDB(){
                let createTable = "CREATE TABLE Account(account Varchar(30) NOT NULL PRIMARY KEY,password Varchar(30) NOT NULL)"
                self.database.executeStatements(createTable)
                print("file copy to:\(self.filePath)")
            }else{
                print("file already exist at :\(self.filePath)")
            }
        }
    }
    //新增資料
    func insertRow(withAccount account:String,withPassword password:String){
        if connectDB(){
            let insertRow = "INSERT INTO Account(account,password) VALUES(?,?)"
            
            if !self.database.executeUpdate(insertRow, withArgumentsIn: [account,password]){
                print("insert Row failed")
                print(database.lastError(),database.lastErrorMessage())
            }
            self.database.close()
        }
    }
    //顯示資料
    func presentRows() -> [Account]{
        var accountDatas:[Account] = [Account]()
        
        if connectDB(){
            let selectAll = "SELECT * FROM Account"
            do{
                let dataLists:FMResultSet = try database.executeQuery(selectAll, values: nil)
                while dataLists.next(){
                    let account:Account = Account(account: dataLists.string(forColumn: "account")!, password: dataLists.string(forColumn: "password")!)
                    accountDatas.append(account)
                }
            }
            catch{
                print("123",error.localizedDescription)
            }
        }
        return accountDatas
    }
}
