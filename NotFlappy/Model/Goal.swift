//
//  Goal.swift
//  NotFlappy
//
//  Created by Nick Dubauskas on 12/7/23.
//

import Foundation
import SpriteKit
class Goal: SKSpriteNode {
    
    init() {
            let texture = SKTexture(imageNamed: "pipe-red.png")  
            super.init(texture: texture, color: .clear, size: texture.size())
            setupGoal()
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    private func setupGoal(){
        let goalNode = SKSpriteNode(color: .clear, size: CGSize(width: size.width, height: 50))
        goalNode.physicsBody = SKPhysicsBody(rectangleOf: goalNode.size)
        goalNode.physicsBody?.categoryBitMask = PhysicsCategory.goal
        goalNode.physicsBody?.contactTestBitMask = PhysicsCategory.bird
        goalNode.physicsBody?.collisionBitMask = 0
        goalNode.yScale = 3.0
        goalNode.physicsBody?.isDynamic = false
        goalNode.isHidden = true
        goalNode.name = "goal"
        addChild(goalNode)
        
    }
    func moveGoal(){
       let screenWidth = UIScreen.main.bounds.width
       let destinationX = screenWidth + self.size.width / 2
       let moveAction = SKAction.moveTo(x: -destinationX , duration:  7.0)
       let sequence = SKAction.sequence([moveAction, SKAction.removeFromParent()])
       self.run(sequence)
   }
}
