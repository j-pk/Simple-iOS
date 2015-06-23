
import UIKit

let DEBUG = true
//2
// create a global function that returns UIColor based on a string


////////////my code
var arrayOfColors = ["green", "blue", "cyan", "gray", "red"]

var arrayName = ["Completed", "Pending", "Casual", "Low", "Urgent"]

func categoryInfo(index: Int) -> (String, String) {
    
    return (arrayOfColors[index], arrayName[index])
    
}

var colors = [
    "green" : UIColor.greenColor(),
    "blue" : UIColor.blueColor(),
    "cyan" : UIColor.cyanColor(),
    "gray" : UIColor.darkGrayColor(),
    "red" : UIColor.redColor()
]

func colorFromtString(color: String) -> UIColor {
    
    return colors[color]!
    
}
//////////

//lecture example of homework
let categories: [String:(String, UIColor)] = [

    "Red" : ("Lava", UIColor.redColor()),
    "Blue" : ("Sky", UIColor.cyanColor()),
    "Yellow" : ("Lazy", UIColor.yellowColor()),
    "Purple" : ("Unicorn", UIColor.purpleColor()),
    "Orange" : ("Fruit", UIColor.orangeColor())

]

func categoryColor(name: String) -> UIColor {
    
    return categories[name]!.1

}