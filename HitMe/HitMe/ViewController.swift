
import UIKit

class ViewController: UIViewController {
    

    @IBAction func sliderMoved(slider: UISlider) {
        currentSliderValue = lroundf(slider.value)
        println("The value of the slider is now: \(slider.value)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewRound()
        updateLabels()
    }

    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
    func startNewRound() {
        
        round +=  1
        targetValue = 1 + Int(arc4random_uniform(100))
        currentSliderValue = 50
        slider.value = Float(currentSliderValue)
    }
    
    
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    var currentSliderValue = 0
    var targetValue = 0
    var score = 0
    var round = 0
    
    @IBAction func startOver(sender: UIButton) {
        
        score = 0
        round = 0
        startNewRound()
        updateLabels()
        
    }
    
    @IBAction func showAlert() {
        
        let difference = abs(currentSliderValue - targetValue)
        var points = 100 - difference
        
        var title: String
        if difference == 0 {
            title = "Perfect +100 points!"
            points += 100
        } else if difference < 5 {
            title = "So close! +50 points!"
            points += 50

        } else if difference < 10 {
            title = "Not bad!"
        } else {
            title = "Terrible.."
        }
        
        score += points

        
        let message = "You scored \(points) points!"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let action = UIAlertAction(title: "👍🏼", style: .Default, handler: { action in self.startNewRound(); self.updateLabels()})
        
        alert.addAction(action)
        
        presentViewController(alert, animated: true, completion: nil)
    
        }
    

}
