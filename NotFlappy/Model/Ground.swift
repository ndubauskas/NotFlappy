//
//  Ground.swift
//  NotFlappy
//
//  Created by Nick Dubauskas on 12/4/23.
//

import SpriteKit

class Ground: SKSpriteNode {
    
    init() {
        let texture = SKTexture(imageNamed: "base.png")
        super.init(texture: texture, color: .clear, size: texture.size())
        
        setupGround()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupGround() {
        position = CGPoint(x: 0, y: -600)
        zPosition = 1
        xScale = UIScreen.main.bounds.width / 150
        yScale = UIScreen.main.bounds.height / 550
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.categoryBitMask = PhysicsCategory.ground
        physicsBody?.restitution = 0.75
        physicsBody?.isDynamic = false
    }
    
}
