//
//  UserViewController.swift
//  TwitLocate
//
//  Created by Onur Küçük on 7.12.2015.
//  Copyright © 2015 Onur Küçük. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {

    @IBOutlet weak var profile: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var desc: UILabel!

    var tweet = NSDictionary()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.name.text = self.tweet["user"]!["name"] as? String
        self.desc.text = self.tweet["user"]!["description"] as? String
        
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
