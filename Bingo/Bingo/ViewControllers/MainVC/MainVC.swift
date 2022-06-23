//
//  MainVC.swift
//  Bingo
//
//  Created by 侯懿玲 on 2022/5/22.
//

import UIKit
import Combine

class MainVC: UIViewController {
    
    @IBOutlet weak var lbBingoTitle: UILabel!
    @IBOutlet weak var lbInputRule: UILabel!
    @IBOutlet weak var txfInputValue: UITextField!
    @IBOutlet weak var btnStartGame: UIButton!
    
    let viewModelMain = MainViewModel()
    var viewModelSecond: SecondViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMainVCInit()
        monitorUIControlEvent()
        addGestureRecognizer()
    }
    
    /// MainVC初始化設定
    func setMainVCInit() {
        
        // 標題設定
        lbBingoTitle.text = "賓果遊戲"
        
        // 規則設定
        lbInputRule.text = "請輸入值 (範圍：3~10)"
        
        // 輸入匡樣式 鍵盤樣式 純數字
        txfInputValue.keyboardType = .numberPad
        txfInputValue.text = ""
        
        // 按鈕設定
        btnStartGame.setTitle("進入遊戲", for: .normal)
    }
    
    /// 設置監聽 UI 事件
    func monitorUIControlEvent() {
        
        /*
         publisher(for: <#T##UIControl.Event#>)
         .sink(receiveValue: <#T##((UIControl) -> Void)##((UIControl) -> Void)##(UIControl) -> Void#>)
         .store(in: &<#T##Set<AnyCancellable>#>)
         */
        
        txfInputValue.publisher(for: .editingDidEnd).sink { [unowned self] _ in
            viewModelMain.setBingoSize(index: txfInputValue.text)
        }.store(in: &viewModelMain.aryMonitorStore)
        
        btnStartGame.publisher(for: .touchUpInside).sink { [unowned self] _ in
            // #1
            // txf範圍是3-10
            viewModelMain.checkValue()
                .filter { $0 == true }
                .sink { _ in} receiveValue: { _ in
                    let bingoGameViewModel = SecondViewModel(bingoGameSize: viewModelMain.bingoStartSize)   // 以遊戲盤大小數值建立 ViewModel
                    let gameViewController = SecondVC().withViewModel(viewModel: bingoGameViewModel)        // 建立遊戲畫面並傳入 ViewModel
                    push(gameViewController)
                }.store(in: &viewModelMain.aryMonitorStore)
            
            // txf範圍有誤
            viewModelMain.checkValue()
                .filter { $0 == false }
                .sink { _ in} receiveValue: { _ in
                    // X範圍為3~10，超過此範圍顯示提示訊息
                    alert(title: "", message: "賓果盤範圍是3-10", closeText: "OK", vc: self) {
                        txfInputValue.text = ""
                    }
                }
        }.store(in: &viewModelMain.aryMonitorStore)
        
    }

}

// MARK: -
/*
 
 // #1
 filter 篩選：過濾值是否滿足，是：返回 Future，否：返回錯誤
 
 .filter { $0 == true }
 $0 是傳遞給閉包的第一個參數 $1 是第二個參數
 https://stackoverflow.com/questions/64976084/swift-combine-conditional-flatmap-results
 
 在收到一個 cancel() 後，後續調用不應執行任何操作
 
 */
