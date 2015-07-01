
import UIKit

class ViewController: UIViewController {
    
    var gravity: UIGravityBehavior!
    var animator: UIDynamicAnimator!
    var collision: UICollisionBehavior!
    var snap: UISnapBehavior!
    var attachment: UIAttachmentBehavior!
    var anchorView: UIView!
    var squareView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: Selector("handleTap:"))
        view.userInteractionEnabled = true
        view.addGestureRecognizer(tap)

        self.squareView = UIView(frame: CGRect(x: 200, y: 200, width: 90, height: 90))
        squareView.backgroundColor = UIColor(red:0.29, green:0.73, blue:0.34, alpha:1)
        view.addSubview(squareView)
        
        ///Gravity??
        animator = UIDynamicAnimator(referenceView: view)
        gravity = UIGravityBehavior(items: [squareView])
        animator.addBehavior(gravity)
        
        //Collision? 
        collision = UICollisionBehavior(items: [squareView])
        collision.translatesReferenceBoundsIntoBoundary = true
        //collision?.addBoundaryWithIdentifier("barrier", fromPoint: CGPointMake(self.view.frame.origin.x, 350), toPoint: CGPointMake(self.view.frame.origin.x + self.view.frame.width, 350))
        animator.addBehavior(collision)
        
        //Attachment?
        self.anchorView = UIView(frame: CGRect(x: view.center.x, y: view.center.y, width: 10, height: 10))
        anchorView.backgroundColor = UIColor(red:0.14, green:0.51, blue:0.71, alpha:1)
        view.addSubview(anchorView)
        attachment = UIAttachmentBehavior(item: squareView, attachedToAnchor: anchorView.center)
        attachment.length = 100
        attachment.frequency = 10
        attachment.damping = 5
        animator.addBehavior(attachment)
    
    }
    
    func handleTap(sender: UITapGestureRecognizer) {
        
        if sender.state == .Ended {
        
        let tapPoint: CGPoint = sender.locationInView(view)
            
            if (snap != nil) {
                animator!.removeBehavior(snap)
            }
            
            snap = UISnapBehavior(item: squareView, snapToPoint: tapPoint)
            animator!.addBehavior(snap)
            
            attachment.anchorPoint = sender.locationInView(view)
            anchorView.center = sender.locationInView(view)

            
        }
    
    }

}

