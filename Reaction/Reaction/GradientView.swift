
///////////GradientView\\\\\\\\\\

import UIKit

@IBDesignable class GradientView: UIView {

    @IBInspectable var firstColor: UIColor = UIColor.whiteColor()
    @IBInspectable var secondColor: UIColor = UIColor.blackColor()
    
    @IBInspectable var startPoint: CGPoint = CGPoint(x: 0.5, y: 0)
    @IBInspectable var endPoint: CGPoint = CGPoint(x: 0.5, y: 1.0)

    override func drawRect(rect: CGRect) {
        
        var gradientLayer = CAGradientLayer()
        gradientLayer.frame = layer.bounds
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.colors = [firstColor.CGColor, secondColor.CGColor]
        layer.insertSublayer(gradientLayer, atIndex: 0)
        
        
    }
    
}
