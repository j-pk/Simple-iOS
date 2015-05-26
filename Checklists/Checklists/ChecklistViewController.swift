//
//  ViewController.swift
//  Checklists
//
//  Created by jpk on 5/25/15.
//  Copyright (c) 2015 Parker Kirby. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            
            if cell.accessoryType == .None {
                cell.accessoryType = .Checkmark
            } else {
                cell.accessoryType = .None
            }
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 100
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ChecklistItem") as! UITableViewCell
        
        let label = cell.viewWithTag(1000) as! UILabel
        
        if indexPath.row % 5 == 0 {
            label.text = "Walk the dog"
        }
        if indexPath.row % 5 == 1 {
            label.text = "Fold clothes"
        }
        if indexPath.row % 5 == 2 {
            label.text = "Drink beer"
        }
        if indexPath.row % 5 == 3 {
            label.text = "Text Bailey"
        }
        if indexPath.row % 5 == 4 {
            label.text = "Roll burrito"
        }
        
        return cell
        
    }

}

