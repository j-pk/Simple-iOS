//
//  ViewController.swift
//  CalculatorFunctions
//
//  Created by jpk on 5/5/15.
//  Copyright (c) 2015 Parker Kirby. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var firstNumber = 0
    var secondNumber = 0
    var value: Double = 0
    var currentOperator = ""
    
    @IBAction func pressedButton1(sender: UIButton) {
        //sender is an arguement, UIButton is an object
       
        let number = sender.currentTitle!.toInt()!
        
        if currentOperator.isEmpty {
            
            firstNumber = number
            println("\(firstNumber)")
            
        } else {
            
            secondNumber = number
            println("\(secondNumber)")
        }
        
    }
    
//       println("Pressed Button " + sender.currentTitle!)
    
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
            
            case "-":
            //do subtraction
                let value = firstNumber - secondNumber
                
                println("\(firstNumber) \(currentOperator) \(secondNumber) = \(value)")
                
                firstNumber = 0
                secondNumber = 0
                currentOperator = ""
                
                
            case "/":
                //do division
                let value = Double(firstNumber) / Double(secondNumber)
                
                println("\(firstNumber) \(currentOperator) \(secondNumber) = \(value)")
                
                firstNumber = 0
                secondNumber = 0
                currentOperator = ""
                

            default :
            //blah - if the condition is not met the default is a catch all
            println("blah")
            
            
            }
    
            
        }
    
    
    }
 
}