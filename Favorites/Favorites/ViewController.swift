//
//  ViewController.swift
//  Favorites
//
//  Created by jpk on 5/28/15.
//  Copyright (c) 2015 Parker Kirby. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var myFavorites: [PFObject] = []

    @IBOutlet weak var favoriteTextField: UITextField!
    @IBOutlet weak var favoriteTableView: UITableView!
    
    @IBAction func addFavorite(sender: AnyObject) {
        
        let newFavorite = PFObject(className: "Favorites")
        
        newFavorite["name"] = favoriteTextField.text
        newFavorite["user"] = PFUser.currentUser()
        
        newFavorite.saveInBackground()
        favoriteTextField.text = ""
//        myFavorites.insert(newFavorite, atIndex: 0)
        myFavorites.append(newFavorite)
        favoriteTableView.reloadData()
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        
        let query = PFQuery(className: "Favorites")
        
        query.orderByDescending("createdAt")
        
        query.whereKeyExists("user")

        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
         
            self.myFavorites = objects as! [PFObject]
            self.favoriteTableView.reloadData()
        
        }
        
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return myFavorites.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("favoriteCell", forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel?.text = myFavorites[indexPath.row]["name"] as? String
        
        return cell
    }

}

