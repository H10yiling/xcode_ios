//
//  MainVC.swift
//
//  Created by 侯懿玲
//

// MARK: - 介紹客製化文字輸入框 2021/9/10
import UIKit

class MainVC: UIViewController {
    
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var txf: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}




// MARK: - 介紹客製化按鈕 2021/9/10
//import UIKit
//
//class MainVC: UIViewController {
//
//    @IBOutlet weak var btn: UIButton!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//}

//// MARK: - 轉畫面 2021/9/9
//import UIKit
//
//class MainVC: UIViewController {
//
//    @IBOutlet weak var lable: UILabel!
//    @IBOutlet weak var btn: UIButton!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//
//    // MARK: - 用 present 轉畫面
//    @IBAction func btnAct(_ sender: UIButton) {
//        // 告訴他下一個目的地是 SecondVC
//        let toSecondVC = SecondVC()
//        toSecondVC.delegate = self
//        present(toSecondVC, animated: true)
//    }
//}
//// MARK: - protocol
//// Extension 是為某個 Class 隔離出來的程式區塊
//// 設定 MainVC 會遵循 ChangeProtocol
//extension MainVC: ChangeProtocol{
//    func changeLableData(lableTxt:String){
//        print(lableTxt)
//        lable.text = lableTxt
//    }
//}


//// MARK: - 轉畫面 2021/9/7
//import UIKit
//
//class MainVC: UIViewController {
//
//    @IBOutlet weak var btn: UIButton!
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.navigationController?.hidesBarsOnTap = true // 按一下收起navigationBar
//    }
//    // MARK: - 用 push 轉畫面
//    @IBAction func btnAct1(_ sender: UIButton) {
//        // 告訴他下一個目的地是 SecondVC
//        let toSecondVC = SecondVC()
//        self.navigationController?.pushViewController(toSecondVC, animated: true)
//    }
//    // MARK: - 用 present 轉畫面
//    @IBAction func btnAct2(_ sender: UIButton) {
//        // 告訴他下一個目的地是 SecondVC
//        self.present(SecondVC(), animated: true, completion: nil)
//    }
//}

//// MARK: - alert 2021/9/3
//import UIKit
//
//class ViewController: UIViewController {
//
//    @IBOutlet weak var btn: UIButton!
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//    @IBAction func btnAct1(_ sender: Any) {
//
////        let alertController = UIAlertController(title: "alert title", message: "alert message", preferredStyle: .alert)
////        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
////        alertController.addAction(alertAction)
////        present(alertController, animated: true, completion: nil)
//
//        let alertController = UIAlertController(title: "alert title", message: "alert message", preferredStyle: .alert)
////        alertController.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { action in
////            //按下OK後會做的事情
////        }))
//
//        func merge(mergetitle: String, mergestyle: UIAlertAction.Style ,mergehandler: ((UIAlertAction) -> Void)?) {
//            alertController.addAction(UIAlertAction(title: mergetitle, style: mergestyle, handler: mergehandler))
//        }
//        merge(mergetitle: "Ok" , mergestyle: UIAlertAction.Style.default, mergehandler: { action in print("Ok")})
//        merge(mergetitle: "Cancel" , mergestyle: UIAlertAction.Style.cancel, mergehandler: { action in print("Cancel")})
//        merge(mergetitle: "Destructive" , mergestyle: UIAlertAction.Style.destructive, mergehandler: { action in print("Destructive")})
//
//        present(alertController, animated: true, completion: nil)
//    }
//
//    @IBAction func btnAct2(_ sender: Any) {
//
////        let alertController = UIAlertController(title: "提醒", message: "是否吃宵夜 ?", preferredStyle: .alert)
////        let alertOkAction = UIAlertAction(title: "吃", style: .default) { _ in
////           print("您按了”吃“")
////        }
////        alertController.addAction(alertOkAction)
////        let alertCancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
////        alertController.addAction(alertCancelAction)
////        present(alertController, animated: true, completion: nil)
//    }
//
//    @IBAction func btnAct3(_ sender: Any) {
//
//        let alertController = UIAlertController(title: "登入", message: "輸入電話和密碼", preferredStyle: .alert)
//        alertController.addTextField { textField in
//            textField.placeholder = "電話"
//            textField.keyboardType = UIKeyboardType.phonePad // 跳出電話鍵盤
//        }
//
//        alertController.addTextField { textField in
//            textField.placeholder = "密碼"
//            textField.isSecureTextEntry = true // 密碼隱藏
//        }
//
//        let alertOkAction = UIAlertAction(title: "確認", style: .default) { [unowned alertController] _ in
//            let phone = alertController.textFields?[0].text
//            let password = alertController.textFields?[1].text
//            print(phone as Any, password as Any)
//        }
//
//        alertController.addAction(alertOkAction)
//
//        let alertCancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
//
//        alertController.addAction(alertCancelAction)
//
//        present(alertController, animated: true, completion: nil)
//    }
//
//    @IBAction func btnAct4(_ sender: Any) {
//        let controller = UIAlertController(title: "選單", message: "請問你的年紀?", preferredStyle: .actionSheet)
//        let ages = ["0 - 19", "20 - 39", "40 - 59", "60 - 79", "80 - 99", "100 - 100以上"]
//        for age in ages {
//           let action = UIAlertAction(title: age, style: .default) { action in
//            print(action.title as Any)
//           }
//           controller.addAction(action)
//        }
//        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
//        controller.addAction(cancelAction)
//        present(controller, animated: true, completion: nil)
//    }
//
//    @IBAction func btnAct5(_ sender: Any) {
//
//        let alertController = UIAlertController(title: "title", message: "message", preferredStyle: .alert)
//        alertController.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { action in
//            //按下OK後會做的事情
//            print("您按了”吃“")
//        }))
//        present(alertController, animated: true, completion: nil)
//    }
//}
//
