//
//  SecondViewModel.swift
//  Bingo
//
//  Created by 侯懿玲 on 2022/5/22.
//

import Foundation
import Combine  // AnyCancellable才可使用

class SecondViewModel {
    
    /// bingoGame模式
    ///  - 遊戲模式 game
    ///  - 輸入模式 setUp
    enum BingoGameMode {
        case game
        case setUp
    }
    
    /// 儲存監聽
    var aryMonitorStore: Set<AnyCancellable> = []
    
    /// 賓果盤size
    var gameSize = 0
    
    /// 暫存亂數產生的數值陣列
    var aryTempCellNumber: [String] = []
    
    /// BingoGameMode 執行模式
    @Published var gameMode: BingoGameMode = .setUp

    
    /// Bool 模式選擇
    /// - true  : 遊戲
    /// - false : 輸入
    @Published var boolGameMode: Bool = true
    
    /// 顯示的數字陣列
    @Published var aryCellNumber: [String] = []
    
    init(bingoGameSize: Int) {
        gameSize = bingoGameSize
    }
    
    /// 依據segmentSelectedIndex的值，去設定遊戲模式。 game or setUp
    func setBingoGameMode(segmentIndex: Int) {
        switch segmentIndex {
            case 0:
                gameMode = .game
            case 1:
                gameMode = .setUp
            default:
                return
        }
        print("SecondViewModel gameMode: ", gameMode)
    }
    
    /// 亂數產生器
    func randomNumberGenerator() {
        
        for i in 0...gameSize * gameSize {
            print(aryCellNumber)
            guard aryCellNumber[i] == "" else { continue }
            let randomNum = String(Int.random(in: 1...200))
            guard aryCellNumber.contains(randomNum) == false else { continue }
            aryTempCellNumber.append(randomNum)
            
        }
    }
}
