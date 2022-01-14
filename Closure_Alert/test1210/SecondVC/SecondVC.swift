//
//  SecondVC.swift
//  test1210
//
//  Created by 侯懿玲 on 2021/12/10.
//

import UIKit

//MARK: - protocol

//import UIKit
//
//class SecondVC: UIViewController {
//
//    var tagg: Int?
//
//    var delegate: Test? //step２: 宣告委任的對象，delegate遵循Test協定
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        delegate?.a(aa: "Hi") //step4: 委任的對象去執行方法
//
//    }
//
//
//}
//
//@objc protocol Test { //step1: 宣告 protocol 協定
//    func a (aa: String) //step1: Test protocol 方法 a
//
//}

class SecondVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alertTest{
            print("123")
        }
    }
    func alertTest(OK:@escaping()->Void){
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        let ok = UIAlertAction(title: "", style: .default) { okok in
            OK()
        }
        let close = UIAlertAction(title: "", style: .cancel) { UIAlertAction in
            exit(0)
        }
        alert.addAction(ok)
        alert.addAction(close)
        self.navigationController?.pushViewController(alert, animated: true)
    }
}

