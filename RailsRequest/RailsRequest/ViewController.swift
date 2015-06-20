//
//  ViewController.swift
//  RailsRequest
//
//  Created by jpk on 6/18/15.
//  Copyright (c) 2015 Parker Kirby. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        var token: String? 
        
    RailsRequest.session().registerwithCompletion { () -> Void in
        
        RailsRequest.session().username = "test2"
        RailsRequest.session().email = "test@test.com"
        RailsRequest.session().password = "1111"

        println(RailsRequest.session().token)
        
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

