//
//  ViewController.swift
//  ParseLogin
//
//  Created by jpk on 5/28/15.
//  Copyright (c) 2015 Parker Kirby. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signUpButton(sender: AnyObject) {
        
        var user = PFUser()
        
        user.username = userNameTextField.text
        user.email = emailTextField.text
        user.password = passwordTextField.text 
        
        user.signUpInBackgroundWithBlock { (succeeded: Bool, error: NSError?) -> Void in
            
            if let error = error  {
                let errorString = error.userInfo?["error"] as? NSString
            } else {
                
            }
            
        }
        
    }
    

}

