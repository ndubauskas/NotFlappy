//
//  Score.swift
//  NotFlappy
//
//  Created by Nick Dubauskas on 12/5/23.
//

import Foundation
import SpriteKit
class Score: SKNode{
    
    let scoreDict:[Int:String] = [0:"0.png", 1:"1.png",2:"2.png",3:"3.png",4:"4.png",5:"5.png",6:"6.png",7:"7.png",8:"8.png",9:"9.png"]
    var score = 0
    
    private var onesNode: SKSpriteNode!
    private var tensNode: SKSpriteNode!
    private var hundredsNode: SKSpriteNode!
    private var lastScoreUpdateTime: TimeInterval = 0
    private let scoreUpdateInterval: TimeInterval = 3.0

    override init() {
        
        super.init()
        setupScoreNodes()
      
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupScoreNodes() {
        
        hundredsNode = SKSpriteNode(imageNamed: "0.png")
        tensNode = SKSpriteNode(imageNamed: "0.png")
        onesNode = SKSpriteNode(imageNamed: "0.png")

        addChild(hundredsNode)
        addChild(tensNode)
        addChild(onesNode)

           // Set the initial positions a couple of pixels apart
        hundredsNode.position.x -= 30
        hundredsNode.position.y = UIScreen.main.bounds.height * 0.60
        hundredsNode.zPosition = 2
           tensNode.position.x -= 10
           tensNode.position.y = UIScreen.main.bounds.height * 0.60
        tensNode.zPosition = 2
            onesNode.position.x += 10
            onesNode.position.y = UIScreen.main.bounds.height * 0.60
        onesNode.zPosition = 2
            tensNode.isHidden = true
            hundredsNode.isHidden = true
       }
    func updateScore() {
        
        let currentTime = NSDate().timeIntervalSince1970
                          
        if currentTime - lastScoreUpdateTime >= scoreUpdateInterval {
            score += 1
            lastScoreUpdateTime = currentTime
  
        }

        if score >= 10{
            tensNode.isHidden = false
        }
        if score >= 100{
            hundredsNode.isHidden = false
        }
        let hundredsDigit = score / 100
        let tensDigit = score / 10
        let onesDigit = score % 10


        let hundredsImageName = scoreDict[hundredsDigit] ?? "0.png"
        let tensImageName = scoreDict[tensDigit] ?? "0.png"
        let onesImageName = scoreDict[onesDigit] ?? "0.png"

        hundredsNode.texture = SKTexture(imageNamed: hundredsImageName)
        tensNode.texture = SKTexture(imageNamed: tensImageName)
        onesNode.texture = SKTexture(imageNamed: onesImageName)


    }
}
