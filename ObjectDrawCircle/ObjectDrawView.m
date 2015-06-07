//
//  ObjectDrawView.m
//  ObjectDrawCircle
//
//  Created by jpk on 6/5/15.
//  Copyright (c) 2015 Parker Kirby. All rights reserved.
//

#import "ObjectDrawView.h"
#import "CircleDraw.h"

@implementation ObjectDrawView




-(id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        totalCircles = [[NSMutableArray alloc] init];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


-(void) drawCircle: (CGRect)rect {
    
    [self drawCircle];
    
}


-(void) drawCircle {
    
    //get the graphic context
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //set the circle outer line width
    CGContextSetLineWidth(context, 10.0);
    
    //set the circle outer line color
    
    [[UIColor redColor] set];
    
    //loop through the circle and Draw these circles to the view
    for (CircleDraw * circle in totalCircles) {
        
        //create circle
        CGContextAddArc(context, circle.circleCenter.x, circle.circleCenter.y, circle.circleRadius, 0.0, M_PI * 2.0, YES);
        //draw
        CGContextStrokePath(context);
        
    }
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    for (UITouch * touch in touches) {
        
        CGPoint location = [touch locationInView:self];
        
        //create circle object
        CircleDraw * newCircle = [[CircleDraw alloc] init];
        //set center
        newCircle.circleCenter = location;
        //random radius
        newCircle.circleRadius = 10 + (arc4random() % 30);
        //add circle to the array
        [totalCircles addObject:newCircle];
        
        
        //update the view
        [self setNeedsDisplay];
        
        
        
    }
}


@end
