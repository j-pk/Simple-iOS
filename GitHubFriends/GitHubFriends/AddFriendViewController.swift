//
//  AddFriendViewController.swift
//  GitHubFriends
//
//  Created by jpk on 5/13/15.
//  Copyright (c) 2015 Parker Kirby. All rights reserved.
//

import UIKit

class AddFriendViewController: UIViewController {

    var friendInfo: [String:AnyObject?]! {
        
        didSet {
    
            let friendEndpoint = friendInfo["name"] as! String
            
            if let friendInfo = GithubRequest.getInfoWithEndpoint(friendEndpoint) as? [[String:AnyObject]] {
                
                friends = friendInfo
                
            }
            
        }
        
        
    }
    
    var friends: [[String:AnyObject]] = []
    
    @IBOutlet weak var addFriendField: UITextField!
    
    @IBAction func addFriendButton(sender: AnyObject) {
        
        let friendEndpoint = "https://api.github.com/users/\(addFriendField.text)"
        
        println(friendEndpoint)
        
//        friends.in
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func cancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
