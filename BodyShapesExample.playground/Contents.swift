//: Playground - noun: a place where people can play

import UIKit

//class is a blueprint we haven't called any properties from it yet
class BodyPart {
    
    var isDamaged = false
}

class Arm: BodyPart {
    
    var hand: Hand!
    
    override init() {
        
        hand = Hand()
    }
    
}

class Hand: BodyPart {
    
    var fingers: [Finger] = []
    
    override init() {
        
        fingers.append(Finger())
        fingers.append(Finger())
        fingers.append(Finger())
        fingers.append(Finger())
        fingers.append(Thumb())
        
    }
    
    func closeHand() {
        
        for finger in fingers {
            
            finger.fingerCurl()
            
        }
    }

}

//finger is a subclass of bodypart
class Finger: BodyPart {
    
    //property
    var boneCount: Int!
    
    func fingerCurl() {
        //self is a way to target instance object
        println("Curling \(self)")
    }
    
}



//Errors out because we have recognized or
//var rightThumb = Thumb()

class Thumb: Finger {
    
    //boolean true or false
    var isDoubleJointed = false
    
    func thumbsUp() {
        //thumbs up dude
    }
    
}

var leftArm = Arm()
leftArm.hand.closeHand()

leftArm.hand.fingers[0]



//() is calling a function or arguement
//calling a property 

var pointerFinger = Finger()
pointerFinger.boneCount = 3

//calling from BodyPart
pointerFinger.isDamaged = true


var leftThumb = Thumb()
leftThumb.isDamaged = false

Thumb().thumbsUp()


