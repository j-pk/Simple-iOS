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
    
    var savedName: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    var myDate: Double {
//        let dateFormatter = NSDateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd 'at' h:mm a"
//        return dateFormatter.stringFromDate(NSDate())
        return NSDate().timeIntervalSince1970
    }

    
    var myFireBase = Firebase(url:"https://himitsu.firebaseio.com")
    
    var chatMessages: [String:[String:AnyObject]] = [:]
    
    @IBOutlet weak var messagesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println(myDate)
    
        messagesTableView.dataSource = self
        messagesTableView.delegate = self 
    
        // Read data and react to changes
        myFireBase.observeEventType(.Value, withBlock: {
            snapshot in
            
            if let data = snapshot.value as? [String:AnyObject] {
                
                println(snapshot.value)
            
                self.chatMessages = data["messages"] as! [String:[String:AnyObject]]
                
                self.messagesTableView.reloadData()
            }
            
        })
        
        if let loadSavedName = savedName.objectForKey("savedNameToDefaults") as? String {
            myName = savedName.objectForKey("savedNameToDefaults") as? String
            nameButton.hidden = true
            messageButton.hidden = false
        }
        
        
    
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
//        map(chatMessages, { (message) -> [String:AnyObject] in
//            
//            
//            
//        })
        
        
        return chatMessages.values.array.count
    
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("messageCell") as! UITableViewCell
        
        
        var sortedArray = sorted(chatMessages.values.array, { (message1, message2) -> Bool in
            
            let time1 = message1["time"] as! Double
            let time2 = message2["time"] as! Double
            
            return time1 > time2
            
        })
        
        
        let message = sortedArray[indexPath.row]
        
        cell.textLabel?.text = message["name"] as? String
        cell.detailTextLabel?.text = message["message"] as? String
        
        var sortedByTime = message["time"] as? String

        
        return cell
        
    }

    @IBAction func saveName(sender: AnyObject) {
        
        
        savedName.setObject(self.chatField.text, forKey: "savedNameToDefaults")
        savedName.synchronize()
        
        myName = chatField.text
        
        nameButton.hidden = true
        messageButton.hidden = false
        
        chatField.text = ""
        
    }
    
    @IBAction func sendMessage(sender: AnyObject) {
        
        //appending info to messages
        let fireBaseMessages = myFireBase.childByAppendingPath("messages")
        //give user an unique id
        let fireBaseMessage = fireBaseMessages.childByAutoId()
        
        let message = [
        
            "message" : chatField.text,
            "name" : myName!,
            "time" : myDate
            
        ]
        
        println(myDate)
        
        chatField.text = ""

        fireBaseMessage.setValue(message)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

