//: Playground - noun: a place where people can play

import UIKit

//  Create a playground
//  - Make a Class BodyParts
//  - Make 20 Classes that are BodyParts (You make a class Hand and subclass Thumb)
//  - Each class will have 3 properties (eyeColor: UIColor, teeth: Int)
//  - Each class will have 3 methods (chew(), sprain())
//  - At least 15 methods need to be call from another BodyParts
//  - At least 10 properties need to be other BodyParts

println("hello")

class BodyParts {
    
}

class Head: BodyParts {
    var largeHead: Bool = false
    var smartBrain: Bool = false
    var goofyFace: Bool = false
    
    func nodHead () {
        //nod head when greeting
        println("Head Nod")
    }
    
    func superSmartAnswer () {
       
    }
    
}
//class
class Mouth: Head {

    //properties
    var lipsColor: UIColor!
    var teethCount: Int

    var badBreath: Bool = false
    var fullOfFood: Bool = false
    
    init(teeth: Int, lips: UIColor){
    teethCount = teeth
    lipsColor = lips
    }
    
    //method 1
    func chewFood(food: AnyObject) {
        //chew 3 times then swallow
    }
    //method 2
    func yawn() {
        //open mouth to release enzyme to awaken brain
    }
    //method 3
    func smile() {
        let head = Head()
        head.nodHead
    }
    
}

class Cheeks: Head {
    
    var cheekColor: UIColor!
    var pimpleFace: Bool = false
    var smoothCheek: Bool = false
    var bushyBeard: Bool = false
    
    //method 1
    func blush() {
        //blushy cheeks
    }
    //method 2
    func slap() {
        //slap
        RightArm().liftArm()
        RightHand().falconPunch()
    }
    //method 3
    func beard() {
        //bearded
    }
    //calling a property
    var mySmile = Mouth(teeth: 3, lips: <#UIColor#>.blueColor())
    myBeardSmile.badbreath = true
    myBeardMouth.fullOfFood = false

    

class Eye: Head {
    //properties
    var eyeColor: UIColor!
    var ethnicRace: Bool = false
    var eyeLashes: Int!
    
    //method 1
    func blink() {
        //blink if sun is in eyes
    }
    //method 2
    func sad() {
        //shed a tear when sad
    }
    //method 3
    func daze() {
        //look confused when under the influence
    }
    
}

class Ear: Head {
    
    var earShape: String!
    var hearWell: Bool = false
    var earHair: Bool = false
    
    //method 1 
    func hear() {
        //listen for sound
    }
    //method 2
    func wax() {
        //say what?
    }
    //method 3
    func zoneOut() {
        //do no register any noise
    }
    
}

class Nose: Head {
    
    var goodSmell: Bool = false
    var hairyNose: Bool = false
    var bigNose: Bool = false
    
    //method 1 
    func pickNose() {
        //pick nose
        LeftArm().lift()
        LeftHand().extendFinger()
    }
    func blowNose() {
        //blow nose
    }
    func pluckNose() {
        //pluck nose
    }
    
}

class Torso: BodyParts {
    
    var broadChest: Bool = false
    var hairyChest: Bool = false
    var clotheShirt: Bool = false
    
    func chesty() {
        //if posing for picture, chesty
        RightArm().bendArm()
    }
    func rub() {
        //if hungry, rub
        RightArm().bendArm()
        RightHand().highFive()
    }
    func gorilla() {
        //if aggressive, pound chest
    }
    
}

class Arm: Torso {
    
    var strongArm: Bool!
    var hairyArm: Bool!
    var longArm: Int!
    var watchArm: Bool = false
    var skinMoles: Int?
    
    func lift() {
        //lift arm
    }
    func falconPunch() {
        //super saijin punch
    }
    func highFive() {
        //highfive
    }
}

class LeftArm: Arm {
    
    var appleWatchColor: UIColor?
    var appleWatchSize: Int?
    var appleWatchVersion: String!
    
    func appleWatch() {
        //check Apple Watch
    }
    func pickNose() {
        //picknose
    }
    func saluteDude() {
        //salute someone or something
    }
    var myRightA = Arm()
    myRightA.strongArm = true
    myRightA.hairyArm = false
    myRightA.longArm = true
    myRightA.watchArm = false
    
}

class LeftHand: LeftArm {
    
    var numberOfFingers: Int!
    var lengthOfFingers: Int!
    var smoothHangs: Bool = false
    
    func extendFinger() {
        //extend fingers out
    }
    func closeFist() {
        //close first
    }
    func peaceItOut() {
        //peace it out
    }
    
}
    
class RightArm: Arm {
    
    var paddleType: String = "Butterfly"
    var bicepWidth: Int!
    var muscleCount: Int!
    
    func bendArm() {
        //bend arm
    }
    func swingPaddle() {
        //swing paddle
    }
    func liftArm() {
        //lift arm
    }
  }
    
class RightHand: RightArm {
    
    var fistSize = Int()
    var spock: Bool = false
    var cashAmount = Int()
    
    func poundIt() {
        //fist pound
    }
    func itIsMeSpock() {
        //spock greeting
    }
    func giveMeMoney() {
        //give me my money gesture
    }

}
    
class Hip: BodyParts {
    
    var wideHips: Bool!
    var bigButt: Bool!
    var waistSize: Int!
    
    func wobble() {
        //if bigbutt is true, wobble
    }
    func pants() {
        //if pants size is > 32 wear pants
    }
    func shake() {
        //shake waist
    }
    
class Legs: Hip {
    
    var hairyLegs: Bool = false
    var longLegs: Int!
    var chubbyLegs: Bool = false
    
    func kickJump() {
        //jump with both legs
        //extend right foot - release dart, kill and confirm kill
        RightFoot().flexTheKnife()
        RightFoot().confirmKill()
    }
    
    func slideMcgee() {
        //going in for a slide
    }
    func sparkleRoller(){
        //roller skate
    }

}

class LeftLeg: Legs {
    var electronicLeg: Bool = false //darn 
    var rocketBoosters: Bool = false
    var sonicHedgeHogSpeed: Bool = true
    
    func hopHop() {
        //hop
    }
    func superSaijinKick() {
        //there goes your head
        //combo attack with a kick and machine
        RightLeg().aimMachineGun()
        RightLeg().ammoCount
        
    }
    func knifeAnkle() {
        //yea, knife leg
    }
    func extendLeftLeg() {
        
    }
    
}

class RightLeg: Legs {
    var machineGunLeg: Bool = true
    var ammoCount: Int!
    var legWeight: Int!
    
    func aimMachineGun() {
        //there goes the neighborhood
    }
    func reloadLeg() {
        //lock, stock and barrell
    }
    func duckAndCover() {
        //hide leg with cloaking device
    }
    
}

class LeftFoot: Legs {
    var poisonDartToe: Bool = true
    var toeCount: Int!
    var webFeet: Bool!
    
    func flingToeDart()
    {
        //silent but deadly
    }
    func releaseSmellyFeet() {
        //Pepe Le Pew
    }
    func sumoPound() {
        //lift leg and stomp, Sumo Style
    }

}

class RightFoot: Legs {
    var toeNailKnife: Bool = false //oh man...
    var knifeLength: Int!
    var knifeColor: UIColor?
    
    func flexTheKnife() {
        //toe knife extends
        //double wammy toe attack
        LeftLeg().extendLeftLeg()
        LeftFoot().flingToeDart()
        
    }
    func shootTheKnife() {
        //knife dart
    }
    func confirmKill() {
        //toe sensor confirms kill
    }
    
    
}

//var rightA = RightArm()
//rightA.strongArm = true




