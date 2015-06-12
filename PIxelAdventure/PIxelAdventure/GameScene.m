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
    SKSpriteNode * pixel;
    CGFloat characerDirection;
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
    pixel = [SKSpriteNode spriteNodeWithImageNamed:@"mario"];
    
    pixel.position = CGPointMake(150, 50);
    
    //adding gravity to the pixel to fall
    //physicbody is going to have mass
    pixel.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(10, 20) center:CGPointMake(0, 0)];
    pixel.physicsBody.friction = 10;
    
    [self addChild:pixel];

}

//changes pixel direction to move left and right
- (void)changePixelDirection:(CGFloat)direction {
    
    characerDirection = direction;
    
    
}

// allows pixel to jump
- (void)movePixelInDirection:(CGVector)direction {
    
    CGFloat newX = pixel.position.x + direction.dx;
    CGFloat newY = pixel.position.y + direction.dy;
    
    pixel.position = CGPointMake(newX, newY);
    [pixel.physicsBody applyImpulse:CGVectorMake(newX + 0.5, newY + 0.5)];
    
        [self runAction:[SKAction playSoundFileNamed:@"smw_jump.wav" waitForCompletion:NO]];
    
}

- (void)normalAttack {
    
    SKShapeNode * babyPixel = [SKShapeNode shapeNodeWithEllipseOfSize:CGSizeMake(4, 4)];
    babyPixel.fillColor = [UIColor redColor];
    babyPixel.strokeColor = [UIColor clearColor];
    
    babyPixel.position = CGPointMake(pixel.position.x + 10, pixel.position.y + 10);
    
    [self addChild:babyPixel];
    
    babyPixel.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:1];
    babyPixel.physicsBody.affectedByGravity = NO;
    
    [babyPixel.physicsBody applyImpulse:CGVectorMake(10, 0)];
    
    SKAction * soundEffect = [SKAction playSoundFileNamed:@"smw_fireball.wav" waitForCompletion:NO];
    
    [self runAction:soundEffect];
    
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
    
    pixel.position = CGPointMake(pixel.position.x + characerDirection, pixel.position.y);
}

@end
