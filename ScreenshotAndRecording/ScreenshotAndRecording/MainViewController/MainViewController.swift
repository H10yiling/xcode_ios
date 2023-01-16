//
//  MainViewController.swift
//  ScreenshotAndRecording
//
//  Created by 侯懿玲 on 2022/11/24.
//

import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 螢幕截圖
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didTakeScreenshot(notification:)),
                                               name: UIApplication.userDidTakeScreenshotNotification,
                                               object: nil)
        // 螢幕錄影
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(isRecording(notification:)),
                                               name: UIScreen.capturedDidChangeNotification,
                                               object: nil)
    }

    // Alert
    func showAlertWith(title: String?,
                       message: String?,
                       vc: UIViewController,
                       confirmTitle: String,
                       confirm: (() -> Void)?) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: confirmTitle, style: .default) { action in
                confirm?()
            }
            alertController.addAction(confirmAction)
            vc.present(alertController, animated: true, completion: nil)
        }
    }
    
    // 螢幕截圖
    @objc func didTakeScreenshot(notification:Notification) -> Void {
        showAlertWith(title: "",
                      message: "偵測到螢幕截圖",
                      vc: self,
                      confirmTitle: "確定") {
            // do something
        }
    }
    
    // 螢幕錄影
    @objc func isRecording(notification:Notification) -> Void {
        for screen in UIScreen.screens {
            if (screen.isCaptured) {
                showAlertWith(title: "",
                              message: "偵測到螢幕錄影",
                              vc: self,
                              confirmTitle: "確定") {
                    // do something
                }
            }
        }
    }
}

