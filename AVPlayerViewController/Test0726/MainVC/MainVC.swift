//
//  MainVC.swift
//  Test0726
//
//  Created by 侯懿玲 on 2021/7/26.
//

import UIKit
import AVKit
import AVFoundation

class MainVC: UIViewController {
    
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false) // 隱藏指示條
    }

    @IBAction func didTapButton (btn: UIButton){
        switch btn {
        case btn1:
            let player1 = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "151", ofType: "mov")!))
            let vc1 = AVPlayerViewController()
            vc1.player = player1
            present(vc1, animated: true)
        case btn2:
            let player2 = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "152", ofType: "mov")!))
            let vc2 = AVPlayerViewController()
            vc2.player = player2
            present(vc2, animated: true)
        default:
            let player3 = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "swag", ofType: "mov")!))
            let vc3 = AVPlayerViewController()
            vc3.player = player3
            present(vc3, animated: true)
        }
    }
}

/*
 mov Unexpectedly found nil while unwrapping an Optional value：
 https://stackoverflow.com/questions/51456752/unexpectedly-found-nil-while-unwrapping-an-optional-value-while-trying-to-play
 */
