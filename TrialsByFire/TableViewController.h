//
//  TableViewController.h
//  TrialsByFire
//
//  Created by jpk on 6/1/15.
//  Copyright (c) 2015 Parker Kirby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewController : UITableViewController

//any file in the header is a public version - objective c type
@property (nonatomic) NSArray * publicItems;
//example without an *
//@property (nonatomic) NSInteger myNumber;
////low level C type
//@property (nonatomic) BOOL isAlive;

@end
