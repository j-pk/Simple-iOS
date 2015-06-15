//
//  ViewController.swift
//  Himitsu
//
//  Created by jpk on 6/15/15.
//  Copyright (c) 2015 Parker Kirby. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var messageButton: UIButton!
    
    @IBOutlet weak var nameButton: UIButton!
    
    @IBOutlet weak var chatField: UITextField!
    
    var myName: String?
    
    var myFireBase = Firebase(url:"https://himitsu.firebaseio.com")
    
    var chatMessages: [[String:AnyObject]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Read data and react to changes
        myFireBase.observeEventType(.Value, withBlock: {
            snapshot in
            
            let data = snapshot.value as! [String:AnyObject]
            
            self.chatMessages = data["messages"] as! [[String:AnyObject]]
            
        })
    
    }

    @IBAction func saveName(sender: AnyObject) {
        
        myName = chatField.text
        
        nameButton.hidden = true
        messageButton.hidden = false
        
    }
    
    @IBAction func sendMessage(sender: AnyObject) {
        
        //appeding info to messages
        let fireBaseMessages = myFireBase.childByAppendingPath("messages")
        //give user an unique id
        let fireBaseMessage = fireBaseMessages.childByAutoId()
        
        let message = [
        
            "message" : chatField.text,
            "name" : myName
            
        ]
        
        fireBaseMessages.setValue(message)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

