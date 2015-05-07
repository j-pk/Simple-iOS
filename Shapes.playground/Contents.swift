//: Playground - noun: a place where people can play

import UIKit

enum ShapeType : Int {
    
    case Triangle = 3
    case Rectangle = 4
    case Pentagon = 5
    case Hexagon = 6
    case Septagon = 7
    case Octogon = 8
    
}

class Shape {
                //implictly declared optional ! = I plan on setting a value ? = may or may not have a value

    var sides: Int! //! optional needs declared init because you're declaring a value
    
    var fillColor: UIColor?
    var strokeColor: UIColor?
    
    //creation function 
    //this occurs at the point of initialization
    init (type: ShapeType){
        
        switch type {
            
        case ShapeType.Rectangle: sides = 4
        case ShapeType.Triangle: sides = 3
        case ShapeType.Pentagon: sides = 5
        case ShapeType.Hexagon: sides = 6
        case ShapeType.Septagon: sides = 7
        case ShapeType.Octogon: sides = 8 
            
        }
        
    }
    
    
}

var square = Shape(type: .Rectangle)

square.fillColor = UIColor.blueColor()

var triangle = Shape(type: .Triangle)

var num1: Int?
var num2: Int?

num1 = 4








