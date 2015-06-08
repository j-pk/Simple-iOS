//
//  GameScene.h
//  PIxelAdventure
//

//  Copyright (c) 2015 Parker Kirby. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface GameScene : SKScene

- (void)movePixelInDirection:(CGVector)direction;

- (void)normalAttack;
- (void)specialAttack;

@end
