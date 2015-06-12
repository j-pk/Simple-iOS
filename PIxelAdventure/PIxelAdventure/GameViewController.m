//
//  GameViewController.m
//  PIxelAdventure
//
//  Created by jpk on 6/8/15.
//  Copyright (c) 2015 Parker Kirby. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"
#import <AVFoundation/AVFoundation.h>

@implementation SKScene (Unarchive)

+ (instancetype)unarchiveFromFile:(NSString *)file {
    /* Retrieve scene file path from the application bundle */
    NSString *nodePath = [[NSBundle mainBundle] pathForResource:file ofType:@"sks"];
    /* Unarchive the file to an SKScene object */
    NSData *data = [NSData dataWithContentsOfFile:nodePath
                                          options:NSDataReadingMappedIfSafe
                                            error:nil];
    NSKeyedUnarchiver *arch = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    [arch setClass:self forClassName:@"SKScene"];
    SKScene *scene = [arch decodeObjectForKey:NSKeyedArchiveRootObjectKey];
    [arch finishDecoding];
    
    return scene;
}

@end

@implementation GameViewController
{
    GameScene * scene;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];

    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    /* Sprite Kit applies additional optimizations to improve rendering performance */
    skView.ignoresSiblingOrder = YES;
    
    // Create and configure the scene.
    scene = [GameScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeFill;
    
    // Present the scene.
    [skView presentScene:scene];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (IBAction)pressedButton:(UIButton *)sender {
    
    //if sender isequalto then move -1, else 1
    CGFloat direction = ([sender.titleLabel.text isEqualToString:@"A"]) ? -1 : 1;
    
    [scene changePixelDirection:direction];
    
}

- (IBAction)releasedButton:(id)sender {
    
    [scene changePixelDirection:0];
    
    
}

- (IBAction)moveButtonPressed:(UIButton *)sender {
    
    NSArray * letters = @[@"W", @"A", @"S", @"D"];
    
    int index = (int)[letters indexOfObject:sender.titleLabel.text];
    
    NSArray * directions = @[
                             [NSValue valueWithCGVector:CGVectorMake(0.0, 30.0)],
                             [NSValue valueWithCGVector:CGVectorMake(-1.0, 0.0)],
                             [NSValue valueWithCGVector:CGVectorMake(0.0, -10.0)],
                             [NSValue valueWithCGVector:CGVectorMake(30.0, 0.0)]
                             ];
    
    [scene movePixelInDirection:[directions[index] CGVectorValue]];
    
}


- (IBAction)fireButtonPressed:(UIButton *)sender {
    
    if ([sender.titleLabel.text isEqualToString:@"1"]) {
        [scene normalAttack];
    }
    
    if ([sender.titleLabel.text isEqualToString:@"2"]) {
        [scene specialAttack];
    }
    
}


- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
