//
//  ViewController.swift
//  HitMe
//
//  Created by jpk on 5/13/15.
//  Copyright (c) 2015 Parker Kirby. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func showAlert() {
        let message = "The value of the slider is: \(currentSliderValue)"
        let alert = UIAlertController(title: "Hit Me!", message: message, preferredStyle: .Alert)
        let action = UIAlertAction(title: "👍🏼", style: .Default, handler: nil)
        
        alert.addAction(action)
        
        presentViewController(alert, animated: true, completion: nil)
    
    
    }
    
    var currentSliderValue: Int = 0
    
    @IBAction func sliderMoved(slider: UISlider) {
        currentSliderValue = lroundf(slider.value)
        println("The value of the slider is now: \(slider.value)")
    }
}

