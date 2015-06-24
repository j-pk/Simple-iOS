//
//  CreateNoteViewController.swift
//  CoreNotes
//
//  Created by jpk on 6/23/15.
//  Copyright (c) 2015 Parker Kirby. All rights reserved.
//

import UIKit
import CoreData
//3
//add a category relationship for the new note

//Hard Mode
//add a textfield and button that takes the value of the text
//add tags comma seperated for the new note

enum Priority {
    
    case Completed
    case Pending
    case Casual
    case Low
    case Urgent
    
}

var appDelegate: AppDelegate = {
   
    return UIApplication.sharedApplication().delegate as! AppDelegate

}()


class CreateNoteViewController: UIViewController {

    @IBOutlet weak var noteTextField: UITextField!
    
    var priorityChoice = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }
    
    @IBAction func redButtonPressed(sender: UIButton) {
        
        var priorityChoice = "Red"
        
    }
    
    
    @IBAction func createNote(sender: AnyObject) {
        
        if let moc = appDelegate.managedObjectContext {
        //this is going to be object that we store in our database
            var newObject = NSEntityDescription.insertNewObjectForEntityForName("Note", inManagedObjectContext: moc) as! NSManagedObject
            var colorObject = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: moc) as! NSManagedObject
           
            var relatedObject = NSManagedObject()
            
            newObject.setValue(noteTextField.text, forKey: "content")
            newObject.setValue(NSDate(), forKey: "created")
            
            colorObject.setValue(priorityChoice, forKey: "color")
            
            // add five button and set category relationship
            
            appDelegate.saveContext()
            
            dismissViewControllerAnimated(true, completion: nil)
            
        }
        
        
    }


}
