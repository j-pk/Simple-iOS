
//////////MotionViewController\\\\\\\\\\

import UIKit
import CoreMotion
import SpriteKit

class MotionViewController: UIViewController {

    let manager = CMMotionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Loading the motionScene on top of the viewcontroller within a view 
        let motionScene = MotionScene()
        let sceneView = SKView(frame: view.frame)
        view.addSubview(sceneView)
        
        sceneView.presentScene(motionScene)
        sceneView.scene?.scaleMode = .AspectFill
        
        manager.startDeviceMotionUpdatesToQueue(NSOperationQueue.currentQueue()) { (deviceMotion, error) -> Void in
            
            //println("rotation x: \(deviceMotion?.rotationRate.x)")
            //println("rotation y: \(deviceMotion?.rotationRate.y)")
            //println("rotation z: \(deviceMotion?.rotationRate.z)")
            motionScene.physicsWorld.gravity = CGVector(dx: -deviceMotion.rotationRate.y, dy: deviceMotion.rotationRate.x * 10)
            
            //println(RadiansToDegrees(deviceMotion.attitude.yaw))
            
            let quat = deviceMotion.attitude.quaternion
            let myRoll = RadiansToDegrees(atan2(2*(quat.y*quat.w - quat.x*quat.z), 1 - 2*quat.y*quat.y - 2*quat.z*quat.z))
            let myPitch = RadiansToDegrees(atan2(2*(quat.x*quat.w + quat.y*quat.z), 1 - 2*quat.x*quat.x - 2*quat.z*quat.z))
            let myYaw = RadiansToDegrees(asin(2*quat.x*quat.y + 2*quat.w*quat.z))
            
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                //motionScene.physicsWorld.gravity = CGVector(dx: -myYaw, dy: 0)

                
            })
            
            println("\(RadiansToDegrees(deviceMotion.attitude.yaw)) \(myYaw)")
            
        }
        
        manager.startMagnetometerUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: { (magnetometerMotion, error) -> Void in
            
            //println(magnetometerMotion)
            
        })
        
        manager.startGyroUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: { (gyroData, error) -> Void in
            
            //println(gyroData)
            
        })
        
    
        
    }


}

func RadiansToDegrees (value:Double) -> Double {
    return value * 180.0 / M_PI
}