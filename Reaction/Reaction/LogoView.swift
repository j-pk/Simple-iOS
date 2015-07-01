//
//  LogoView.swift
//  Reaction
//
//  Created by jpk on 7/1/15.
//  Copyright (c) 2015 Parker Kirby. All rights reserved.
//

import UIKit

class LogoView: UIView {
    
    override func drawRect(rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        
        UIColor.whiteColor().colorWithAlphaComponent(0.5).set()
        
        let cW = rect.width - (rect.width / 9)
        
        //let tlRect = CGRect(x: 0, y: 0, width: cW, height: cW)
        //let trRect = CGRect(x: rect.width - cW, y: 0, width: cW, height: cW)
        //let blRect = CGRect(x: 0, y: rect.height - cW, width: cW, height: cw)
        //let brRect = CGRect(x: rect.width - cW, y: rect.height - cW, width: cw, height: cw)
        
        
    }
    
    
}