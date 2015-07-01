
import UIKit
import AVFoundation

class ViewController: UIViewController, AVCaptureAudioDataOutputSampleBufferDelegate {

    var audioSession = AVAudioSession()
    var audioDataOutput = AVCaptureAudioDataOutput()
    var audioCaptureSession = AVCaptureSession()
    
    var powerLevel: Float = 0
    
    let colorArray = [UIColor(red:0.14, green:0.33, blue:0.46, alpha:1), UIColor(red:0.63, green:0.2, blue:0.59, alpha:1), UIColor(red:0.29, green:0.73, blue:0.34, alpha:1), UIColor(red:0.14, green:0.51, blue:0.71, alpha:1), UIColor(red:0.66, green:0.39, blue:0.2, alpha:1)]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //silence playback and record audio
        audioSession.setCategory(AVAudioSessionCategoryRecord, error: nil)
        //select mode to record
        audioSession.setMode(AVAudioSessionModeMeasurement, error: nil)
        //turn record on
        audioSession.setActive(true, error: nil)
        //rate to record at
        audioSession.setPreferredSampleRate(48000, error: nil)

        //setting device to allow recording
        let myDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeAudio)
        let audioCaptureInput = AVCaptureDeviceInput(device: myDevice, error: nil)
        
        //cordinate data from output to input - mic to device
        audioCaptureSession.addInput(audioCaptureInput)
    
        //
        audioDataOutput.setSampleBufferDelegate(self, queue: dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0))
        
        audioCaptureSession.addOutput(audioDataOutput)
        
        //pulling it from input to output
        audioCaptureSession.startRunning()
        
        
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, fromConnection connection: AVCaptureConnection!) {
        
        println(connection.audioChannels.first?.averagePowerLevel)
        
        if let audioChannel = connection.audioChannels.first as? AVCaptureAudioChannel {
            
            let power = audioChannel.averagePowerLevel + 50
            
            powerLevel = power
            
            if power < 25 { return }
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                var randomColor = Int(arc4random_uniform(UInt32(self.colorArray.count)))
                self.view.backgroundColor = self.colorArray[randomColor]
                self.createABall()
                
                
            })
        
        
        }
        
    }
    
    func createABall() {
        var ballSize: UInt32 = 125
        var bubble = UIView(frame: CGRect(x: self.view.center.x, y: self.view.frame.height, width: CGFloat(arc4random_uniform(ballSize)), height: CGFloat(arc4random_uniform(ballSize))))
        var randomColor = Int(arc4random_uniform(UInt32(colorArray.count)))
        bubble.backgroundColor = colorArray[randomColor]
        bubble.layer.cornerRadius = CGFloat(arc4random_uniform(ballSize))
        self.view.addSubview(bubble)
        
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            
            let randomX = CGFloat(arc4random_uniform(UInt32(self.view.frame.width)))
            let randomY = self.view.center.y - CGFloat((self.powerLevel - 5) * 10)
            
            bubble.center = CGPoint(x: randomX, y: randomY)
            
        }) { (finished) -> Void in
            
            bubble.removeFromSuperview()
            
            
        }
        
        
    }

}

