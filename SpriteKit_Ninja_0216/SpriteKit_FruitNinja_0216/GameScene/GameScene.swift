//
//  GameScene.swift
//  SpriteKit_FruitNinja_0216
//
//  Created by 侯懿玲 on 2022/2/22.
//

import Foundation
import SpriteKit
import GameplayKit          // GameplayKit可提供游戲資源、模塊、玩法設計以及系統規則方面的內容，但不包括視覺渲染等功能。

//public var scoreLab = SKLabelNode()
//
//public var exitLab = SKLabelNode()
//
//public var score = -1
//
//public var bestScore = 0

class GameScene: SKScene {
    
    static let share = GameScene()                              // 單利
    
    public var scoreLab = SKLabelNode()

    public var exitLab = SKLabelNode()

    public var score = -1

    public var bestScore = 0
    
    let background2 = SKSpriteNode(imageNamed: "background2")
    
    let snowScene = SKEmitterNode(fileNamed: "SnowScene")
    
    var bestScoreLab = SKLabelNode()
    
    var timer = Timer()                                         // 在一段時間觸發一些動作
    
    override func didMove(to view: SKView) {
        
        view.scene?.size = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height) // 取得螢幕尺寸
        
        view.scene?.scaleMode = .aspectFill
        
        anchorPoint = .zero // (0,0)
        
        physicsWorld.gravity = CGVector(dx: 0, dy: -1.62)       // 配置場景的重力
        
        /// 背景設定
        background2.name = "background2"
        
        background2.position = CGPoint(x: 0, y: 0)              // 圖片位置
        
        background2.zPosition = -1                              // 圖層係數(數值越大越上面)
        
        background2.size = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        
        background2.anchorPoint = CGPoint(x: 0, y: 0)           // 對齊位置，左下(0,0)
        
        addChild(background2)
        
        /// 下雪特效設定
        snowScene?.position = CGPoint(x: size.width/2, y: size.height)
        
        addChild(snowScene!)
        
        /// 在一段時間觸發一些動作
        /// - timeInterval    觸發Timer的間隔時間
        /// - target             Timer觸發的對象( 這邊填入self表示這一個ViewController )
        /// - selector          Timer的觸發事件，需填入一個function，這邊填入timerAction()
        /// - userInfo         可作為傳入Timer觸發事件的資料
        /// - repeat            是否重複，若填入false則啟用後只觸發第一次
        timer = .scheduledTimer(timeInterval: 2, target: self, selector: #selector(creatAnimalsNode), userInfo: nil, repeats: true)
        
        /// 加入分數Label
        addScore()
        
        /// SKLabelNode - exitLab - 結束遊戲
        exitLab = childNode(withName: "//exitLab") as! SKLabelNode
        
        exitLab.position = CGPoint(x: UIScreen.main.bounds.size.width/5, y: UIScreen.main.bounds.size.height*4.3/5)
        
        exitLab.zPosition = 1                                   // zPosition圖層係數(數值越大越上面)
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            
            let location = touch.location(in: self)
            
            let previousLocation = touch.previousLocation(in: self)
            
            for node in nodes(at: location){
                
                if node.name == "yes"{
                    
                    let emitter = SKEmitterNode(fileNamed: "animalExplo")
                    
                    emitter?.position = node.position
                    
                    emitter?.zPosition = 5
                    
                    addChild(emitter!)
                    
                    node.removeFromParent()                     // 被滑到的圖片會消失
                    
                    addScore()                                  // 滑到動物物件分數會增加
                }
                
                if node.name == "no" { gameOver() }
                
            }
            
            let path = CGMutablePath()
            
            path.move(to: location)
            
            path.addLine(to: previousLocation)
            
            let line = SKShapeNode(path: path)
            
            line.lineWidth = 10
            
            line.strokeColor = .white
            
            let fadeOut = SKAction.fadeOut(withDuration: 0.3)   // 消失
            
            let remove = SKAction.removeFromParent()            // 移除
            
            let lineSequence = SKAction.sequence([fadeOut,remove])
            
            line.run(lineSequence)
            
            addChild(line)
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            
            let location = touch.location(in: self)
            
            let exitNode = atPoint(location)
            
            let startScene = SKScene(fileNamed: "StartScene")
            
            if exitNode.name == "exitLab" {
            
                score = -1                                      // 分數歸零
                
                view?.presentScene(startScene)
            
            }
        }
    }
    
    @objc func creatAnimalsNode() {
        
        let randomNumber = Int(GKRandomDistribution(lowestValue: 3, highestValue: 6).nextInt()) // 隨機生成物件，數量介於3到6之間
        
        for _ in 0..<randomNumber {
            
            addChild(Animals())
            
        }
    }
    
    func gameOver(){
        
        let gameOverScene = SKScene(fileNamed: "GameOverScene")!
        
        gameOverScene.scaleMode = .aspectFill
        
        view?.presentScene(gameOverScene, transition: SKTransition.doorway(withDuration: 1))
        
    }
    
    func addScore(){
        
        /// SKLabelNode - scoreLab - 顯示遊戲分數
        scoreLab = childNode(withName: "//scoreLab") as! SKLabelNode
        
        scoreLab.position = CGPoint(x: UIScreen.main.bounds.size.width/5, y: UIScreen.main.bounds.size.height*3.6/5)
        
        scoreLab.zPosition = 1                                  // zPosition圖層係數(數值越大越上面)
        
        score += 1
        
        scoreLab.text = "score: \(score)"
        
        /// SKLabelNode - bestScoreLab - 顯示最高遊戲分數
        bestScoreLab = childNode(withName: "//bestScoreLab") as! SKLabelNode
        
        bestScoreLab.position = CGPoint(x: UIScreen.main.bounds.size.width*4/5, y: UIScreen.main.bounds.size.height*3.6/5)
        
        bestScoreLab.zPosition = 1                              // zPosition圖層係數(數值越大越上面)
        
        if score > bestScore{
        
            bestScore = score
            
            bestScoreLab.text = "bestScore: \(score)"
        
        }
        
        else{ bestScoreLab.text = "bestScore: \(bestScore)" }
    
    }
}

//MARK: - 參考資料
/*
 GKRandomDistribution(lowestValue: Int, highestValue: Int).nextInt():
 lowestValue設定數字的最小值,highestValue設定最大值.因此randomDistribution將可產生介於lowestValue、highestValue之間,型別為Int的亂數
 
 //MARK: - 物理體的常用特性:
 https://zhuanlan.zhihu.com/p/347968906
 
 */
