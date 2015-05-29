//
//  LoginViewController.swift
//  ParseLogin
//
//  Created by jpk on 5/28/15.
//  Copyright (c) 2015 Parker Kirby. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButtonCustom: UIButton!
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    
    @IBOutlet weak var logOutButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameLabel.hidden = true
        userEmailLabel.hidden = true
        logOutButton.hidden = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButton(sender: AnyObject) {
        
        
        PFUser.logInWithUsernameInBackground(userNameTextField.text, password: passwordTextField.text) { (user: PFUser?, error: NSError?) -> Void in
            if user != nil {

                self.userNameTextField.hidden = true
                self.passwordTextField.hidden = true
                self.loginButtonCustom.hidden = true
                
               self.userNameLabel.text = user!.username
               self.userEmailLabel.text = user!.email
                
                self.userEmailLabel.hidden = false
                self.userNameLabel.hidden = false
                self.logOutButton.hidden = false

                
            } else {
                
                self.performSegueWithIdentifier("StartViewController", sender: self)
                
            }
            
        }
        
        
    }
    @IBAction func logOutButtonClick(sender: AnyObject) {
        
        PFUser.logOut()
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
