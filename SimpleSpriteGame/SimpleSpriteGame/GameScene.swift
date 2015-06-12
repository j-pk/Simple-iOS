//
//  GameScene.swift
//  SimpleSpriteGame
//
//  Created by jpk on 6/8/15.
//  Copyright (c) 2015 Parker Kirby. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let player = SKSpriteNode(imageNamed: "player")
    
    override func didMoveToView(view: SKView) {
        
        backgroundColor = SKColor.whiteColor()
        
        player.position = CGPoint(x: size.width * 0.1, y: size.height * 0.5)
        
        addChild(player)
        
        runAction(SKAction.repeatActionForever(SKAction.sequence([SKAction.runBlock(addMonster), SKAction.waitForDuration(1.0)])))
        
        
    }
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(#min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    func addMonster() {
        
        let monster = SKSpriteNode(imageNamed: "monster")
        
        let actualY = random(min: monster.size.height/2, max: size.height - monster.size.height/2)
        
        let actualDuration = random(min: CGFloat(2.0), max: CGFloat(4.0))
        
        monster.position = CGPoint(x: size.width + monster.size.width/2, y: actualY)
        
        let actionMove = SKAction.moveTo(CGPoint(x: -monster.size.width/2, y: actualY), duration: NSTimeInterval(actualDuration))
        let actionMoveDone = SKAction.removeFromParent()
        
        monster.runAction(SKAction.sequence([actionMove, actionMoveDone]))
        
        addChild(monster)
        
        
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
