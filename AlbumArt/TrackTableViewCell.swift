//
//  TrackTableViewCell.swift
//  AlbumArt
//
//  Created by jpk on 5/29/15.
//  Copyright (c) 2015 Parker Kirby. All rights reserved.
//

import UIKit

//need to allow the child to talk to the parent, so making 
protocol TrackTableViewCellDelegate {
    
    func playSongWithURL(url: String)
    
}

class TrackTableViewCell: UITableViewCell {
    
    @IBOutlet weak var trackNameLabel: UILabel!
    
    var delegate: TrackTableViewCellDelegate?
    
    var trackInfo: [String:AnyObject]! {
        
        didSet {
            trackNameLabel.text = trackInfo["trackName"] as? String
            
        }
    }
    
    
    @IBAction func toggleSong(sender: UIButton) {
        
        if let url = trackInfo["previewUrl"] as? String {
        
            delegate?.playSongWithURL(url)
        
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
