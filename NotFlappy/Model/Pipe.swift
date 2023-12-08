//
//  Pipe.swift
//  NotFlappy
//
//  Created by Nick Dubauskas on 12/4/23.
//


import SpriteKit

class Pipe: SKSpriteNode {
    
    var gap = CGPoint(x: 0,y: 0)

    init() {
        let texture = SKTexture(imageNamed: "pipe-green.png")
        super.init(texture: texture, color: .clear, size: texture.size())
        setupPipe()
       
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

       private func setupPipe() {
        zPosition = 0
        xScale = 1.9
        yScale = 3
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.categoryBitMask = PhysicsCategory.pipe
        physicsBody?.restitution = 0.75
        physicsBody?.isDynamic = false
    
        name = "pipe"
        
    }
  
     func movePipe(){
        let screenWidth = UIScreen.main.bounds.width
        let destinationX = screenWidth + self.size.width / 2
        let moveAction = SKAction.moveTo(x: -destinationX , duration:  7.0)
        let sequence = SKAction.sequence([moveAction, SKAction.removeFromParent()])
        self.run(sequence)
    }
    
}
