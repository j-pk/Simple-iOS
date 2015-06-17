
import UIKit


extension Array {
    
    var middle: T {
        
       var countMiddle = count / 2
        
        return self[countMiddle]
        
    }
    
}

var ages = [12,23,41,53,63,21,23,43,59]

var names = ["Parker", "Bob", "Jim"]

ages.last
ages.first
ages.count

ages.sort(<)
ages.sort(>)
ages.insert(100, atIndex: 2)
ages.append(99)
ages.capacity
ages.endIndex
ages.reverse()
ages.removeLast()
ages.getMirror()

ages.middle
names.middle

protocol Ball {
    
    optional func caughtInTheOutField()

}

class Baseball: Ball {
    
    func caughtInTheOutField() {
        
        
    }
}
