//
//  ViewController.swift
//  Review
//
//  Created by jpk on 6/16/15.
//  Copyright (c) 2015 Parker Kirby. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //if user == nil
        
        let loginStoryboard = UIStoryboard(name: "Login", bundle: nil)
        let loginVC = loginStoryboard.instantiateInitialViewController() as! UIViewController
        
        presentViewController(loginVC, animated: true, completion: nil)
    
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

