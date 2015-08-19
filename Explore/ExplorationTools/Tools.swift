//
//  Tools.swift
//  Explore
//
//  Created by jpk on 7/8/15.
//  Copyright (c) 2015 Parker Kirby. All rights reserved.
//

import UIKit

private let _allTools = Tools()

public class Tools: NSObject {
    
    //important to know when building frameworks
    //make items of the framework public in order to be used
    
    public class func allTools() -> Tools { return _allTools }
    
    
}
