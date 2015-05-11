//
//  ListTableViewCell.swift
//  HighPriority
//
//  Created by jpk on 5/11/15.
//  Copyright (c) 2015 Parker Kirby. All rights reserved.
//

import UIKit

let priorityColors = [
    UIColor(red:1, green:0.16, blue:0.24, alpha:1),
    UIColor(red:1, green:0.68, blue:0.44, alpha:1),
    UIColor(red:1, green:0.68, blue:0.44, alpha:1),

]

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var itemStrikeThrough: UIView!
    
    var itemInfo: [String:AnyObject]! {
        
        //property observer - it will run every time we set itemInfo
        didSet {
            
            itemLabel.text = itemInfo["name"] as? String
            itemStrikeThrough.hidden = !(itemInfo["completed"] as! Bool)
            //reverses the value of the bool !() not true, not false
            
            backgroundColor = priorityColors[itemInfo["priority"] as! Int]
        
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        itemInfo["completed"] = !(itemInfo["completed"] as! Bool)
        
        if itemInfo["completed"] as! Bool {
            
            itemStrikeThrough.hidden = false
            backgroundColor = UIColor.lightGrayColor()
        } else {
            itemStrikeThrough.hidden = true
            backgroundColor = priorityColors[itemInfo["priority"] as! Int]
        }
        
    }

}
