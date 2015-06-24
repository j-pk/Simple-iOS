//
//  ListTableViewController.swift
//  HighPriority
//
//  Created by jpk on 5/11/15.
//  Copyright (c) 2015 Parker Kirby. All rights reserved.
//

import UIKit

enum Priority {
    
    case Completed
    case Pending
    case Casual
    
}


class ListTableViewController: UITableViewController {
    
    //[Key:Value] - Dictionary
    //An array of dictionaries
    //Usually make an array with TableView
    var listItems: [[String:AnyObject]] = [
        //
//       [
//            "name" : "Sleep",
//            "timeCreated" : NSDate(),
//            "priority" : 0,
//            "completed" : false
//        ],
//        [
//            "name" : "Get food",
//            "timeCreated" : NSDate(),
//            "priority" : 1,
//            "completed" : false
//        ],
//        [
//        
//            "name" : "Take out trash",
//            "timeCreated" : NSDate(),
//            "priority" : 2,
//            "completed" : false
//        
//        ]
    
    ]

    var priorityChoice = 0
    
    @IBOutlet weak var itemNameField: UITextField!
    
    @IBOutlet weak var innerHighCircle: priorityButton!
    @IBOutlet weak var createColor: UIButton!
    @IBOutlet weak var highCircle: priorityButton!
    @IBOutlet weak var midCircle: priorityButton!
    @IBOutlet weak var lowCIrcle: priorityButton!
    
    @IBAction func highClick(sender: AnyObject) {
        priorityChoice = 0
        
        
    }
    @IBAction func midClick(sender: AnyObject) {
        priorityChoice = 1
    }
    
    @IBAction func lowClick(sender: AnyObject) {
       priorityChoice = 2
    }

    @IBAction func createItem(sender: AnyObject) {
        
        var itemInfo = [
            "name" : itemNameField.text,
            "timeCreated" : NSDate(),
            "priority" : priorityChoice,
            "completed" : false
        
        ]
        
        // Display from first item at top, second item bottom
        //        listItems.append(itemInfo)
        
        // Display recently created item at top, older item bottom
        listItems.insert(itemInfo, atIndex: 0)
        
        println(listItems.count)
        println(listItems)
        
        tableView.reloadData()
        itemNameField.text = ""
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createColor.backgroundColor = UIColor(red:0.35, green:0.84, blue:0.64, alpha:1)
        createColor.layer.cornerRadius = 6
        tableView.backgroundColor = UIColor(red:0.16, green:0.17, blue:0.2, alpha:1)
        tableView.separatorColor = UIColor(red:0.16, green:0.17, blue:0.2, alpha:1)
        tableView.tableFooterView = UIView(frame:CGRectZero)

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    /*
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 0
    }
    */

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return listItems.count
    }

  
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("listCell", forIndexPath: indexPath) as! ListTableViewCell

        // Configure the cell...
        //cell.itemLabel.text = listItems[indexPath.row]["name"] as? String
                                                     //AnyObject so declaring the value of the object
        cell.itemInfo = listItems[indexPath.row]
        
        return cell
    }
  

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

   
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            
            listItems.removeAtIndex(0)
            
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            
        } else if editingStyle == .Insert {
    
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
