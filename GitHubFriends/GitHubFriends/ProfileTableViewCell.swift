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

    var friendInfo: [String:AnyObject?]! {
    
        didSet {

            profileImage.layer.cornerRadius = 10.0
            profileImage.layer.masksToBounds = true

            profileLabel.text = friendInfo["name"] as? String
            
            let avatarURL = NSURL(string: (friendInfo["avatar_url"] as? String)!)
            let imageData = NSData(contentsOfURL: avatarURL!)
            let profileUIImage = UIImage(data: imageData!)
           
            profileImage.image = profileUIImage
            
            // Public Repos
            var publicRepos = (friendInfo["public_repos"]! as! Int)
            
            println(publicRepos)
            
            repoButtonText.setTitle("\(publicRepos)", forState: UIControlState.Normal)

            // Public Gists
            var publicGists = (friendInfo["public_gists"]! as! Int)
            
            println(publicGists)
            
            gistButtonText.setTitle("\(publicGists)", forState: UIControlState.Normal)
            
//            repoFullName.text = friendInfo["]
//            
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
