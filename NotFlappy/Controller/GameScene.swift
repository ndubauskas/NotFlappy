//
//  GameScene.swift
//  NotFlappy
//
//  Created by Nick Dubauskas on 11/30/23.
//

import SpriteKit
import GameplayKit
import Foundation

class GameScene: SKScene, SKPhysicsContactDelegate {

    var bird: Bird!
    var birdNode: SKSpriteNode!
    var ground: Ground!
    var pipe: Pipe!
    var score: Score!
    var goal: Goal!
    private var restartButton: SKSpriteNode?
    var isGameOver = false
    var pipeSpawnTimer: Timer?
    var lastSpawnedGapPosition: CGFloat = 0
    var distanceBetweenPipes = CGPoint(x:0,y:0)
    var lastScoreUpdateTime: TimeInterval = 0
      let scoreUpdateInterval: TimeInterval = 3.0

    
    override func didMove(to view: SKView) {
        physicsWorld.gravity = CGVector(dx: 0, dy: -5.5)
        physicsWorld.contactDelegate = self
        //view.showsPhysics = true
        spawnPipe()
        startPipeSpawnTimer()
        bird = Bird()
        bird.name = "bird"
        ground = Ground()
        score = Score()
        bird.name = "bird"
        addChild(bird)
        addChild(ground)
        addChild(score)
        let background = SKSpriteNode(imageNamed: "background-night.png")
        background.position = CGPoint(x: 0, y: 0)
        scaleMode = .aspectFill
        background.xScale = size.width / background.size.width
        background.yScale = size.height / background.size.height
        background.zPosition = -1
        addChild(background)

    }
  
    func startPipeSpawnTimer() {
       
         pipeSpawnTimer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(spawnPipe), userInfo: nil, repeats: true)
     }
    func stopPipeSpawnTimer(){
        pipeSpawnTimer?.invalidate()
          pipeSpawnTimer = nil
    }
    @objc func spawnPipe(){
        let randomY = CGFloat.random(in: 183 ... 750)
        let upperPipe = Pipe()
        upperPipe.position = CGPoint(x: UIScreen.main.bounds.width, y: randomY)
        upperPipe.yScale = -3
        
        let lowerPipe = Pipe()
        lowerPipe.position = CGPoint(x: UIScreen.main.bounds.width, y: (randomY - 1200))
       
        addChild(upperPipe)
        addChild(lowerPipe)
        let goal = Goal()
        goal.isHidden = true
        goal.name = "goal"
        goal.position = CGPoint(x:lowerPipe.position.x, y: lowerPipe.position.y + 500)
        addChild(goal)
        goal.yScale = 2.0
        upperPipe.movePipe()
        lowerPipe.movePipe()
        goal.moveGoal()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask

        if contactMask == PhysicsCategory.bird | PhysicsCategory.ground {

             gameOver()
              
        } else if contactMask == PhysicsCategory.bird | PhysicsCategory.pipe{
           
           gameOver()
            
        
        }else if contactMask == PhysicsCategory.bird | PhysicsCategory.goal {
           
          
            score.updateScore()
            
        }
        
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if view?.isPaused == true {
          
            guard let touch = touches.first else { return }
            let touchLocation = touch.location(in: self)

 
            if ((restartButton?.contains(touchLocation)) != nil) {
                resetGame()
            }
        } else {
          
            bird.flap()
        }
    }

    
    override func update(_ currentTime: TimeInterval){
      
    }
    
    func findNodeRecursively(withName name: String, in node: SKNode) -> SKSpriteNode? {
        if let spriteNode = node as? SKSpriteNode, spriteNode.name == name {
            return spriteNode
        }

        for child in node.children {
            if let foundNode = findNodeRecursively(withName: name, in: child) {
                return foundNode
            }
        }

        return nil
    }


    func gameOver() {
          
           self.view?.isPaused = true

           let gameOverImage = SKSpriteNode(imageNamed: "gameover.png")
           gameOverImage.zPosition = 2
        gameOverImage.xScale = 2.0
        gameOverImage.yScale = 2.0
           gameOverImage.position = CGPoint(x: 0, y: 300)
           addChild(gameOverImage)

           restartButton = SKSpriteNode(imageNamed: "message.png")
           restartButton?.position = CGPoint(x: 0, y: -100)
        restartButton?.xScale = 1.5
        restartButton?.yScale = 1.5
           restartButton?.zPosition = 3
           addChild(restartButton!)
            
       }

       

       private func resetGame() {
         
           self.view?.isPaused = false
           restartButton?.removeFromParent()
           score.score = 0
           removeAllChildren()
          restartEverything()
           
       }
    func restartEverything(){
        spawnPipe()
        stopPipeSpawnTimer()
        startPipeSpawnTimer()
        bird = Bird()
        bird.name = "bird"
        ground = Ground()
        score = Score()
        bird.name = "bird"
        bird.position.y = 300
        addChild(bird)
        addChild(ground)
        addChild(score)
        let background = SKSpriteNode(imageNamed: "background-night.png")
        background.position = CGPoint(x: 0, y: 0)
        scaleMode = .aspectFill
        background.xScale = size.width / background.size.width
        background.yScale = size.height / background.size.height
        background.zPosition = -1
        addChild(background)

    }
}



