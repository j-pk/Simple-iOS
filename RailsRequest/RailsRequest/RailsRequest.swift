//
//  RailsRequest.swift
//  RailsRequest
//
//  Created by jpk on 6/18/15.
//  Copyright (c) 2015 Parker Kirby. All rights reserved.
//

import UIKit

private let defaults = NSUserDefaults.standardUserDefaults()
private let _singleton = RailsRequest()

let API_URL = "http://tiyqpic.herokuapp.com"

class RailsRequest: NSObject {
   
    //when accessed this will be railsrequest.session - singleton class
    class func session() -> RailsRequest { return _singleton }
    
    //add id property
    
    var token: String? {
        
        get {
            //return the value of the token when this is called
            return defaults.objectForKey("TOKEN") as? String
            
        }
        
        set {
            
            //sets a new token value
            defaults.setValue(newValue, forKey: "TOKEN")
            //gets saved into NSDefaults
            defaults.synchronize()
            
        }
        
    }
    
    var username: String?
    var email: String?
    var password: String?
    
    func registerwithCompletion(completion: () -> Void) {
        
        var info = [
        
            "method" : "POST",
            "endpoint" : "/users/register",
            "parameters" : [
            
                "userName" : username!,
                "email" : email!,
                "password" : password!
            
            ]
        
        ] as [String:AnyObject]
        
        requestWithInfo(info, andCompletion: { (responseInfo) -> Void in
            
            if let accessToken = responseInfo?["access_token"] as? String {
                
                self.token = accessToken
                
                //
                completion()
                
            }
            
        })
        
    }
    
    func login() {
        
        
    }
    
    func postImage() {
        
        
        
    }
    
    //we make the completion optional nil if it doesn't complete
    func requestWithInfo(info: [String:AnyObject], andCompletion completion: ((responseInfo: [String:AnyObject]?) -> Void)?) {
        
        let endpoint = info["endpoint"] as! String
        
        if let url = NSURL(string: API_URL + endpoint) {
            
            let request = NSMutableURLRequest(URL: url)
            
            //NSMutableURLRequest is needed to with HTTPMethod
            request.HTTPMethod = info["method"] as! String
            
            if let token = token {
            
                request.setValue(token, forHTTPHeaderField: "Authorization")
                
            }
            
            //////// BODY (only run this code if HTTPMethod != "GET"
            
            let bodyInfo = info["parameters"] as! [String:AnyObject]
            
            let requestData = NSJSONSerialization.dataWithJSONObject(bodyInfo, options: NSJSONWritingOptions.allZeros, error: nil)
            
            let jsonString = NSString(data: requestData!, encoding: NSUTF8StringEncoding)
            
            let postLength = "\(jsonString!.length)"
            
            request.setValue(postLength, forHTTPHeaderField: "Content-Length")
            
            let postData = jsonString?.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: true)
            
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            request.HTTPBody = postData
            
            //////// BODY
            

            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { (response, data, error) -> Void in
                
                //dictionary that comes back
                if let json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: nil) as? [String:AnyObject] {
                    
                    //safe optional in case no data comes back
                    //responseInfo completion block is a function being run above
                    completion?(responseInfo: json)
                    
                }
                
            })
            
        }
        
        
    }
    
    
}
