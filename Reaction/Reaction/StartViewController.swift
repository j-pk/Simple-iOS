
///////////StartViewController\\\\\\\\\\

import UIKit
import GameKit

class StartViewController: UIViewController {

    @IBOutlet weak var topScoreLabel: UILabel!
    @IBOutlet weak var goButton: CircleButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        var button = CircleButton()
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        button.center = view.center
        view.addSubview(button)
        
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            
            //size is not read only and it works here
            button.frame.size.width = 200
            button.frame.size.height = 200
            button.center = self.view.center 

            
        })*/
        
        topScoreLabel.alpha = 0

        goButton.center = view.center
        goButton.alpha = 0
        
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            
            self.goButton.alpha = 1
            self.goButton.transform = CGAffineTransformMakeScale(1.0, 1.0)
            self.goButton.center = self.view.center
            
        })
        
        
        GKLocalPlayer.localPlayer().authenticateHandler = { (viewController, error) -> Void in
        
            if viewController != nil {
                
                self.presentViewController(viewController, animated: true, completion: nil)
                
            } else {
                
                println(GKLocalPlayer.localPlayer().authenticated)
                self.loadScore()
            }
            
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        loadScore()
        
    }
    
    func loadScore() {
        
        if GKLocalPlayer.localPlayer().authenticated == false { return }
        
        GKLeaderboard.loadLeaderboardsWithCompletionHandler { (leaderboards, error) -> Void in
            
            for leaderboard in leaderboards as! [GKLeaderboard] {
                
                if leaderboard.identifier == "circles_touched" {
                    
                    leaderboard.loadScoresWithCompletionHandler({ (scores, error) -> Void in
                        
                        self.topScoreLabel.text = "\(leaderboard.localPlayerScore.value)"
                        UIView.animateWithDuration(0.4, animations: { () -> Void in
                            
                            self.topScoreLabel.alpha = 1
                            
                        })
                        
                    })
                    
                }
                
            }
            
        }
        
    }
    

    @IBAction func go(sender: AnyObject) {
        
        if let gameVC = storyboard?.instantiateViewControllerWithIdentifier("GameVC") as? GameViewController {
            
            //array of viewcontroller, replacing the rootview controller with gameviewcontroller
            navigationController?.viewControllers = [gameVC]
            
        }
        
    }
}
