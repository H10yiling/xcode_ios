//
//  CustomTextField.swift
//  test0903
//
//  Created by 侯懿玲
//

import UIKit

@IBDesignable
class CustomTextField: UITextField {
    
    // 設置左圖與左邊界的距離 Provides left padding for images
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var leftTextRect = super.leftViewRect(forBounds: bounds)
        leftTextRect.origin.x += leftPadding // 向右邊偏 " + "
        return leftTextRect
    }
    // 設置右視圖與右邊界的距離 Provides right padding for images
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rightTextRect = super.rightViewRect(forBounds: bounds)
        rightTextRect.origin.x -= rightPadding // 向左邊偏 " - "
        return rightTextRect
    }
    
    @IBInspectable var leftImage: UIImage? { didSet { updateView() } }
    
    @IBInspectable var leftPadding: CGFloat = 0
    @IBInspectable var rightPadding: CGFloat = 0
    
    @IBInspectable var color: UIColor = UIColor.lightGray { didSet { updateView() } }
    
    func updateView() {
        // 在左側添加圖像
        if let image = leftImage {
            leftViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            imageView.tintColor = color // Note:顯示成模板的那種灰色： "Render" to "Template"
            leftView = imageView
        }// 若要在右側添加圖像: Attributes inspect/View/Semantic -> Force Right-To-Left
        else{
            leftViewMode = UITextField.ViewMode.never
            leftView = nil
        }
        // 手動選擇符號顏色 Placeholder text color
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: color])
    }
}
//MARK: - 參考連結
/*
 @IBInspectable : 讓我們可以在 Attributes inspect 中直接調整屬性，但是我們需要在運行之後才能看到結果
 @IBDesignable : 將我們調整的結果直接顯示在畫面上。
 https://stackoverflow.com/questions/27903500/swift-add-icon-image-in-uitextfield
*/
