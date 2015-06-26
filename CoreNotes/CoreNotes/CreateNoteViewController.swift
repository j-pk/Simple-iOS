
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

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
    
    @IBAction func redButtonPressed(sender: UIButton) {
        
        var priorityChoice = "Red"
        
    }
    
    
    @IBAction func createNote(sender: AnyObject) {
        
        if let moc = appDelegate.managedObjectContext {
        //this is going to be object that we store in our database
            
            
            var catEntity = NSEntityDescription.entityForName("Category", inManagedObjectContext: moc)
            
            let request = NSFetchRequest()
            
            request.entity = catEntity
            
            if let catObjects = moc.executeFetchRequest(request, error: nil) as? [NSManagedObject] {
                
                var newObject = NSEntityDescription.insertNewObjectForEntityForName("Note", inManagedObjectContext: moc) as! NSManagedObject

                newObject.setValue(noteTextField.text, forKey: "content")
                newObject.setValue(NSDate(), forKey: "created")
                
                let catObject = catObjects[0]
                
                newObject.setValue(catObjects, forKey: "category")
                
            }

            
            // add five button and set category relationship
            
            appDelegate.saveContext()
            
            dismissViewControllerAnimated(true, completion: nil)
            
        }
        
        
    }


}
