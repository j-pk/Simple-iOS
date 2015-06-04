//
//  ViewController.h
//  TakeASelf
//
//  Created by jpk on 6/3/15.
//  Copyright (c) 2015 Parker Kirby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic) UIImage * original; 
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UISlider *filterSliderValue;
- (IBAction)filterSliderValue:(id)sender;

@end

