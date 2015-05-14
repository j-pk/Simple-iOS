//
//  FriendsTableViewController.swift
//  GitHubFriends
//
//  Created by jpk on 5/12/15.
//  Copyright (c) 2015 Parker Kirby. All rights reserved.
//

import UIKit

class FriendsTableViewController: UITableViewController {
    
    @IBOutlet weak var addFriend: UIButton!
    @IBOutlet weak var friendNameField: UITextField!
 
    var friends: [[String:AnyObject?]] = [
        [
                "login": "j-pk",
                "id": 12202276,
                "avatar_url": "https://avatars.githubusercontent.com/u/12202276?v=3",
                "gravatar_id": "",
                "url": "https://api.github.com/users/j-pk",
                "html_url": "https://github.com/j-pk",
                "followers_url": "https://api.github.com/users/j-pk/followers",
                "following_url": "https://api.github.com/users/j-pk/following{/other_user}",
                "gists_url": "https://api.github.com/users/j-pk/gists{/gist_id}",
                "starred_url": "https://api.github.com/users/j-pk/starred{/owner}{/repo}",
                "subscriptions_url": "https://api.github.com/users/j-pk/subscriptions",
                "organizations_url": "https://api.github.com/users/j-pk/orgs",
                "repos_url": "https://api.github.com/users/j-pk/repos",
                "events_url": "https://api.github.com/users/j-pk/events{/privacy}",
                "received_events_url": "https://api.github.com/users/j-pk/received_events",
                "type": "User",
                "site_admin": false,
                "name": "Parker Kirby",
                "company": "",
                "blog": "",
                "location": "",
                "email": "",
                "hireable": false,
                "bio": nil,
                "public_repos": 1,
                "public_gists": 0,
                "followers": 8,
                "following": 9,
                "created_at": "2015-05-01T18:32:22Z",
                "updated_at": "2015-05-09T15:33:25Z"
            
        ]
    ]
    
//    var repo: [[String:AnyObject?]] [{
//    
//                "id": 35050945,
//                "name": "Simple-iOS",
//                "full_name": "j-pk/Simple-iOS",
//                "owner": {
//                "login": "j-pk",
//                "id": 12202276,
//                "avatar_url": "https://avatars.githubusercontent.com/u/12202276?v=3",
//                "gravatar_id": "",
//                "url": "https://api.github.com/users/j-pk",
//                "html_url": "https://github.com/j-pk",
//                "followers_url": "https://api.github.com/users/j-pk/followers",
//                "following_url": "https://api.github.com/users/j-pk/following{/other_user}",
//                "gists_url": "https://api.github.com/users/j-pk/gists{/gist_id}",
//                "starred_url": "https://api.github.com/users/j-pk/starred{/owner}{/repo}",
//                "subscriptions_url": "https://api.github.com/users/j-pk/subscriptions",
//                "organizations_url": "https://api.github.com/users/j-pk/orgs",
//                "repos_url": "https://api.github.com/users/j-pk/repos",
//                "events_url": "https://api.github.com/users/j-pk/events{/privacy}",
//                "received_events_url": "https://api.github.com/users/j-pk/received_events",
//                "type": "User",
//                "site_admin": false
//    
//    }]
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationController!.navigationBar.barTintColor = UIColor(red:0.07, green:0.83, blue:0.73, alpha:1)
//        navigationController!.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Helvetica Neue", size: 20)!,  NSForegroundColorAttributeName: UIColor.whiteColor()]
        
    }
    @IBAction func gistButton(sender: AnyObject) {
        
        
    }

    @IBAction func repoButton(sender: AnyObject) {
//        
//        let repopoint = "https://api.github.com/users/\(friendNameField.text)/repos/client_id=18c2e67eaf44f4a60b76&client_secret=5528dd41089fd0a5de62e7927b849075b65463a0/"
//        if let url = NSURL(string: repopoint) {
//            
//            let request = NSURLRequest(URL: url)
//            
//            if let data = NSURLConnection.sendSynchronousRequest(request,returningResponse: nil, error: nil){
//                
//                if let repoInfo = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as? [String:AnyObject] {
//                    
//                    println(repoInfo)
//                    
//     
    }
    
    @IBAction func addFriend(sender: AnyObject) {
        
        let endpoint = "https://api.github.com/users/\(friendNameField.text)"
        
        //unwrapping NSURL? - allows to safely unwrap an optional
        println(endpoint)
        
        if let friendInfo = GithubRequest.getInfoWithEndpoint(endpoint) as? [String:AnyObject] {
            
            println(friendInfo)
            
            friends.insert(friendInfo, atIndex: 0)
            
            tableView.reloadData()
            
        }
        
        friendNameField.text = ""
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Potentially incomplete method implementation.
//        // Return the number of sections.
//        return 0
//    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        //array we worked with
        return friends.count
    }
    

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("friendCell", forIndexPath: indexPath) as! ProfileTableViewCell
        
        
        // Configure the cell...
        cell.friendIndex = indexPath.row
        cell.friendInfo = friends[indexPath.row]
        
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
             // Delete the row from the data source
            friends.removeAtIndex(indexPath.row)
            
           
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "reposSegue" {
        
        var reposTVC = segue.destinationViewController as! ReposTableViewController
        
        var reposButton = sender as! UIButton
        
        reposTVC.friendInfo = friends[reposButton.tag]
            
        }
        
    }
}
