//
//  ViewController.swift
//  s3project2
//
//  Created by jpk on 6/18/15.
//  Copyright (c) 2015 Parker Kirby. All rights reserved.
//

import UIKit
import AmazonS3RequestManager
import AFNetworking
import AFAmazonS3Manager 

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
        
        dispatch_after(DISPATCH_TIME_NOW + NSEC_PER_SEC * 5, dispatch_get_main_queue()) { () -> Void in
            
            self.presentViewController(self.imagePicker, animated: true, completion: nil)

        }
    
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        //use photo - dismiss the picker
        picker.dismissViewControllerAnimated(true, completion: nil)
        //only saves image to s3 if there is an image
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
        
                saveImageToS3(image)
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let amazonS3Manager = AmazonS3RequestManager(bucket: bucket,
        region: .USStandard,
        accessKey: "",
        secret: "")
    
    let s3Manager = AFAmazonS3Manager(accessKeyID: accessKey, secret: secret)
    
//    let fileURL: NSURL = NSURL(fileURLWithPath: "pathToMyObject")
//    amazonS3Manager.putObject(fileURL, destinationPath: "pathToSaveObjectTo/fileName.jpg")

    func saveImageToS3(image: UIImage) {
        //make the image name dynamic
        let timestamp = Int(NSDate().timeIntervalSinceReferenceDate)
        //make it userName dynamic to replace myImage
        let imageName = "myImage_\(timestamp)"
        //
        let imageData = UIImagePNGRepresentation(image)
        
        s3Manager.requestSerializer.bucket = bucket
        s3Manager.requestSerializer.region = AFAmazonS3USStandardRegion
        
//        amazonS3Manager.putObject(imageData, destinationPath: imageName + ".png", acl: nil)
        
        
        //save the file locally - need a file path - must be saved in documentdirectory
        //expand tilde to the back root path
        if let documentPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).first as? String {
            
            let filePath = documentPath.stringByAppendingPathComponent(imageName + ".png")
            
            println(filePath)

            imageData.writeToFile(filePath, atomically: false)
            
            let fileURL = NSURL(fileURLWithPath: filePath)
            
//            amazonS3Manager.putObject(fileURL!, destinationPath: imageName + ".png", acl: AmazonS3PredefinedACL.Public)
//            
//            amazonS3Manager.putObject(imageData, destinationPath: imageName + ".png", acl: AmazonS3PredefinedACL.Public)
            
            s3Manager.putObjectWithFile(filePath, destinationPath: imageName + ".png", parameters: nil, progress: { (bytesWritten, totalBytesWritten, totalBytesExpectedToWrite) -> Void in
                
                let percentageWritten = CGFloat(totalBytesWritten) / CGFloat(totalBytesExpectedToWrite) * 100.0
                
                println("Uploaded \(percentageWritten)%")
                
            }, success: { (responseObject) -> Void in
                
                let info = responseObject as! AFAmazonS3ResponseObject
                
                println(responseObject)
                
            }, failure: { (responseObject) -> Void in
                
                println(responseObject)
            })
            
        }
        
    }
    
    
}

