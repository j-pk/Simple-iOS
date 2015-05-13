//
//  ProfileTableViewCell.swift
//  GitHubFriends
//
//  Created by jpk on 5/12/15.
//  Copyright (c) 2015 Parker Kirby. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var repoButtonText: UIButton!
    @IBOutlet weak var gistButtonText: UIButton!
    
    var friendIndex: Int!
    var friendInfo: [String:AnyObject?]! {
    
        didSet {
            
            repoButtonText.tag = friendIndex
            gistButtonText.tag = friendIndex

            profileImage.layer.cornerRadius = 8.0
            profileImage.layer.masksToBounds = true
            repoButtonText.layer.cornerRadius = 8.0
            repoButtonText.backgroundColor = UIColor.clearColor()
            repoButtonText.layer.borderWidth = 0.5
            repoButtonText.layer.borderColor = UIColor.blackColor().CGColor
            gistButtonText.layer.cornerRadius = 8.0
            gistButtonText.backgroundColor = UIColor.clearColor()
            gistButtonText.layer.borderWidth = 0.5
            gistButtonText.layer.borderColor = UIColor.blackColor().CGColor

            profileLabel.text = friendInfo["name"] as? String
            
            let avatarURL = NSURL(string: (friendInfo["avatar_url"] as? String)!)
            let imageData = NSData(contentsOfURL: avatarURL!)
            let profileUIImage = UIImage(data: imageData!)
           
            profileImage.image = profileUIImage
            
            // Public Repos
            var publicRepos = (friendInfo["public_repos"] as! Int)
            
            println(publicRepos)
            
            repoButtonText.setTitle("Repos \(publicRepos)", forState: UIControlState.Normal)

            // Public Gists
            var publicGists = (friendInfo["public_gists"] as! Int)
            
            println(publicGists)
            
            gistButtonText.setTitle("Gists \(publicGists)", forState: UIControlState.Normal)
            
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

}
