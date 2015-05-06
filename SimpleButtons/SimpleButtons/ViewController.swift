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
    var firstNumber = 0
    var secondNumber = 0
    var value: Double = 0
    var currentOperator = ""
    var percentNumber: Double = 0.01
    
    
    @IBAction func clearButton(sender: UIButton) {

          printValue.text = "\(value)"
    }
    
    @IBAction func pressedButton1(sender: UIButton) {
        //sender is an arguement, UIButton is an object
        
        let number = sender.currentTitle!.toInt()!
        
        if currentOperator.isEmpty {
            
            firstNumber = number
            println("\(firstNumber)")
            printValue.text = "\(firstNumber)"
            
        } else {
            
            secondNumber = number
            println("\(secondNumber)")
            printValue.text = "\(secondNumber)"
        }
        
    }
    
    @IBAction func plusMinus(sender: UIButton) {
        
        if firstNumber > 0
        {
            firstNumber = firstNumber * -1
            printValue.text = "\(firstNumber)"
        }
        if firstNumber < 0
        {
            printValue.text = "\(firstNumber)"
        }
        
    }

    @IBAction func percentButton(sender: UIButton) {
        
        let value = Double(firstNumber) * percentNumber
        printValue.text = "\(value)"
        
        
    }
    
    @IBAction func operatorPressed(sender: UIButton) {
        
        let operation = sender.currentTitle!
        
        if operation != "=" {
            
            currentOperator = operation
            println(currentOperator)
            
        } else {
            
            switch currentOperator {
                
            case "+":
                //do addition
                
                println("first number is \(firstNumber)")
                
                let value = firstNumber + secondNumber
                
                println("\(firstNumber) \(currentOperator) \(secondNumber) = \(value)")
                
                firstNumber = 0
                secondNumber = 0
                currentOperator = ""
                printValue.text = "\(value)"

            case "-":
                //do subtraction
                let value = firstNumber - secondNumber
                
                println("\(firstNumber) \(currentOperator) \(secondNumber) = \(value)")
                
                firstNumber = 0
                secondNumber = 0
                currentOperator = ""
                printValue.text = "\(value)"
                
                
            case "/":
                //do division
                let value = Double(firstNumber) / Double(secondNumber)
                
                println("\(firstNumber) \(currentOperator) \(secondNumber) = \(value)")
                
                firstNumber = 0
                secondNumber = 0
                currentOperator = ""
                printValue.text = "\(value)"
                
                            case "x":
                //do division
                let value = Double(firstNumber) * Double(secondNumber)
                
                println("\(firstNumber) \(currentOperator) \(secondNumber) = \(value)")
                
                firstNumber = 0
                secondNumber = 0
                currentOperator = ""
                printValue.text = "\(value)"

            default :
                //blah - if the condition is not met the default is a catch all
                println("blah")
                
                
            }
            
            
        }
        
        
    }


}

