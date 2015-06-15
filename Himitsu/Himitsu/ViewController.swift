//
//  ViewController.swift
//  Himitsu
//
//  Created by jpk on 6/15/15.
//  Copyright (c) 2015 Parker Kirby. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var messageButton: UIButton!
    
    @IBOutlet weak var nameButton: UIButton!
    
    @IBOutlet weak var chatField: UITextField!
    
    var myName: String?
    
    var myFireBase = Firebase(url:"https://secret-room.firebaseio.com")
    
    var chatMessages: [String:[String:AnyObject]] = [:]
    
    @IBOutlet weak var messagesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messagesTableView.dataSource = self
        messagesTableView.delegate = self 
    
        // Read data and react to changes
        myFireBase.observeEventType(.Value, withBlock: {
            snapshot in
            
            if let data = snapshot.value as? [String:AnyObject] {
            
                self.chatMessages = data["messages"] as! [String:[String:AnyObject]]
                
                self.messagesTableView.reloadData()
            }
            
        })
    
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return chatMessages.values.array.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("messageCell") as! UITableViewCell
        
        let message = chatMessages.values.array[indexPath.row]
        
        cell.textLabel?.text = message["name"] as? String
        cell.detailTextLabel?.text = message["message"] as? String
        
            return cell
    }

    @IBAction func saveName(sender: AnyObject) {
        
        myName = chatField.text
        
        nameButton.hidden = true
        messageButton.hidden = false
        
        chatField.text = ""
        
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
        
        chatField.text = ""

        fireBaseMessage.setValue(message)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

