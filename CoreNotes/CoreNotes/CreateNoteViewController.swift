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

var appDelegate: AppDelegate = {
   
    return UIApplication.sharedApplication().delegate as! AppDelegate

}()


class CreateNoteViewController: UIViewController {

    @IBOutlet weak var noteTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }
    
    @IBAction func createNote(sender: AnyObject) {
        
        if let moc = appDelegate.managedObjectContext {
        //this is going to be object that we store in our database
            var newObject = NSEntityDescription.insertNewObjectForEntityForName("Note", inManagedObjectContext: moc) as! NSManagedObject
        
            newObject.setValue(noteTextField.text, forKey: "content")
            newObject.setValue(NSDate(), forKey: "created")
            
            // add five button and set category relationship
            
            appDelegate.saveContext()
            
            dismissViewControllerAnimated(true, completion: nil)
            
        }
        
        
    }


}
