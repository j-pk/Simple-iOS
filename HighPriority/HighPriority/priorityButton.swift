//
//  priorityButton.swift
//  HighPriority
//
//  Created by jpk on 5/11/15.
//  Copyright (c) 2015 Parker Kirby. All rights reserved.
//

import UIKit

@IBDesignable class priorityButton: UIButton {
    
    @IBInspectable var priorityButton1 = 0

        override func drawRect(rect: CGRect) {
            // Drawing code
            var context = UIGraphicsGetCurrentContext()
            var smallCircleRect = CGRectInset(rect,0,0)
            
            //creates a new rect that is one point off each side of the rect
            var insetRect = CGRectInset(rect, 1, 1)
            
           priorityColors[tag].set()
            
            CGContextFillEllipseInRect(context, smallCircleRect)
            
            CGContextStrokeEllipseInRect(context, insetRect)
            
    }
}