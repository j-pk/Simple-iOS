//
//  ViewController.swift
//  Images
//
//  Created by jpk on 5/27/15.
//  Copyright (c) 2015 Parker Kirby. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate, UISearchDisplayDelegate /*UICollectionViewDataSource, UICollectionViewDelegate*/ {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var albumImageVIew: UIImageView!
    
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var albumName: UILabel!
    @IBOutlet weak var trackCount: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    
    
    var data: NSMutableData = NSMutableData()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        searchBar.delegate = self
    
    }
    
    func searchItunesFor() {
        
        var itunesSearchTerm = searchBar.text
        
        var urlPath = "https://itunes.apple.com/search?term=\(itunesSearchTerm)&entity=album"
        var url: NSURL = NSURL(string: urlPath)!
        var request: NSURLRequest = NSURLRequest(URL: url)
        var connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: false)!
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { (response, data, error) -> Void in
            
            //data is the information that is returned
            
            if let returnedInfo = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: nil) as? [String:AnyObject] {
                
                println(returnedInfo)
                println(returnedInfo["results"])
                
                if let responseInfo = returnedInfo["results"] as? [[String:AnyObject]] {
                    
                    println(responseInfo[0])
                    
                    let artistNameFirst = responseInfo[0]["artistName"] as? String
                    self.artistName.text = artistNameFirst
                    let albumNameFirst = responseInfo[0]["collectionName"] as? String
                    self.albumName.text = albumNameFirst
                    var trackCountFirst = responseInfo[0]["trackCount"] as! Int
                    self.trackCount.text = "\(trackCountFirst)"
                    let releaseDateFirst = responseInfo[0]["releaseDate"] as? String
                    self.releaseDate.text = releaseDateFirst
                    
                    if let albumUrl = responseInfo[0]["artworkUrl100"] as? String {
//                        println(albumInfo)
                        println("\(albumUrl)")
                        
                        let albumNSURL = NSURL(string: albumUrl)
                        let imageData = NSData(contentsOfURL: albumNSURL!)
                        let albumUIImage = UIImage(data: imageData!)
                        
                        self.albumImageVIew.image =
                        albumUIImage
                       
                    }
                    
                }
                
            }
            
        })

        
        println("Search iTunes API at URL \(url)")
        
        connection.start()
        
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        searchItunesFor()
        
    }
   

}
    




