
///////////CirleButton\\\\\\\\\\

import UIKit

@IBDesignable class CircleButton: UIButton {
    
    @IBInspectable var fillColor: UIColor = UIColor.whiteColor()
    @IBInspectable var strokeColor: UIColor = UIColor.clearColor()
    @IBInspectable var cornerRadius: CGFloat = 10
    @IBInspectable var strokeWidth: CGFloat = 1
    
    var choice: Int!

    override func drawRect(rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        
        fillColor.set()
        CGContextFillEllipseInRect(context, rect)
        
        strokeColor.set()
        let insetRect = CGRectInset(rect, strokeWidth / 2, strokeWidth / 2)
        let path = UIBezierPath(roundedRect: insetRect, cornerRadius: cornerRadius)
        CGContextSetLineWidth(context, strokeWidth)
        CGContextAddPath(context, path.CGPath)
        CGContextStrokePath(context)
        
    }


}
