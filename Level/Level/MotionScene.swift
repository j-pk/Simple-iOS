//
//  MotionScene.swift
//  Level
//
//  Created by jpk on 6/29/15.
//  Copyright (c) 2015 Parker Kirby. All rights reserved.
//

import UIKit
import SpriteKit

class MotionScene: SKScene {
   
    let dot = SKShapeNode(ellipseOfSize: CGSize(width: 40, height: 40))
    var selectedNode: SKSpriteNode!
    
    let colorArray = [UIColor.blackColor(), UIColor.greenColor(), UIColor.purpleColor(), UIColor.redColor(), UIColor.cyanColor()]

    override func didMoveToView(view: SKView) {
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsBody = SKPhysicsBody(edgeLoopFromRect: view.bounds)

        
        size = view.frame.size
        
        backgroundColor = UIColor.blackColor()
        
        dot.fillColor = UIColor.whiteColor()
        dot.position = view.center
        dot.zPosition = 10
        dot.physicsBody = SKPhysicsBody(circleOfRadius: 20)
        addChild(dot)
    
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        //if let touch = touches.first as? UITouch {
            
        //let location  = touch.locationInNode(self)
            
        //let node = self.nodeAtPoint(location)
            
            addBallToScene()

        
        //}
        
        
    }
    
    func addBallToScene() {
        
        var dotXsize: UInt32 = 50
        var dotX = SKShapeNode(ellipseOfSize: CGSize(width: CGFloat(arc4random_uniform(dotXsize)), height: CGFloat(arc4random_uniform(dotXsize))))
        var randomColor = Int(arc4random_uniform(UInt32(colorArray.count)))
        dotX.fillColor = colorArray[randomColor]
        dotX.position = view!.center
        dotX.zPosition = 10
        dotX.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        addChild(dotX)
        
    }
    
}
