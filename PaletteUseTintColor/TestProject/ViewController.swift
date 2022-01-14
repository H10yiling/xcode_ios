//
//  ViewController.swift
//  TestProject
//
//  Created by 侯懿玲 on 2021/7/4.
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
        // Do any additional setup after loading the view.
        redslider.tintColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        greenslider.tintColor = #colorLiteral(red: 0, green: 1, blue: 0, alpha: 1)
        blueslider.tintColor = #colorLiteral(red: 0, green: 0, blue: 1, alpha: 1)
        
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
    @IBAction func textFieldChangeRed(textField: UITextField) {
        if let stringValue = textField.text{
            if let intValue = Int(stringValue){
                redslider.setValue(Float(intValue), animated: true)
            }
        }
    }
    @IBAction func textFieldChangeGreen(textField: UITextField) {
        if let stringValue = textField.text{
            if let intValue = Int(stringValue){
                greenslider.setValue(Float(intValue), animated: true)
            }
        }
    }
    @IBAction func textFieldChangeBlue(textField: UITextField) {
        if let stringValue = textField.text{
            if let intValue = Int(stringValue){
                blueslider.setValue(Float(intValue), animated: true)
            }
        }
    }
    
//  slider改變textfield
    @IBAction func actredsli(_ sender: Any) {
        redtext.text = String(Int(redslider.value))
    }
    @IBAction func actgreensli(_ sender: Any) {
        greentext.text = String(Int(greenslider.value))
    }
    @IBAction func actbluesli(_ sender: Any) {
        bluetext.text = String(Int(blueslider.value))
    }
    
//  顯示顏色
    @IBAction func colorchange(_ sender: Any){
        Show.backgroundColor = UIColor(red: CGFloat(redslider.value)/255, green: CGFloat(greenslider.value)/255, blue: CGFloat(blueslider.value)/255, alpha: 1)
    }

//  生命週期
    override func viewWillAppear(_ animated:Bool) {
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated:Bool) {
        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated:Bool) {
        // Do any additional setup after loading the view.
    }
    override func viewDidDisappear(_ animated:Bool) {
        // Do any additional setup after loading the view.
    }
}
