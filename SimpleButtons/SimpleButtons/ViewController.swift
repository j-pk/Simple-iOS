//
//  ViewController.swift
//  SimpleButtons
//
//  Created by jpk on 5/4/15.
//  Copyright (c) 2015 Parker Kirby. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var printValue: UILabel!
    var value: Int?
    var firstNumber: Int?
    var secondNumber: Int?
    var operation = ""
    
    var userIsTypingSomething: Bool = false
    
    //This clears the label, AC Button
    @IBAction func clearButton(sender: UIButton) {

          printValue.text = "\(value)"
    }

    
    //This is registering the value of the first and second button pressed
    @IBAction func pressedButton1(sender: UIButton) {
        //sender is an arguement, UIButton is an object
        
      let firstNumber = sender.currentTitle
        
            if userIsTypingSomething {
                
                printValue.text = printValue.text! + firstNumber!

                
            } else {
                
                printValue.text = firstNumber
                userIsTypingSomething = true
        
        }
        
    }

    @IBAction func operatorPressed(sender: UIButton) {
        
        userIsTypingSomething = false
        firstNumber = printValue.text?.toInt()
        
        let operation = sender.currentTitle
        
    }

    @IBAction func equalsPressed(sender: UIButton) {
        
        userIsTypingSomething = false
        var result = 0
        secondNumber = printValue.text?.toInt()!
        
        switch operation {
            
            case "+" : value = firstNumber! + secondNumber!
            printValue.text = "\(value)"
            println(value)

            case "-" : value = firstNumber! - secondNumber!
            case "×" : value = firstNumber! * secondNumber!
            case "÷" : value = firstNumber! / secondNumber!
            
            default: break
            
            
        }
        
    }
    
}

