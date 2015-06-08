//
//  GameScene.m
//  PIxelAdventure
//
//  Created by jpk on 6/8/15.
//  Copyright (c) 2015 Parker Kirby. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene

{
    SKShapeNode * pixel;
}


-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    //setting the parameters of the frame and a floor
    NSLog(@"%f %f", view.frame.size.width, view.frame.size.height);
    //anything with body is going to edge
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:view.frame];
//
//    SKFieldNode * field = [SKFieldNode radialGravityField];
//    
//    field.position = view.center;
//    field.strength = 100;
//    
//    [self addChild:field];
    pixel = [SKShapeNode shapeNodeWithEllipseOfSize:CGSizeMake(10, 10)];

    pixel.fillColor = [UIColor cyanColor];
    pixel.strokeColor = [UIColor clearColor];
    
    pixel.position = CGPointMake(10, 10);
    
    //adding gravity to the pixel to fall
    //physicbody is going to have mass
    pixel.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:5];
    pixel.physicsBody.friction = 10;
    
    [self addChild:pixel];

}

- (void)movePixelInDirection:(CGVector)direction {
    
//    [pixel.physicsBody  applyForce:direction];
    
    CGFloat newX = pixel.position.x + direction.dx;
    CGFloat newY = pixel.position.y + direction.dy;
    
    pixel.position = CGPointMake(newX, newY);
    
    
}

- (void)normalAttack {
    
    SKShapeNode * babyPixel = [SKShapeNode shapeNodeWithEllipseOfSize:CGSizeMake(4, 4)];
    babyPixel.fillColor = [UIColor redColor];
    babyPixel.strokeColor = [UIColor clearColor];
    
    babyPixel.position = CGPointMake(pixel.position.x + 10, pixel.position.y);
    
    [self addChild:babyPixel];
    
    babyPixel.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:1];
    babyPixel.physicsBody.affectedByGravity = NO;
    
    [babyPixel.physicsBody applyImpulse:CGVectorMake(10, 0)];
    
}

- (void)specialAttack {
    
    SKEmitterNode * fireBall = [SKEmitterNode nodeWithFileNamed:@"Attack"];
    
//    SKShapeNode * fireBall = [SKShapeNode shapeNodeWithEllipseOfSize:CGSizeMake(4, 4)];
//    fireBall.fillColor = [UIColor redColor];
//    fireBall.strokeColor = [UIColor clearColor];
    
    fireBall.position = CGPointMake(pixel.position.x + 10, pixel.position.y);
    
    [self addChild:fireBall];
    
    fireBall.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:1];
//    fireBall.physicsBody.affectedByGravity = NO;
    
    [fireBall.physicsBody applyImpulse:CGVectorMake(0.1, 0.1)];
    
}

    /* Called when a touch begins */
    
////    for (UITouch *touch in touches) {
//    
//        //gamescene has a view
////        CGPoint location = [touch locationInNode:self];
//        
//        //0, 0 is the bottom left corner of the box (x & y)
//        //shapeNodeWithRectofSize draws the rect in the center of the arrow
//        //otherwise it draw at point 0,0
//
// 

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
