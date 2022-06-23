//
//  BingoCVC.swift
//  Bingo
//
//  Created by 侯懿玲 on 2022/5/23.
//

import UIKit

class BingoCVC: UICollectionViewCell {

    @IBOutlet weak var vBackgroundColor: UIView!
    @IBOutlet weak var lbCellNumber: UILabel!
    @IBOutlet weak var btnCell: UIButton!
    
    var cellNumber: Int!
    
    var viewModelSecond: SecondViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // 設定
    func setBingoCVCInit(viewModel: SecondViewModel, index: Int, number: String, isSelected: Bool) {
        viewModelSecond = viewModel
        cellNumber = index
        lbCellNumber.text = number  // 顯示數值
        
        if isSelected == true {
            setSelected()
        } else {
            setSelectable()
        }
        
        vBackgroundColor.layer.cornerRadius = BDefine.m_iCollectionViewCellCornerRadius  // 設置背景底色圓角
        ivBackground.layer.cornerRadius = BDefine.m_iCollectionViewCellCornerRadius // 設置背景圓角
        btnCell.setTitle("", for: .normal)                                          // 清空按鈕標題
    }

    // 設定顯示狀態為被選擇狀態
    func setSelected() {
        vBackground.backgroundColor = .systemRed
        ivBackground.backgroundColor = .systemRed
        lbNumber.textColor = .white
    }
    
    // 設定顯示狀態為可選擇狀態
    func setSelectable() {
        vBackground.backgroundColor = .lightGray
        ivBackground.backgroundColor = .white
        lbNumber.textColor = .black
    }

    
}
