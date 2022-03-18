//
//  Animals.swift
//  SpriteKit_FruitNinja_0216
//
//  Created by 侯懿玲 on 2022/2/22.
//

import Foundation
import SpriteKit
import GameplayKit

class Animals: SKNode {
    
    override init() {
        super.init()
        
        switch arc4random_uniform(12)+1{                // 用來產生0～(x-1)範圍內的隨機數
            
        case 1: setImageNode(nodeType: "chicken.png")   // 公雞
            
        case 2: setImageNode(nodeType: "cow.png")       // 乳牛
            
        case 3: setImageNode(nodeType: "dog.png")       // 狗
            
        case 4: setImageNode(nodeType: "elephant.png")  // 大象
            
        //case 5: setImageNode(nodeType: "farmer.png")    // 農夫
            
        case 6: setImageNode(nodeType: "goat.png")      // 山羊
            
        case 7: setImageNode(nodeType: "horse.png")     // 馬
            
        case 8: setImageNode(nodeType: "monkey.png")    // 猴子
            
        case 9: setImageNode(nodeType: "pig.png")       // 豬
            
        case 10: setImageNode(nodeType: "rabbit.png")   // 兔子
            
        case 11: setImageNode(nodeType: "snake.png")    // 蛇
            
        default: setImageNode(nodeType: "💣")
        }
        
    }
    func setImageNode(nodeType: String) {
        func labelNode(yesORnot: String, labelSize: Int){   // SKLabelNode
            let node = SKLabelNode(text: nodeType)
            
            node.fontSize = CGFloat(labelSize)
            
            node.verticalAlignmentMode = .center
            
            node.name = yesORnot
            
            node.zPosition = 3   // 圖層係數(數值越大越上面)
            
            node.physicsBody = SKPhysicsBody()
            
            node.position = CGPoint(x: GKRandomDistribution(lowestValue: 20, highestValue: Int(UIScreen.main.bounds.width)).nextInt(), y: -10)   // nextInt(): 產生一個Int型別的亂數
            
            if node.position.x < UIScreen.main.bounds.width/2 {
                node.physicsBody?.velocity.dx = CGFloat(arc4random_uniform(300)+1)    // 1~300的隨機數，可以根據參數指定範圍
            }
            
            if node.position.x > UIScreen.main.bounds.width/2 {
                node.physicsBody?.velocity.dx = CGFloat(-200)
            }
            
            node.physicsBody?.velocity.dy = CGFloat(GKRandomDistribution(lowestValue: 200, highestValue: 300).nextInt())
            
            node.physicsBody?.angularVelocity = CGFloat(GKRandomDistribution(lowestValue: -5, highestValue: 5).nextInt())
            
            self.addChild(node)
        }
        func imageNode(yesORnot: String, imageSize: Int){   // SKSpriteNode
            
            let node = SKSpriteNode(imageNamed: nodeType)
            
            node.size = CGSize(width: imageSize, height: imageSize)
            
            node.name = yesORnot
            
            node.zPosition = 3   // 圖層係數(數值越大越上面)
            
            node.physicsBody = SKPhysicsBody()
            
            node.position = CGPoint(x: GKRandomDistribution(lowestValue: 0, highestValue: Int(UIScreen.main.bounds.width)).nextInt(), y: -10)   // nextInt(): 產生一個Int型別的亂數
            
            if node.position.x < UIScreen.main.bounds.width/2 {
                node.physicsBody?.velocity.dx = CGFloat(arc4random_uniform(200))
            }
            
            if node.position.x > UIScreen.main.bounds.width/2 {
                node.physicsBody?.velocity.dx = CGFloat(-300)
            }
            
            node.physicsBody?.velocity.dy = CGFloat(GKRandomDistribution(lowestValue: 250, highestValue: 400).nextInt())
            
            node.physicsBody?.angularVelocity = CGFloat(GKRandomDistribution(lowestValue: -3, highestValue: 3).nextInt())  // 物件右旋宇左旋
            
            self.addChild(node)
        }
        if nodeType == "💣" {
            labelNode(yesORnot: "no", labelSize: 100)
        }
        else if nodeType == "farmer.png" {
            imageNode(yesORnot: "no", imageSize: 200)
        }
        else {
            imageNode(yesORnot: "yes", imageSize: 100)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - 參考資料
/*
 //MARK: -
 KNode 是所有 SpriteKit Node 中的基礎類別，像是繪製圖形或圖片 (SKSpriteNode) 及文字 (SKLabelNode) 等，都是他的子類別
 
 
 */
