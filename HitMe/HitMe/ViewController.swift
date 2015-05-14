
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
    }
    
    func startNewRound() {
        
        targetValue = 1 + Int(arc4random_uniform(100))
        currentSliderValue = 50
        slider.value = Float(currentSliderValue)
    }
    
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var currentSliderValue = 0
    var targetValue = 0
    var score = 0
    
    @IBAction func showAlert() {
        
        let difference = abs(currentSliderValue - targetValue)
        let points = 100 - difference
        
        score += points
        
        let message = "You scored \(points) points!"
        let alert = UIAlertController(title: "Hit Me!", message: message, preferredStyle: .Alert)
        let action = UIAlertAction(title: "👍🏼", style: .Default, handler: nil)
        
        alert.addAction(action)
        
        presentViewController(alert, animated: true, completion: nil)
        startNewRound()
        updateLabels()
    
        }
    

}
