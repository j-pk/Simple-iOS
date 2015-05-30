
import UIKit


func isDivisble(firstNumber: Int, secondNumber: Int) -> Bool? {
    
    if firstNumber % secondNumber == 0 {
        return true
    } else {
        return nil
    }
    
}

isDivisble(2, 1)
isDivisble(1231, 92)

if let result = isDivisble(15, 4) {
    println("Divisible")
} else {
    println("Not Divisible")
}


