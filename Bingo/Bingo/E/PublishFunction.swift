//
//  PublishFunction.swift
//  Bingo
//
//  Created by 侯懿玲 on 2022/5/22.
//

import Foundation
import UIKit    // 才能讀到UIViewController

/// 提示框
/// - Parameters:
///   - title: 提示框標題
///   - message: 提示訊息
///   - vc: 要在哪一個 UIViewController 上呈現
///   - actionHandler: 按下按鈕後要執行的動作，沒有的話，就填 nil
public func alert(title: String, message: String, closeText: String, vc: UIViewController, actionHandler: (() -> Void)?) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let closeAction = UIAlertAction(title: closeText, style: .default) { action in
        actionHandler?()
    }
    alertController.addAction(closeAction)
    vc.present(alertController, animated: true)
    
    /*
     let alertController = UIAlertController(title: "通知", message: "密碼設定成功", preferredStyle: .alert)
     let alertAction = UIAlertAction(title: "OK", style: .default) { alertAction in
     self.navigationController?.pushViewController(PasswordChangedVC(), animated: true)
     }
     alertController.addAction(alertAction)
     present(alertController, animated: true, completion: nil)
     */
}

extension UIViewController{
    
    /// push 跳頁Function
    func push(_ nextVC: UIViewController){
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    /// 顯示提示窗
    /// - Parameters:
    ///   - title: 標題
    ///   - message: 訊息
    ///   - handler: 點下 OK 之後做的事
    ///   - completion: 提示顯示完成後做的事
    ///   - withCancel: 需不需要取消按鈕
    func moreFuncAlert(title: String,
                       message: String? = nil,
                       handler: ((UIAlertAction)->Void)? = nil,
                       completion: (()->Void)? = nil,
                       withCancel: Bool) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: handler)
        let cancelAction = UIAlertAction (title: "Cancel", style: .cancel)
        
        alert.addAction(okAction)
        
        if withCancel {
            alert.addAction(cancelAction)
        }
        
        self.present(alert, animated: true, completion: completion)
    }
    
    /// 按空白處收回鍵盤
    func addGestureRecognizer() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        self.view.addGestureRecognizer(tap) // to Replace "TouchesBegan"
    }
    
    // 按空白處收回鍵盤
    @objc func dismissKeyBoard() {
        view.endEditing(true)
    }
}
