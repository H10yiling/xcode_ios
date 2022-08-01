//
//  MainVC.swift
//  FMDBDemo
//
//  Created by 呂淳昇 on 2022/6/29.
//

import UIKit
import CloudKit
class MainVC: UIViewController {
    @IBOutlet weak var tfInputAccount: UITextField!
    @IBOutlet weak var tfInputPassword: UITextField!
    @IBOutlet weak var tvInformation: UITableView!
    var accountDataArray:[Account] = [Account]()
    private var db = CKContainer(identifier: "iCloud.iOS.CoreDataDemo").privateCloudDatabase
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//         fetchItems()
        setTableView()
        reloadData()
        
    }
    @IBAction func insertRow(_ sender: Any) {
                Database.shared.insertRow(withAccount: tfInputAccount.text!, withPassword: tfInputPassword.text!)
                reloadData()
//        saveItem(account: tfInputAccount.text!, password: tfInputPassword.text!)
    }
    
    @objc func saveItem(account:String,password:String){
        let record = CKRecord(recordType: "Member")
        record.setValue(account, forKey: "account")
        record.setValue(password, forKey: "password")
        db.save(record) { record, Error in
            if record != nil && Error == nil{
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.fetchItems()
                    print("saved")
                }
            }else{
                if let ckerror = Error as? CKError {
                    if ckerror.code == CKError.requestRateLimited {
//                        let retryInterval = ckerror.userInfo[CKErrorRetryAfterKey] as? TimeInterval
//                        DispatchQueue.main.async {
//                            Timer.scheduledTimer(timeInterval: retryInterval!, target: self, selector: #selector(self.files_saveNotes), userInfo: nil, repeats: false)
//                        }
                    } else if ckerror.code == CKError.zoneBusy {
//                        let retryInterval = ckerror.userInfo[CKErrorRetryAfterKey] as? TimeInterval
//                        DispatchQueue.main.async {
//                            Timer.scheduledTimer(timeInterval: retryInterval!, target: self, selector: #selector(self.files_saveNotes), userInfo: nil, repeats: false)
//                        }
                    } else if ckerror.code == CKError.limitExceeded {
//                        let retryInterval = ckerror.userInfo[CKErrorRetryAfterKey] as? TimeInterval
//                        DispatchQueue.main.async {
//                            Timer.scheduledTimer(timeInterval: retryInterval!, target: self, selector: #selector(self.files_saveNotes), userInfo: nil, repeats: false)
//                        }
                    } else if ckerror.code == CKError.notAuthenticated {
                        print("ckerror.code == CKError.notAuthenticated ")
                       // NotificationCenter.default.post(name: Notification.Name("noCloud"), object: nil, userInfo: nil)
                    } else if ckerror.code == CKError.networkFailure {
                        print(" ckerror.code == CKError.networkFailure ")
                        // NotificationCenter.default.post(name: Notification.Name("networkFailure"), object: nil, userInfo: nil)
                    } else if ckerror.code == CKError.networkUnavailable {
                      //  NotificationCenter.default.post(name: Notification.Name("noWiFi"), object: nil, userInfo: nil)
                    } else if ckerror.code == CKError.quotaExceeded {
                    //    NotificationCenter.default.post(name: Notification.Name("quotaExceeded"), object: nil, userInfo: nil)
                    } else if ckerror.code == CKError.partialFailure {
                      //  NotificationCenter.default.post(name: Notification.Name("partialFailure"), object: nil, userInfo: nil)
                    } else if (ckerror.code == CKError.internalError || ckerror.code == CKError.serviceUnavailable) {
                      //  NotificationCenter.default.post(name: Notification.Name("serviceUnavailable"), object: nil, userInfo: nil)
                    }
                }
            }
        }
        
    }
    //    func test(){
    //        CKContainer.default().accountStatus { accountStatus, error in
    //            if accountStatus == .noAccount {
    //                DispatchQueue.main.async {
    //                    let message =
    //                        """
    //                        Sign in to your iCloud account to write records.
    //                        On the Home screen, launch Settings, tap Sign in to your
    //                        iPhone/iPad, and enter your Apple ID. Turn iCloud Drive on.
    //                        """
    //                    let alert = UIAlertController(
    //                        title: "Sign in to iCloud",
    //                        message: message,
    //                        preferredStyle: .alert)
    //                    alert.addAction(UIAlertAction(title: "OK", style: .cancel))
    //                    self.present(alert, animated: true)
    //                }
    //            }else if accountStatus == .a
    //            else {
    //                // Save your record here.
    //            }
    //        }
    //    }
    func fetchItems(){
        var accountList = [Account]()
        let query = CKQuery(recordType: "Member", predicate: NSPredicate(value: true))
        DispatchQueue.global().async {
            if #available(iOS 15.0, *) {
                self.db.fetch(withQuery: query) { result in
                    switch result{
                    case .success(let result):
                        result.matchResults.compactMap { $0.1 }.forEach {
                            switch $0{
                            case .success(let record):
                                if let account = Account.fromRecord(record){
                                    print("success",record)
                                    accountList.append(account)
                                    self.accountDataArray = accountList
                                    DispatchQueue.main.sync {
                                        self.reloadData()
                                    }
                                    print(self.accountDataArray)
                                }
                            case .failure(let error):
                                print("error",error)
                            }
                        }
                    case .failure(let error):
                        print("rrrrr",error)
                    }
                }
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    func toRecord(){
        for i in 0..<accountDataArray.count{
            let record = CKRecord(recordType: "Member")
            record["account"] = accountDataArray[i].account
            record["password"] = accountDataArray[i].password
            db.save(record) { record, Error in
                if record != nil && Error == nil{
                    print("saved!!")
                }else if Error != nil{
                    print(Error)
                }
            }
        }
    }
    
    func reloadData(){
          accountDataArray = Database.shared.presentRows()
        self.tvInformation.reloadData()
    }
    func setTableView(){
        tvInformation.delegate = self
        tvInformation.dataSource = self
        let informationNib = UINib(nibName: "InformationTVC", bundle: nil)
        self.tvInformation.register(informationNib, forCellReuseIdentifier: "InformationTVC")
    }
    
}
extension MainVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:InformationTVC = self.tvInformation.dequeueReusableCell(withIdentifier: "InformationTVC", for: indexPath)as! InformationTVC
        cell.lbAccount.text = accountDataArray[indexPath.row].account
        cell.lbPassword.text = accountDataArray[indexPath.row].password
        return cell
    }
    
    
}
