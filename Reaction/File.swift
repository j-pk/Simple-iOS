
///////////GameViewController\\\\\\\\\\

import UIKit
import GameKit

let π = M_PI

class GameViewController: UIViewController {
    
    var currentCircles: [CircleButton] = []
    var timerBar = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 10))
    var currentCorrectChoice = Int(arc4random_uniform(4))
    var circle = CircleButton()
    var rotatingView = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 600))
    var currentScore = 0 {
        
        didSet { scoreLabel.text = "\(currentScore)" }
        
    }
    
    var scoreLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 100))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timerBar.backgroundColor = UIColor.whiteColor()
        view.addSubview(timerBar)
        
        scoreLabel.textColor = UIColor.whiteColor()
        scoreLabel.font = UIFont(name: "HelveticaNeue-UltraLight", size: 72)
        scoreLabel.text = "0"
        scoreLabel.frame.origin.y = view.frame.height - 120
        scoreLabel.frame.size.width = view.frame.width
        scoreLabel.textAlignment = NSTextAlignment.Center
        view.addSubview(scoreLabel)
        
        view.addSubview(rotatingView)
        
        animateNewCirclesIn()
    }
    
    func runTimer(seconds: NSTimeInterval) {
        
        timerBar.layer.removeAllAnimations()
        
        timerBar.frame.size.width = view.frame.width
        
        UIView.animateWithDuration(seconds, animations: { () -> Void in
            
            self.timerBar.frame.size.width = 0
            
            }) { (finished) -> Void in
                
                if finished { self.gameOver() }
                
        }
        
    }
    
    func animateNewCirclesIn() {
        
        runTimer(1.0)
        
        var cW = (view.frame.width - 120) / 2
        var cR = cW / 2
        
        //top left, top right, bottom left, bottom right
        //(x, y)
        var directions: [(CGFloat, CGFloat)] = [(-1,-1),(1,-1),(-1,1),(1,1)]
        
        for c in 0..<4 {
            
            circle.choice = c
            circle.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            circle.center = view.center
            view.addSubview(circle)
            
            //if current circle 1.0 else 0.5
            circle.alpha = c == currentCorrectChoice ? 1.0 : 0.5
            
            circle.addTarget(self, action: "tapCircle:", forControlEvents: .TouchUpInside)
            
            currentCircles.append(circle)
            
            let (dx, dy) = directions[c]
            
            let randomAnimationSpeed = Double(arc4random_uniform(60) + 40) / 100
            
            UIView.animateWithDuration(randomAnimationSpeed, delay: 0.0, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
                
                self.circle.alpha = 0.5
                
                self.circle.frame.size.width = cW
                self.circle.frame.size.height = cW
                
                let x = self.view.center.x + dx * (cR + 10)
                let y = self.view.center.y + dy * (cR + 10)
                
                self.circle.center = CGPoint(x: x, y: y)
                
                }, completion: nil)
            
        }
        
    }
    
    func rotateView() {
        
        UIView.animateWithDuration(1.0, delay: 1.0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
            
            self.rotatingView.transform = CGAffineTransformRotate(self.rotatingView.transform, CGFloat(π))
            
            }) { (finished) -> Void in
                
                self.rotateAgain()
                
        }
        
    }
    
    func rotateAgain() {
        
        UIView.animateWithDuration(1.0, delay: 1.0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
            
            self.rotatingView.transform = CGAffineTransformRotate(self.rotatingView.transform, CGFloat(π))
            
            }) { (finished) -> Void in
                
                self.rotateView()
                
        }
        
    }
    
    func animateOldCirclesOut() {
        
        var cW = (view.frame.width - 120) / 2 * 3
        
        for circle in currentCircles {
            
            circle.choice = 4
            
            let distX = circle.center.x - view.center.x
            let distY = circle.center.y - view.center.y
            
            UIView.animateWithDuration(1.0, animations: { () -> Void in
                
                circle.frame.size.width = cW
                circle.frame.size.height = cW
                
                circle.center = CGPoint(x: distX * 6 + self.view.center.x, y: distY * 6 + self.view.center.y)
                
                }, completion: { (finished) -> Void in
                    
                    circle.removeFromSuperview()
                    
            })
            
        }
        
    }
    
    func gameOver() {
        
        animateOldCirclesOut()
        let gameOverLabel = UILabel(frame: view.frame)
        gameOverLabel.textColor = UIColor.whiteColor()
        gameOverLabel.textAlignment = .Center
        gameOverLabel.text = "GAME OVER"
        gameOverLabel.font = UIFont(name: "HelveticaNeue-UltraLight", size: 60)
        gameOverLabel.alpha = 0
        view.addSubview(gameOverLabel)
        
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            
            gameOverLabel.alpha = 1
            
            }) { (finished) -> Void in
                
                UIView.animateWithDuration(1.6, animations: { () -> Void in
                    
                    gameOverLabel.alpha = 0
                    self.scoreLabel.alpha = 0
                    
                    }) { (finished) -> Void in
                        
                        self.endGame()
                        
                }
                
        }
        
    }
    
    func endGame() {
        
        if let startVC = storyboard?.instantiateViewControllerWithIdentifier("startVC") as? StartViewController {
            
            navigationController?.viewControllers = [startVC]
            
        }
        
    }
    
    func tapCircle(circle: CircleButton) {
        
        //check if the button is correct
        
        if circle.choice == currentCorrectChoice {
            
            currentScore++
            
            //report score to leaderboard
            let reportScore = GKScore(leaderboardIdentifier: "circles_touched")
            reportScore.value = Int64(currentScore)
            GKScore.reportScores([reportScore], withCompletionHandler: { (error) -> Void in
                println("reported")
            })
            
            currentCorrectChoice = Int(arc4random_uniform(4))
            
            animateOldCirclesOut()
            
            currentCircles = []
            
            animateNewCirclesIn()
            
        } else {
            
            gameOver()
        }
        
        
    }
    
    
}
