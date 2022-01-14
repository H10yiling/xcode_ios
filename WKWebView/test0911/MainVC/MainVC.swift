//
//  MainVC.swift
//  test0911
//
//  Created by 侯懿玲 on 2021/9/11.
//

import UIKit
import WebKit

class MainVC: UIViewController {
    
    @IBOutlet var webView: WKWebView!
    
        override func viewDidLoad() {
            super.viewDidLoad()
            webView.load(URLRequest(url: URL(string: "https://ithelp.ithome.com.tw/users/20140364")!))
        }
    // 上一頁
    @IBAction func backAction(_ sender: UIButton) {
        if webView?.goBack() == nil {
            print("No more page to back")
        }

    }
    // 下一頁
    @IBAction func forwardAction(_ sender: UIButton) {
        if webView?.goForward() == nil {
            print("No more page to forward")
        }
    }

}
