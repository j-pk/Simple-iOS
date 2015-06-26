
import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var imagePicker = UIImagePickerController()
    
    var myImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.sourceType = .Camera
        imagePicker.delegate = self
    
        myImageView.frame = view.frame
        myImageView.contentMode = UIViewContentMode.ScaleAspectFill
        view.addSubview(myImageView)
        
        var showCamera = UIButton(frame: CGRectMake(0, 0, 100, 100))
        showCamera.center = CGPointMake(UIScreen.mainScreen().bounds.width / 2, UIScreen.mainScreen().bounds.height - 70)
        
        showCamera.backgroundColor = UIColor.lightGrayColor()
        showCamera.layer.cornerRadius = 50
        
        view.addSubview(showCamera)
        
        showCamera.addTarget(self, action: "showImagePicker", forControlEvents: .TouchUpInside)
        
        var newMask = UIButton(frame: CGRectMake(10, 10, 40, 40))
        newMask.backgroundColor = UIColor.lightGrayColor()
        newMask.layer.cornerRadius = 20
        
        view.addSubview(newMask)
        newMask.addTarget(self, action: "addNewMask", forControlEvents: .TouchUpInside)
        
        //colon is the sender
        var pinchGesture = UIPinchGestureRecognizer(target: self, action: "resizeMask:")
        //listens for gesture
        view.addGestureRecognizer(pinchGesture)
        
    }
    
    //making a functions to determine if you're pinching or releasing
    func resizeMask(gr: UIPinchGestureRecognizer) {
        
        if let currentMask = currentMask {
            
            let width = currentMask.frame.width
            let height = currentMask.frame.height
            
//            let scale = 1.0 - ((1.0 - gr.scale) / 2)
            
            currentMask.frame.size.height = height + gr.velocity
            currentMask.frame.size.width = width + gr.velocity
            
            println(gr.scale)
            
        }
        
    }
    
    var currentMask: UIImageView?
    
    func addNewMask() {
        
        var newMaskView = UIImageView(frame: CGRectMake(0, 0, 200, 200))
        
        newMaskView.image = UIImage(named: "mask")
        newMaskView.contentMode = UIViewContentMode.ScaleAspectFill
        newMaskView.center = view.center
        
        view.addSubview(newMaskView)
        
        currentMask = newMaskView
        
    }
    
    func showImagePicker() {
        
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        var image = info[UIImagePickerControllerOriginalImage] as? UIImage
        myImageView.image = image
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        
        
    }
    var startTouchLocation: CGPoint!
    //going to fix the image from jumping from where finger touch to second touch 
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        if touches.count > 1 { return }
        
        if let touch = touches.first as? UITouch {
            
            startTouchLocation = touch.locationInView(view)
            
            
        }
        
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        //shouldn't move image if two fingers or more touch the screen
        if touches.count > 1 { return }
        
        if let touch = touches.first as? UITouch {
            
            let location = touch.locationInView(view)
            
            let distance = CGPointMake(location.x - startTouchLocation.x, location.y - startTouchLocation.y)
            
            if let currentMask = currentMask {
            
                currentMask.center = CGPointMake(currentMask.center.x + distance.x, currentMask.center.y + distance.y)
            
            }
            
            startTouchLocation = location
        
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        
    
    }


}

