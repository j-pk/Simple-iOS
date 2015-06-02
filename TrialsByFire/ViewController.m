//
//  ViewController.m
//  TrialsByFire
//
//  Created by jpk on 6/1/15.
//  Copyright (c) 2015 Parker Kirby. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    NSMutableString * name = [@"Parker" mutableCopy];
    NSString * oldname = name;
    
    [name insertString:@"Cool " atIndex:0];
    
    name = [@"Troll" mutableCopy];
    
    NSLog(@"%@", oldname);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
