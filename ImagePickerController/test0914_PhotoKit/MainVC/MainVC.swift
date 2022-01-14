//
//  MainVC.swift
//  test0914_PhotoKit
//
//  Created by 侯懿玲 on 2021/9/15.
//

//import UIKit
//
//class MainVC: UIViewController {
//
//    @IBOutlet weak var imageView: UIImageView!
//    @IBOutlet weak var takePhoto: UIButton!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.navigationController?.setNavigationBarHidden(true, animated: false) // 隱藏指示條
//    }
//
//    @IBAction func didTapButton(btn: UIButton) {
//        let vc = UIImagePickerController()
//        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
//            let alertController = UIAlertController(title: "ERROR", message: "Device has no camera.", preferredStyle: .alert)
//            let okAction = UIAlertAction(title: "Alright", style: .default, handler: { (alert: UIAlertAction!) in
//            })
//            alertController.addAction(okAction)
//            self.present(alertController, animated: true, completion: nil)
//            print("ERROR：沒有相機功能！")
//        }
//        else { vc.sourceType = .camera }
//        vc.delegate = self
//        present(vc, animated: true)
//    }
//}
//
//extension MainVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        picker.dismiss(animated: true, completion: nil)
//        // 顯示 photo
//        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {return}
//        imageView.image = image
//    }
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        picker.dismiss(animated: true, completion: nil)
//    }
//}

// MARK: - 使用相機拍照、從相簿選取照片、新增裁剪編輯功能

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var takePhoto: UIButton!
    @IBOutlet weak var pickPhoto: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false) // 隱藏指示條
    }

    @IBAction func didTapButton(btn: UIButton) {
        let vc = UIImagePickerController()
        switch btn {
        case takePhoto:
            if !UIImagePickerController.isSourceTypeAvailable(.camera) {
                let alertController = UIAlertController(title: "ERROR", message: "Device has no camera.", preferredStyle: .alert)

                let okAction = UIAlertAction(title: "Alright", style: .default, handler: { (alert: UIAlertAction!) in
                })

                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                print("ERROR：沒有相機功能！")
            } else {
                vc.sourceType = .camera // 相機
            }

        default:
            vc.sourceType = .photoLibrary // 相簿
        }
        vc.delegate = self
//        vc.allowsEditing = true // 裁剪編輯器
        present(vc, animated: true)

    }
}

extension MainVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        picker.dismiss(animated: true, completion: nil)


        // 顯示原圖
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {return}
        imageView.image = image

//        // 顯示裁剪後的圖片
//        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage") ] as? UIImage{
//            imageView.image = image
//        }

    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

/*
 
 https://makeapppie.com/2014/12/04/swift-swift-using-the-uiimagepickercontroller-for-a-camera-and-photo-library/
*/
// MARK: -
//import UIKit
//import Photos
//
//class MainVC: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // 隱藏指示條
//        self.navigationController?.setNavigationBarHidden(true, animated: false)
//        if authorize(){
//            print("開始使用相機相簿")
//        }
//    }
//    func authorize() -> Bool {
//        let photoLibraryStatus = PHPhotoLibrary.authorizationStatus() //相簿請求
//
//        switch (photoLibraryStatus){ //判斷狀態
//        case (.authorized): //允許
//            return true
//        case (.notDetermined): //都還未決定,就請求授權
//            PHPhotoLibrary.requestAuthorization({ (photoLibraryStatus) in
//                DispatchQueue.main.async(execute: {
//                    _ = self.authorize()
//                })
//            })
//        default: //預設，如都不是以上狀態
//            DispatchQueue.main.async(execute: {
//                let alertController = UIAlertController(title: "提醒", message: "請點擊允許才可於APP內開啟相機及儲存至相簿", preferredStyle: .alert)
//                let canceAlertion = UIAlertAction(title: "取消", style: .cancel, handler: nil)
//                let settingAction = UIAlertAction(title: "設定", style: .default, handler: { (action) in
//                    let url = URL(string: UIApplication.openSettingsURLString)
//                    if let url = url, UIApplication.shared.canOpenURL(url) {
//                        if #available(iOS 10.0, *) {
//                            UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
//                                print("跳至設定")
//                            })
//                        } else {
//                            UIApplication.shared.openURL(url)
//                        }
//                    }
//                })
//                alertController.addAction(canceAlertion)
//                alertController.addAction(settingAction)
//                self.present(alertController, animated: true, completion: nil)
//            })
//        }
//        return false
//    }
//
//}


// MARK: -
//import UIKit
////import Photos
//class MainVC: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        let imagePicker = UIImagePickerController()
//        imagePicker.sourceType = .photoLibrary
//        self.present(imagePicker, animated: true, completion: nil)
//    }
//
//}
