//
//  MainViewModel.swift
//  Bingo
//
//  Created by 侯懿玲 on 2022/5/22.
//

import Foundation
import Combine  // AnyCancellable才可使用

class MainViewModel {
    
    // 儲存監聽
    var aryMonitorStore: Set<AnyCancellable> = []
    
    // 賓果盤size
    var bingoStartSize = 0
    
    var tempNum = 0
    
    /// 判斷txf是否為空值或空字串，再將txf的鍵值轉成數值
    func setBingoSize(index: String?) {
        // 若index為空值或空字串 -> bingoSize設為0
        // 否則往下執行
        guard index != nil && index != "" else {bingoStartSize = 0; return}
        bingoStartSize = Int(index!)!
        print("int setBingoSize: ",bingoStartSize)
    }
    
    /// 判斷MainVC裡的textField值是否有在範圍內
    /// - Future : 完成或失敗的發布者，最終產生單個值
    func checkValue() -> Future<Bool, Error>{
        let valueIsAvailable = bingoStartSize>=3 && bingoStartSize<=10
        return Future { promise in
            promise(.success(valueIsAvailable))
        }
    }
    
}

// MARK: -
/*
 在 Combine 中使用 Promise 和 Future
 https://www.donnywals.com/using-promises-and-futures-in-combine/
 
 */
