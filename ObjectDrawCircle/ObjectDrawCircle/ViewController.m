//
//  ViewController.m
//  ObjectDrawCircle
//
//  Created by jpk on 6/5/15.
//  Copyright (c) 2015 Parker Kirby. All rights reserved.
//

#import "ViewController.h"
#import "ObjectDrawView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadView {
    
    CGRect frame = [UIScreen mainScreen].bounds;
    
    ObjectDrawView * drawView = [[ObjectDrawView alloc] initWithFrame:frame];\
    self.view = drawView;
}

@end
