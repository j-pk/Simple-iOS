//
//  ViewController.swift
//  MyWorld
//
//  Created by jpk on 5/21/15.
//  Copyright (c) 2015 Parker Kirby. All rights reserved.
//

import UIKit
import MapKit

class myAnnotation : MKPointAnnotation {
    
    var venueIndex: Int!
    
}

//whenever working with a delegate we need to set the delegate
class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var myMapView: MKMapView!
    
    var lManager = CLLocationManager()
    var allVenues: [[String:AnyObject]] = []
    
    var venuesAddress: String?
    
    let API_URL = "https://api.foursquare.com/v2/"
    let CLIENT_ID = "MZB35JAM3XG14YZXYTSDNP2F1N131MZA1LFMIRD1T23JQPL4"
    let CLIENT_SECRET = "XHRTWYZZWXVIJHVXFO0H5DVSKWODQP3DUEVA5LOQEGVWSVXW"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        lManager.requestWhenInUseAuthorization()
        lManager.delegate = self
        
        myMapView.showsUserLocation = true
        myMapView.userTrackingMode = .Follow
        myMapView.delegate = self
        
        lManager.startUpdatingLocation()
        
        navigationController?.navigationBar.barTintColor = UIColor(red:1, green:0.76, blue:0.28, alpha:1)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        if let location = locations.first as? CLLocation {
            
            println("latitude \(location.coordinate.latitude) longitude \(location.coordinate.latitude)")
            
            requestVenuesWithLocation(location, completion: { (venues) -> () in
                
                println (venues)
                self.allVenues = venues as! [[String:AnyObject]]
                
                for (index, venue) in enumerate(venues as! [[String:AnyObject]]) {
                    
                    if let locationInfo = venue["location"] as? [String:AnyObject] {
                        
                        if let lat = locationInfo["lat"] as? Double, let lng = locationInfo["lng"] as? Double {
                            
                            let coordinate = CLLocationCoordinate2DMake(lat, lng)
                            
                            let annotation = myAnnotation()
                            
                            annotation.title = venue["name"] as? String
                            annotation.venueIndex = index
                            annotation.coordinate = coordinate
                            
                            self.myMapView.addAnnotation(annotation)
                            
                            
                        }
                        
                    }
                    
                }
                
            })
            
            //stops returning request from FourSquare
            lManager.stopUpdatingLocation()
            
        }
        
    }
    
    func requestVenuesWithLocation(location: CLLocation, completion: (venues: [AnyObject]) -> ()) {

        //specific endpoint to find around user location
        let endpoint = API_URL + "venues/search?client_id=\(CLIENT_ID)&client_secret=\(CLIENT_SECRET)&ll=\(location.coordinate.latitude),\(location.coordinate.longitude)&v=20150101"
        
        if let url = NSURL(string: endpoint) {
            
            let request = NSURLRequest(URL: url)
            
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { (response, data, error) -> Void in
                
                //data is the information that is returned
                
                println(data)
                
                if let returnedInfo = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: nil) as? [String:AnyObject] {
                    
                    println(returnedInfo)
                    
                    if let responseInfo = returnedInfo["response"] as? [String:AnyObject] {
                        
                        if let venuesInfo = responseInfo["venues"] as? [AnyObject] {
                            
                            completion(venues: venuesInfo)
                            
                        }
                        
                    }
                    
                }
                
            })
            
            
        }
        
    }
    

    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        
        if annotation is MKUserLocation { return nil }
        
        var annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "annotation")
        
        //customizing the pin color and allowing the title bubble to show
        annotationView.pinColor = MKPinAnnotationColor.Green
        annotationView.canShowCallout = true
        
        //allows the I button to be display when a pin is pressed
        var button = UIButton.buttonWithType(UIButtonType.DetailDisclosure) as! UIButton
        annotationView.rightCalloutAccessoryView = button
        
        button.tag = (annotation as! myAnnotation).venueIndex
        
        //target the showMoreInfo func self has showMoreInfo, action is init the showMoreInfo func
        //action if leveraging a button with a sender it must have a : if you have a parameter
        button.addTarget(self, action: "showMoreInfo:", forControlEvents: UIControlEvents.TouchUpInside)
        
        return annotationView
        
    }
    
    func showMoreInfo(sender: UIButton) {
        
        var detailVC = UIViewController()
        
        var venue = allVenues[sender.tag]
        
        println(detailVC)
        
        detailVC.view.backgroundColor = UIColor.whiteColor()
        
        detailVC.navigationItem.title = venue["name"] as? String
        
        if let category = venue["categories"] as? [[String:AnyObject]] {
            
            let insideCategoryArray = category[0]
            let venueCat = insideCategoryArray["name"] as! String
//            let prefix = 
            
            //little circle on the left
            var firstCircle = UIView(frame: CGRectMake(30, 100, 40, 40))
            firstCircle.layer.cornerRadius = firstCircle.frame.size.width / 2
            firstCircle.backgroundColor = UIColor(red:1, green:0.76, blue:0.28, alpha:1)
            
//            let circleURL = NSURL(string: (insideCategoryArray["prefix" + "32" + ".png"] as? String)!)
//            let imageData = NSData(contentsOfURL: circleURL!)
//            let circleUIImage = UIImage(data: imageData!)
            
//            println(imageData)
            
            //Divider
            var boxDivider = UIView(frame: CGRectMake(90, 100, 5, 40))
            boxDivider.backgroundColor = UIColor(red:0.69, green:0.69, blue:0.69, alpha:1)
            
            
            //Venue Category Name
            var boxCat = UILabel(frame: CGRectMake(110, 90, 400, 40))
            var boxCatName = UILabel(frame: CGRectMake(110, 110, 400, 40))
            
            boxCat.text = "Category"
            boxCatName.text = venueCat
            boxCatName.font = UIFont(name: "HelveticaNeue-Light", size: 22)
            boxCat.font = UIFont(name: "HelveticaNeue-Light", size: 14)
            
            detailVC.view.addSubview(boxCat)
            detailVC.view.addSubview(boxCatName)
            detailVC.view.addSubview(boxDivider)
            detailVC.view.addSubview(firstCircle)
//            detailVC.view.addSubview(circleUIImage)
            
        }
        
        if let location = venue["location"] as? [String:AnyObject] {
            
            var address = location["address"] as? String
            var city = location["city"] as? String
            var state = location["state"] as? String
            
            //Address Name 
            var boxAddress = UITextField(frame: CGRectMake(110, 180, 300, 300))
            var boxAddressDivider = UIView(frame: CGRectMake(90, 180, 5, 180))
            boxAddressDivider.backgroundColor = UIColor(red:0.69, green:0.69, blue:0.69, alpha:1)
            
            detailVC.view.addSubview(boxAddressDivider)
            detailVC.view.addSubview(boxAddress)

            boxAddress.text = address
            
        }
        

        navigationController?.pushViewController(detailVC, animated: true)

    }
    
}

