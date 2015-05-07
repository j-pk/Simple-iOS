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
    
    //This clears the label, AC Button
    @IBAction func clearButton(sender: UIButton) {

          printValue.text = "\(value)"
    }
    @IBAction func decimalPressed(sender: UIButton) {
        
        printValue.text = "\(firstNumber)" + "."
        
    }
    
    //This is registering the value of the first and second button pressed
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
    
    //This is my partially working value changer for int
    @IBAction func plusMinus(sender: UIButton) {
        
        if firstNumber > 0
        {
            firstNumber = firstNumber * -1
            printValue.text = "\(firstNumber)"
            println(firstNumber)
        }
        
        if firstNumber < 0
        {
            firstNumber = firstNumber * 1
            printValue.text = "\(firstNumber)"
            println(firstNumber)
        }
        
    }
    
    //This is my partially working percent or mutliplying a value to 0.01
    //Let is a static variable
    @IBAction func percentButton(sender: UIButton) {
        
        let value = Double(firstNumber) * percentNumber
        printValue.text = "\(value)"
        
        
    }
    
    //This is a switch for operator functionality - THIS IS A CONDITIONAL
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
                
                //In order to clear out the calculator this loop? is needed for each operator 
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

