//
//  GameOverScene.swift
//  SpriteKit_FruitNinja_0216
//
//  Created by 侯懿玲 on 2022/3/9.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene {
    
    let gameOverBG = SKSpriteNode(imageNamed: "gameOverBG")
    private var reStartGameLab = SKLabelNode()
    
    override func didMove(to view: SKView) {
        
        self.size = view.frame.size                     // 設定整體遊戲畫面尺寸
        //view.scene?.size = view.frame.size
        //print("over siz",view.scene)
        
        view.scene?.scaleMode = .aspectFill             // 全螢幕
        
        /// 背景設定
        gameOverBG.texture = SKTexture(imageNamed: "gameOverBG")
        
        gameOverBG.size = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        
        gameOverBG.name = "gameOverBG"
        
        gameOverBG.position = CGPoint(x: 0, y: 0)       // 圖片位置
        
        gameOverBG.zPosition = -1                       // 圖層係數(數值越大越上面)
        
        gameOverBG.anchorPoint = CGPoint(x: 0, y: 0)    // 對齊位置，左下(0,0)
        
        addChild(gameOverBG)
        
        /// SKLabelNode - reStartGameLab - 點一下畫面即可重新開始遊戲
        reStartGameLab = childNode(withName: "//reStartGameLab") as! SKLabelNode
        
        reStartGameLab.position = CGPoint(x: UIScreen.main.bounds.size.width/2, y: UIScreen.main.bounds.size.height/5)
        
        reStartGameLab.zPosition = 1                    // zPosition圖層係數(數值越大越上面)
        
        /// SKLabelNode - scoreLab - 顯示遊戲分數
        GameScene.share.scoreLab = childNode(withName: "//scoreLab") as! SKLabelNode
        
        GameScene.share.scoreLab.position = CGPoint(x: UIScreen.main.bounds.size.width/2, y: UIScreen.main.bounds.size.height*4/5)
        
        GameScene.share.scoreLab.zPosition = 1          // zPosition圖層係數(數值越大越上面)
        
        GameScene.share.scoreLab.text = "score: \(GameScene.share.score)"
        
        /// SKLabelNode - exitLab - 結束遊戲
        GameScene.share.exitLab = childNode(withName: "//exitLab") as! SKLabelNode
        
        GameScene.share.exitLab.position = CGPoint(x: UIScreen.main.bounds.size.width/5, y: UIScreen.main.bounds.size.height*4/5)
        
        GameScene.share.exitLab.zPosition = 1           // zPosition圖層係數(數值越大越上面)
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.location(in: self)
            
            let exitNode = atPoint(location)
            
            let startScene = SKScene(fileNamed: "StartScene")
            
            let gameScene = SKScene(fileNamed: "GameScene")
            
            if GameScene.share.score > GameScene.share.bestScore { GameScene.share.bestScore = GameScene.share.score }   // 設定最高分
            
            GameScene.share.score = -1                  // 分數歸零
            
            if exitNode.name == "exitLab" { view?.presentScene(startScene) }
            
            else{ view?.presentScene(gameScene) }
        }
    }
}
