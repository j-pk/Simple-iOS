//
//  AlbumCollectionViewController.swift
//  AlbumArt
//
//  Created by jpk on 5/29/15.
//  Copyright (c) 2015 Parker Kirby. All rights reserved.
//

import UIKit
import AFNetworking

let reuseIdentifier = "albumCell"

let itunesSearchAPI = "https://itunes.apple.com/search"
let itunesLookUpAPI = "https://itunes.apple.com/lookup"


class AlbumCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
        
    var albums: [[String:AnyObject]] = []
    
//    @IBOutlet weak var searchForArtistTextField: UISearchBar!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        //        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
//        searchForArtistTextField.delegate = self
        
        var artistSearch = "weezer" /*searchForArtistTextField.text AlbumCollectionViewCell.searchForArtist*/
        
        var requestManager = AFHTTPRequestOperationManager()
        requestManager.GET(itunesSearchAPI + "?term=\(artistSearch)&entity=album", parameters: nil, success: { (request, data) -> Void in
            
            let info = data as! [String:AnyObject]
            
            self.albums = info["results"] as! [[String:AnyObject]]
            
            self.collectionView?.reloadData()
            
            }) { (request, error) -> Void in
                
                println(error)
                
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        
        return albums.count
        
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! AlbumCollectionViewCell
        
        if let artworkURL = albums[indexPath.item]["artworkUrl100"] as? String {
            
            if let url = NSURL(string: artworkURL) {
                
                //it can run on any run thread, background thread
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), { () -> Void in
                    
                    if let imageData = NSData(contentsOfURL: url) {
                        
                        //go back to the main thread
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            
                            let image = UIImage(data: imageData)
                            
                            cell.albumImageView.image = image
                            
                            
                        })
                        
                    }
                    
                })
                
                
            }
            
        }
        
        println(albums[indexPath.item])
        
        // Configure the cell
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "sectionHeader", forIndexPath: indexPath) as! UICollectionReusableView
        
        return header
        
    }
    
    //pushing the data from the AlbumCollection to AlbumDetail
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let cell = sender as! AlbumCollectionViewCell
        if let indexPath = collectionView?.indexPathForCell(cell) {
        
            let albumInfo = albums[indexPath.item]
            
            let detailVC = segue.destinationViewController as! AlbumDetailViewController
            
            detailVC.albumInfo = albumInfo
            
        }
        
    }
    
}
