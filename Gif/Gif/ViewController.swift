//
//  ViewController.swift
//  Gif
//
//  Created by jpk on 7/9/15.
//  Copyright (c) 2015 Parker Kirby. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        var baseURL = NSURL(string: "http://imgur.com/vTifdh5.gif")
        var URL = NSData(contentsOfURL: baseURL!)
        
        var image = UIImage.animatedGIF(URL!)
        
        var images = [image]
        
        imageView.image = images[0]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

