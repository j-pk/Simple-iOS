//
//  ViewController.swift
//  MyWorld
//
//  Created by jpk on 5/21/15.
//  Copyright (c) 2015 Parker Kirby. All rights reserved.
//

import UIKit
import MapKit
import Fabric
import Crashlytics

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
        
        Crashlytics.sharedInstance().crash()
        
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        if let location = locations.first as? CLLocation {
            
            println("latitude \(location.coordinate.latitude) longitude \(location.coordinate.latitude)")
            
            requestVenuesWithLocation(location, completion: { (venues) -> () in
                
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
            
                if let returnedInfo = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: nil) as? [String:AnyObject] {
                    
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
        
        detailVC.view.backgroundColor = UIColor.whiteColor()
        
        detailVC.navigationItem.title = venue["name"] as? String
        
        if let category = venue["categories"] as? [[String:AnyObject]] {
            
            let insideCategoryArray = category[0]
            let venueCat = insideCategoryArray["name"] as! String
            
            var icon = insideCategoryArray["icon"] as? String
            println(icon)
            
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
            
            boxCat.text = "CATEGORY"
            boxCatName.text = venueCat
            boxCatName.textColor = UIColor(red:0.69, green:0.69, blue:0.69, alpha:1)
            boxCat.textColor = UIColor(red:0.69, green:0.69, blue:0.69, alpha:1)
            boxCatName.font = UIFont(name: "HelveticaNeue-Light", size: 22)
            boxCat.font = UIFont(name: "HelveticaNeue-Light", size: 12)
            
            detailVC.view.addSubview(boxCat)
            detailVC.view.addSubview(boxCatName)
            detailVC.view.addSubview(boxDivider)
            detailVC.view.addSubview(firstCircle)
//            detailVC.view.addSubview(circleUIImage)
            
        }
        
        if let location = venue["location"] as? [String:AnyObject] {
            
            println(location)
            
            var addressLabel = UILabel(frame: CGRectMake(110, 175, 100, 20))
            addressLabel.textColor = UIColor(red:0.69, green:0.69, blue:0.69, alpha:1)
            addressLabel.text = "ADDRESS"
            addressLabel.font = UIFont(name: "HelveticaNeue-Light", size: 12)

            var address = location["address"] as? String
            var city = location["city"] as? String
            var state = location["state"] as? String
            
            //Address Name 
            var boxAddress = UILabel(frame: CGRectMake(110, 170, 200, 80))
            boxAddress.font = UIFont(name: "HelveticaNeue-Light", size: 22)
            boxAddress.textColor = UIColor(red:0.69, green:0.69, blue:0.69, alpha:1)
            var boxCity = UILabel(frame: CGRectMake(110, 190, 200, 80))
            boxCity.font = UIFont(name: "HelveticaNeue-Light", size: 22)
            boxCity.textColor = UIColor(red:0.69, green:0.69, blue:0.69, alpha:1)
            var boxState = UILabel(frame: CGRectMake(110, 210, 200, 80))
            boxState.font = UIFont(name: "HelveticaNeue-Light", size: 22)
            boxState.textColor = UIColor(red:0.69, green:0.69, blue:0.69, alpha:1)
            
            var boxAddressDivider = UIView(frame: CGRectMake(90, 180, 5, 213))
            boxAddressDivider.backgroundColor = UIColor(red:0.69, green:0.69, blue:0.69, alpha:1)
            
            
            detailVC.view.addSubview(boxAddressDivider)
            detailVC.view.addSubview(boxAddress)
            detailVC.view.addSubview(boxCity)
            detailVC.view.addSubview(boxState)
            detailVC.view.addSubview(addressLabel)
            
            
            boxAddress.numberOfLines = 0
            boxAddress.lineBreakMode = .ByWordWrapping
            boxAddress.text = address
            boxCity.text = city
            boxState.text = state
            
        }
        
        
        if let stats = venue["stats"] as? [String:AnyObject] {
            
            println(stats)
            
            var checkinsCount = stats["checkinsCount"] as! Int
            var usersCount = stats["usersCount"] as! Int
            var tipCount = stats["tipCount"] as! Int
            
            var statsLabel = UILabel(frame: CGRectMake(110, 275, 100, 20))
            statsLabel.textColor = UIColor(red:0.69, green:0.69, blue:0.69, alpha:1)
            statsLabel.text = "STATS"
            statsLabel.font = UIFont(name: "HelveticaNeue-Light", size: 12)
            
            ///////////////Users
            var usersLabel = UILabel(frame: CGRectMake(127, 377, 80, 20))
            usersLabel.textColor = UIColor(red:0.69, green:0.69, blue:0.69, alpha:1)
            usersLabel.text = "USERS"
            usersLabel.font = UIFont(name: "HelveticaNeue-Light", size: 12)
            
            var circleCount = UILabel(frame: CGRectMake(110, 305, 70, 70))
            circleCount.layer.cornerRadius =  circleCount.frame.size.width / 2
            circleCount.layer.masksToBounds = true
            circleCount.backgroundColor = UIColor(red:0.69, green:0.69, blue:0.69, alpha:1)
            
            
            ////////////////Checkins
            var checkinsLabel = UILabel(frame: CGRectMake(193, 377, 80, 20))
            checkinsLabel.textColor = UIColor(red:0.69, green:0.69, blue:0.69, alpha:1)
            checkinsLabel.text = "CHECKINS"
            checkinsLabel.font = UIFont(name: "HelveticaNeue-Light", size: 12)
            
            var circleCheckin = UILabel(frame: CGRectMake(185, 305, 70, 70))
            circleCheckin.layer.cornerRadius =  circleCheckin.frame.size.width / 2
            circleCheckin.layer.masksToBounds = true
            circleCheckin.backgroundColor = UIColor(red:0.69, green:0.69, blue:0.69, alpha:1)
            
            
            /////////////Tips
            var tipLabel = UILabel(frame: CGRectMake(285, 377, 80, 20))
            tipLabel.textColor = UIColor(red:0.69, green:0.69, blue:0.69, alpha:1)
            tipLabel.text = "TIPS"
            tipLabel.font = UIFont(name: "HelveticaNeue-Light", size: 12)
            
            var circleTip = UILabel(frame: CGRectMake(260, 305, 70, 70))
            circleTip.layer.cornerRadius = circleTip.frame.size.width / 2
            circleTip.layer.masksToBounds = true
            circleTip.backgroundColor = UIColor(red:0.69, green:0.69, blue:0.69, alpha:1)
            
            detailVC.view.addSubview(circleCheckin)
            detailVC.view.addSubview(circleCount)
            detailVC.view.addSubview(circleTip)
            detailVC.view.addSubview(statsLabel)
            detailVC.view.addSubview(usersLabel)
            detailVC.view.addSubview(checkinsLabel)
            detailVC.view.addSubview(tipLabel)
            
            circleCheckin.text = "\(checkinsCount)"
            circleCheckin.textAlignment = .Center
            circleCheckin.textColor = UIColor.whiteColor()
            circleCount.text = "\(usersCount)"
            circleCount.textAlignment = .Center
            circleCount.textColor = UIColor.whiteColor()
            circleTip.text = "\(tipCount)"
            circleTip.textAlignment = .Center
            circleTip.textColor = UIColor.whiteColor()

            
            println(checkinsCount)
            println(usersCount)
            println(tipCount)
            
        }
        
        if let hereNow = venue["hereNow"] as? [String:AnyObject] {
            
            var summary = hereNow["summary"] as? String
            
            var hereNowDivider = UIView(frame: CGRectMake(90, 430, 5, 36))
            hereNowDivider.backgroundColor = UIColor(red:0.69, green:0.69, blue:0.69, alpha:1)
            
            var hereNowLabel = UILabel(frame: CGRectMake(110, 415, 100, 40))
            hereNowLabel.textColor = UIColor(red:0.69, green:0.69, blue:0.69, alpha:1)
            hereNowLabel.text = "HERE NOW"
            hereNowLabel.font = UIFont(name: "HelveticaNeue-Light", size: 12)
            
            var hereNowStat = UILabel(frame: CGRectMake(110, 435, 260, 40))
            hereNowStat.textColor = UIColor(red:0.69, green:0.69, blue:0.69, alpha:1)
            hereNowStat.text = summary
            hereNowStat.font = UIFont(name: "HelveticaNeue-Light", size: 22)
            
            detailVC.view.addSubview(hereNowLabel)
            detailVC.view.addSubview(hereNowDivider)
            detailVC.view.addSubview(hereNowStat)
            
        }

        navigationController?.pushViewController(detailVC, animated: true)

    }
    
}

