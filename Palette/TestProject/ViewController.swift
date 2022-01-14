//
//  ViewController.swift
//  TestProject
//
//  Created by 侯懿玲 on 2021/7/8.
//


import UIKit

class ViewController: UIViewController {
//  Outlet
    @IBOutlet weak var Show: UIView!
    
    @IBOutlet weak var redslider: UISlider!
    @IBOutlet weak var greenslider: UISlider!
    @IBOutlet weak var blueslider: UISlider!
    
    @IBOutlet weak var redtext: UITextField!
    @IBOutlet weak var greentext: UITextField!
    @IBOutlet weak var bluetext: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // 按空白處收回鍵盤
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        self.view.addGestureRecognizer(tap) // to Replace "TouchesBegan"
    }
// 按空白處收回鍵盤
    @objc func dismissKeyBoard() {
        self.view.endEditing(true)
    }
 
//  Action
//  textfield改變slider
    @IBAction func TextFieldToSilder(textField: UITextField) {
        guard let stringColor = textField.text else {return}
        guard let intColor = Int(stringColor)else {return}
        switch textField {
        case redtext:
            redslider.setValue(Float(intColor), animated: true)
        case greentext:
            greenslider.setValue(Float(intColor), animated: true)
        case bluetext:
            blueslider.setValue(Float(intColor), animated: true)
        default: break
        }
    }

//  slider改變textfield
    @IBAction func SliderToTextField(_ sender: Any) {
        redtext.text = "\(Int(redslider.value))"
        greentext.text = "\(Int(greenslider.value))"
        bluetext.text = "\(Int(blueslider.value))"
    }

//  顯示顏色
    @IBAction func colorchange(_ sender: Any){
        Show.backgroundColor = UIColor(red: CGFloat(redslider.value)/255, green: CGFloat(greenslider.value)/255, blue: CGFloat(blueslider.value)/255, alpha: 1)
    }
}

extension ViewController : UITextFieldDelegate {
    //新的字串可判斷字串長度，決定是否可以輸入。回傳 true 允許文字輸入，回傳 false 讓文字不能輸入。
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       var result = false
       if let text = textField.text, let range = Range(range, in: text) {
           let newText = text.replacingCharacters(in: range, with: string)
           if newText.count < 4 {
              result = true
           }
       }
       return result
    }
}
