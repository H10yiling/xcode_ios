//
//  SecondVC.swift
//
//  Created by 侯懿玲
//

// MARK: - 轉畫面 2021/9/10
import UIKit

class SecondVC: UIViewController {

    // 宣告這個畫面會遵循 ChangeProtocol，並請委任目標（delegate）去處理 ChangeProtocol 的事件
    var delegate: ChangeProtocol!
    
    @IBOutlet weak var btnToMainVC: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func btnPresent(_ sender: UIButton) {
        // 跳回 MainVC ( present ) // 畫面由下而上出現
        // 請委任目標去處理 changeLableData 事件
        delegate.changeLableData(lableTxt: "您已從 SecondVC 跳回 MainVC")
        dismiss(animated: true, completion: nil)
        
    }
}

// 宣告 ChangeProtocol 協定
@objc protocol ChangeProtocol {
    // 宣告 changeBtnData 事件
    @objc func changeLableData(lableTxt:String)
}

//// MARK: - 轉畫面 2021/9/9
//import UIKit
//
//class SecondVC: UIViewController {
//
//    // 宣告這個畫面會遵循 ChangeProtocol，並請委任目標（delegate）去處理 ChangeProtocol 的事件
//    var delegate: ChangeProtocol!
//
//    @IBOutlet weak var btnToMainVC: UIButton!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//    @IBAction func btnPresent(_ sender: UIButton) {
//        // 跳回 MainVC ( present ) // 畫面由下而上出現
//        // 請委任目標去處理 changeLableData 事件
//        delegate.changeLableData(lableTxt: "您已從 SecondVC 跳回 MainVC")
//        dismiss(animated: true, completion: nil)
//
//    }
//}
//
//// 宣告 ChangeProtocol 協定
//@objc protocol ChangeProtocol {
//    // 宣告 changeBtnData 事件
//    @objc func changeLableData(lableTxt:String)
//}


//// MARK: - 轉畫面 2021/9/7
//import UIKit
//
//class SecondVC: UIViewController {
//
//    @IBOutlet weak var btnToMainVC: UIButton!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//        
//    }
//    @IBAction func btnPush(_ sender: UIButton) {
//        // 跳回 MainVC ( push ) // 畫面左右跳頁 // 有 navigation Bars
//
//        self.navigationController?.popViewController(animated: true)
//    }
//    @IBAction func btnPresent(_ sender: UIButton) {
//        // 跳回 MainVC ( present ) // 畫面由下而上出現
//        self.dismiss(animated: true, completion: nil)
//    }
//    
//}

