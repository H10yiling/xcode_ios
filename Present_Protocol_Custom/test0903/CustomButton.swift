//
//  CustomButton.swift
//  test0903
//
//  Created by 侯懿玲 on 2021/9/10.
//

import UIKit

class CustomButton: UIButton {
    // MARK:- UIButton 圓角設定
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    // MARK:- UIButton 框線設定 (可在 Attributes inspect 中直接調整屬性)
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        } set {
            layer.borderWidth = newValue
        }
    }
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor!)
        } set {
            layer.borderColor = newValue.cgColor
        }
    }
}

//MARK: -
/*
 @IBInspectable : 讓我們可以在 Attributes inspect 中直接調整屬性，但是我們需要在運行之後才能看到結果
 @IBDesignable : 將我們調整的結果直接顯示在畫面上。
*/
