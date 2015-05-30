import UIKit

func JediGreet(name: String, ability: String) -> (farewell: String, mayTheForceBeWithYou: String) {
    
    return ("Good Bye, \(name)."," May the \(ability) be with you.")
    
}

let reValue = JediGreet("old friend", "Force")
println(reValue)
println(reValue.farewell)
println(reValue.mayTheForceBeWithYou)

func JediTrainer() -> ((String, Int) -> String) {
    func train(name: String, times: Int) -> (String) {
        return "\(name) has been trained in the Force \(times) times"
    }
    return train
}
let train = JediTrainer()
train("Obi Wan", 3)

func JediBladeColor (colors: String...) -> () {
    for color in colors {
        println("\(colors)")
    }
}
JediBladeColor("red", "green")

let padawans = ["Knox", "Manus", "Avia"]
padawans.map({(padawans: String) -> String in "\(padawan) has been trained!"})

func applyMultiplication(value: Int, multFunction: Int -> Int) -> Int {
    
    return multFunction(value)
}

applyMultiplication(2, {value in value * 3})

applyMultiplication(2, {$0 * 3})

applyMultiplication(2) {$0 * 3}


