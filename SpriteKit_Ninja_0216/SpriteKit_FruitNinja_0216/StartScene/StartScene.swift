//
//  StartScene.swift
//  SpriteKit_FruitNinja_0216
//
//  Created by 侯懿玲 on 2022/2/16.
//

import UIKit
import SpriteKit

class StartScene: SKScene {
    
    let background = SKSpriteNode(imageNamed: "background")
    
    private var titleLab = SKLabelNode()
    
    private var startLab = SKLabelNode()
    
    let fadeOut = SKAction.fadeOut(withDuration: 0.3)   // 消失
    let fadeIn = SKAction.fadeIn(withDuration: 0.3)     // 顯示
    
    override func didMove(to view: SKView) {
        
        view.scene?.size = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height) // 設定整體遊戲畫面尺寸
        
        print("start siz",view.scene?.size)
        
        view.scene?.scaleMode = .aspectFill             // 全螢幕
        
        /// 背景設定
        background.name = "background"
        
        background.position = CGPoint(x: 0, y: 0)       // 圖片位置
        
        background.zPosition = -1                       // 圖層係數(數值越大越上面)
        
        background.size = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        
        background.anchorPoint = CGPoint(x: 0, y: 0)    // 對齊位置，左下(0,0)
        
        addChild(background)
        
        /// SKEmitterNode - SnowScene
        if let snowScene = SKEmitterNode(fileNamed: "SnowScene"){
            
            snowScene.position = CGPoint(x: UIScreen.main.bounds.size.height, y: UIScreen.main.bounds.size.width)
            
            snowScene.advanceSimulationTime(2000)
            
            snowScene.zPosition = 0                     // zPosition圖層係數(數值越大越上面)
            
            addChild(snowScene)
        }
        
        /// SKLabelNode - titleLab
        titleLab = childNode(withName: "//titleLab") as! SKLabelNode
        
        titleLab.position = CGPoint(x: UIScreen.main.bounds.size.width/2, y: UIScreen.main.bounds.size.height/2)
        
        titleLab.zPosition = 1                          // zPosition圖層係數(數值越大越上面)
        
        titleLab.run(SKAction.fadeIn(withDuration: 2.0))
        
        /// SKLabelNode - startLab
        startLab = childNode(withName: "//startLab") as! SKLabelNode
        
        startLab.position = CGPoint(x: UIScreen.main.bounds.size.width/2, y: UIScreen.main.bounds.size.height/3)
        
        startLab.zPosition = 2                          // zPosition圖層係數(數值越大越上面)
        
        let startLabSequence = SKAction.sequence([fadeOut,fadeIn])
        
        startLab.run(SKAction.repeatForever(startLabSequence))
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
        
            let location = touch.location(in: self)
            
            let startNode = atPoint(location)
            
            let gameScene = SKScene(fileNamed: "GameScene")
            
            if startNode.name == "startLab" { view?.presentScene(gameScene) }
            
        }
    }
}

//MARK: - 參考資料
/*
 childNode(withName: "//searchNode")有雙斜線時，它將不只找下一層，它將一路找到底，下下層，下下下層都會找，直到找到名為 searchNode 的 node。若是不幸找遍所有的下層都還是找不到，它才會死心地回傳 nil
 */
