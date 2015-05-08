//
//  BackHack.swift
//  FromScratch
//
//  Created by jpk on 5/7/15.
//  Copyright (c) 2015 Parker Kirby. All rights reserved.
//

import UIKit

class BackHack: UIView {

    override func didMoveToWindow() {
        
        var randomNumber = CGFloat(arc4random_uniform(100))
        var randomShape = CGFloat(arc4random_uniform(20))
        var randomColorRed = CGFloat(arc4random_uniform(255)) / 255
        var randomColorGreen = CGFloat(arc4random_uniform(255)) / 255
        var randomColorBlue = CGFloat(drand48()) //another way to select a random value
        var randomAlpha = CGFloat(Float(arc4random()) / Float(UInt32.max)) //random decimal value 0 - 1
        
        backgroundColor = UIColor(red: randomColorRed, green: randomColorGreen, blue: randomColorBlue, alpha: randomAlpha)
    
        frame.size.width =  randomNumber
        frame.size.height = randomNumber
        
        layer.cornerRadius = frame.size.width / randomShape

        
        UIView.animateWithDuration(1, delay: 2, options: UIViewAnimationOptions.CurveEaseOut, animations: {self.alpha = 0.0}, completion: {(finished: Bool) -> Void in})
        
    }

}