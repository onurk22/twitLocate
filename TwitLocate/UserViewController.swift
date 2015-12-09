//
//  UserViewController.swift
//  TwitLocate
//
//  Created by Onur Küçük on 7.12.2015.
//  Copyright © 2015 Onur Küçük. All rights reserved.
//

import UIKit
import MapKit

class UserViewController: UIViewController{

    @IBOutlet weak var profile: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    
    var tweetCoordinates:CLLocationCoordinate2D!
    var tweet = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.name.text = self.tweet["user"]!["name"] as? String
        self.desc.text = self.tweet["user"]!["description"] as? String
        let coordinateArray = self.tweet["geo"]!["coordinates"]! as! NSMutableArray
        
        let latitude = coordinateArray[0] as! Double
        let longitude = coordinateArray[1] as! Double

        tweetCoordinates = CLLocationCoordinate2DMake(latitude, longitude)
        self.prepareMap()
        self.getProfileImage()

    }

    func getProfileImage(){
        
        let imageURLString = self.tweet["user"]!["profile_image_url"] as? String
        let imageURL = NSURL(string: imageURLString!)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(imageURL!) { (returnedImageData:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
            if returnedImageData != nil {
                dispatch_async(dispatch_get_main_queue(), {
                    self.profile.image = UIImage(data: returnedImageData!)

                })
            }
        }
        task.resume()
    }
    
    func prepareMap(){
        let tweetAnnotation = MKPointAnnotation()
        tweetAnnotation.coordinate = tweetCoordinates
        self.mapView.addAnnotation(tweetAnnotation)
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01,0.01)
        let viewRegion:MKCoordinateRegion = MKCoordinateRegion(center: tweetCoordinates, span: span)
        self.mapView.setRegion(viewRegion, animated: true)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
