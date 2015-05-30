//
//  ViewController.swift
//  AlbumArt
//
//  Created by jpk on 5/29/15.
//  Copyright (c) 2015 Parker Kirby. All rights reserved.
//

import UIKit
import AFNetworking
import AVFoundation

class AlbumDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TrackTableViewCellDelegate {
    
    @IBOutlet weak var albumName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    
    @IBOutlet weak var tracksTableView: UITableView!
    
    var player: AVAudioPlayer?
    
    var albumInfo: [String:AnyObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println(albumInfo)
        
        tracksTableView.dataSource = self
        tracksTableView.delegate = self
        
        albumName.text = albumInfo["collectionName"] as? String
        artistName.text = albumInfo["artistName"] as? String
        
        if let albumID = albumInfo["collectionId"] as? Int {
            
            var requestManager = AFHTTPRequestOperationManager()
            requestManager.GET(itunesLookUpAPI + "?entity=song&id=\(albumID)", parameters: nil, success: { (request, data) -> Void in
                
                let info = data as! [String:AnyObject]
                
                self.tracks = info["results"] as! [[String:AnyObject]]
                self.tracks.removeAtIndex(0)
                
                self.tracksTableView.reloadData()
                
                
                }) { (request, error) -> Void in
                    
                    println(error)
                    
            }
            
        }
        
    }
    
    var tracks: [[String:AnyObject]] = []
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tracks.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("trackCell", forIndexPath: indexPath) as! TrackTableViewCell
        
        cell.trackInfo = tracks[indexPath.row]
        cell.delegate = self
        
        return cell
        
    }
    
    func playSongWithURL(url: String) {
        
        player?.stop()
        
        if let url = NSURL(string: url) {
            
            if let trackData = NSData(contentsOfURL: url) {
                
                player = AVAudioPlayer(data:trackData, error: nil)
                
                player?.play()
                
            }
        }
        
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        
        player?.stop()
        
    }
    
}

