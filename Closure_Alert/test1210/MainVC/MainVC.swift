//
//  MainVC.swift
//  test1210
//
//  Created by 侯懿玲 on 2021/12/10.
//
//MARK: - protocol

//import UIKit
//
//class MainVC: UIViewController {
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        let nextVC = SecondVC()
//        nextVC.delegate = self
//        self.navigationController?.pushViewController(nextVC, animated: true)
//    
//    }
//    
//}
//
//extension MainVC : Test {
//    
//    func a(aa: String) {
//        <#code#>
//    }
//    
//}

//MARK: - Closure閉包

import UIKit

class MainVC: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alertFunc {
            print("Yes")
        }
        
        alertFunc {
            print("NO")
        }
        
    }

    func alertFunc(OKAction: @escaping(() -> Void)){
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            OKAction() // 可做變化，
        }
        let cancel = UIAlertAction(title: "", style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func alertFunc1(){
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            print("Yes")
        }
        let cancel = UIAlertAction(title: "", style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func alertFunc2(){
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            print("NO")
        }
        let cancel = UIAlertAction(title: "", style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
        
    }
}
