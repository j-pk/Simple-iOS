//
//  TicButton.swift
//  TicTacToe
//
//  Created by jpk on 5/8/15.
//  Copyright (c) 2015 Parker Kirby. All rights reserved.
//

import UIKit


enum Player {
    
    case One
    case Two
}


@IBDesignable class TicButton: UIButton {
    
    @IBInspectable var row: Int = 0
    @IBInspectable var col: Int = 0

    var player: Player?

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        
        var context = UIGraphicsGetCurrentContext()
        
        //creates a new rect that is one point off each side of the rect
        var insetRect = CGRectInset(rect, 1, 1)
        
        UIColor.lightGrayColor().set()
        
        CGContextSetLineWidth(context, 1)
        
//      CGContextFillEllipseInRect(context, rect)
        CGContextStrokeEllipseInRect(context, insetRect)
        
        if let playerUnwrapped = player {
            
            //any filler color after the following code
            UIColor(red:1, green:0.76, blue:0.26, alpha:1).set()
            
            if playerUnwrapped == .Two {
                
                UIColor(red:0, green:1, blue:0.72, alpha:1).set()
                
                
            }
            
            var smallCircleRect = CGRectInset(rect, 40, 40)
            CGContextFillEllipseInRect(context, smallCircleRect)
            
        }
        
    }


}
