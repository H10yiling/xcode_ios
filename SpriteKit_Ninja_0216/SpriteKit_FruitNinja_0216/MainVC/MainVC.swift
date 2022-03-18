//
//  MainVC.swift
//  SpriteKit_FruitNinja_0216
//
//  Created by 侯懿玲 on 2022/2/16.
//  要記得將MainVC.xib的UIView改成SKView

import UIKit
import SpriteKit
import GameplayKit

// MARK: - Start Scene
class MainVC: UIViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        print(UIScreen.main.bounds.width,UIScreen.main.bounds.height)
        
        setScene()
    }
    
    func setScene() {
        
        if let view = self.view as! SKView? {
            
            view.scene?.size = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height) // 設定整體遊戲畫面尺寸
            //print("main siz",view.scene?.size) // -> print 出 nil
            
            if let scene = SKScene(fileNamed: "StartScene") {

                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill

                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true        // 顯示fps
            
            view.showsNodeCount = true  // 顯示nodes
            
            view.showsPhysics = true
        }
        
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        
        if UIDevice.current.userInterfaceIdiom == .phone {
        
            return .allButUpsideDown
        
        }
        
        else {
        
            return .all
        
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}

//MARK: - 參考資料
/*
 //MARK: - 利用 SpriteKit Particle File 製造下雪的粒子效果:
 https://medium.com/%E5%BD%BC%E5%BE%97%E6%BD%98%E7%9A%84-swift-ios-app-%E9%96%8B%E7%99%BC%E5%95%8F%E9%A1%8C%E8%A7%A3%E7%AD%94%E9%9B%86/%E5%88%A9%E7%94%A8-spritekit-particle-file-%E8%A3%BD%E9%80%A0%E4%B8%8B%E9%9B%AA%E7%9A%84%E7%B2%92%E5%AD%90%E6%95%88%E6%9E%9C-cd07303a10af
 Attributes inspector:
 Texture 欄位控制粒子的圖案，我們將它改成 boken 呈現另一種下雪效果
 
 //MARK: -
 https://www.itread01.com/p/381445.html
 
 */
