//
//  CharacterTableViewCell.h
//  GroupTherapy
//
//  Created by jpk on 6/2/15.
//  Copyright (c) 2015 Parker Kirby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CharacterTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *charImage;
@property (weak, nonatomic) IBOutlet UILabel *charNameTextLabel;

@property (weak, nonatomic) IBOutlet UILabel *charComicCountLabel;

@end
