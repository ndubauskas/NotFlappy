//
//  Bird.swift
//  NotFlappy
//
//  Created by Nick Dubauskas on 12/4/23.
//
import SpriteKit

class Bird: SKNode {
    private var birdNode: SKSpriteNode!

    override init() {
        super.init()

        setupBird()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupBird() {
        birdNode = SKSpriteNode(imageNamed: "bluebird-midflap.png")
        birdNode.name = "bird"
        birdNode.position.x = -200
         birdNode.position.y = 0
        birdNode.xScale = 1.8
        birdNode.yScale = 1.8
        addChild(birdNode)
        birdNode.physicsBody = SKPhysicsBody(rectangleOf: birdNode.size)
        birdNode.physicsBody?.categoryBitMask = PhysicsCategory.bird
        birdNode.physicsBody?.contactTestBitMask = PhysicsCategory.ground | PhysicsCategory.pipe
        birdNode.physicsBody?.collisionBitMask = PhysicsCategory.ground | PhysicsCategory.pipe
        birdNode.physicsBody?.affectedByGravity = true
    }

        func flap(){
            guard let bird = childNode(withName: "bird") as? SKSpriteNode else{
                return
            }
            let birdTextures = [
                      SKTexture(imageNamed: "bluebird-downflap.png"),
                      SKTexture(imageNamed: "bluebird-midflap.png"),
                      SKTexture(imageNamed: "bluebird-upflap.png")
                  ]
            let animateAction = SKAction.animate(with: birdTextures, timePerFrame: 0.15)
            let moveAction = SKAction.moveTo(y: bird.position.y + 100, duration: 0.45)
            let groupAction = SKAction.group([animateAction, moveAction])
    
            bird.run(groupAction){
                bird.physicsBody?.velocity.dy = 0
    
            }
        }
}


