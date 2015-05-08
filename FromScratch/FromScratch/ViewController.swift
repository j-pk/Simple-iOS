//
//  ViewController.swift
//  FromScratch
//
//  Created by jpk on 5/7/15.
//  Copyright (c) 2015 Parker Kirby. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {

        for touch in touches as! Set<UITouch> {
            
            let location = touch.locationInView(view)
            println("x = \(location.x) and y = \(location.y)")
            
            var box = BackHack()
            view.addSubview(box)
            box.center = location
            

        }
        
    }
    
}

/* 

Normal Mode

Make box a circle
Randomize the circle size (width will be the same as height)
Randomize the color of the circle 
Randomize the alpha of the circle

Middle Mode

Transition to alpha 0 after 1 second
UIViewAnimation

Hard Mode

Randomize rotation of box
Randomize whether it is round or not 
Randomize between full circle  > rounded square > square

*/

