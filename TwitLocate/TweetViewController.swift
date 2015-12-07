//
//  TweetViewController.swift
//  TwitLocate
//
//  Created by Onur Küçük on 7.12.2015.
//  Copyright © 2015 Onur Küçük. All rights reserved.
//

import UIKit

class TweetViewController: UITableViewController {

    var selectedKm:Int!
    var allTweets = [AnyObject]()
    override func viewDidLoad() {
        super.viewDidLoad()

        let config = NSURLSessionConfiguration.defaultSessionConfiguration()

        //Date?
        config.HTTPAdditionalHeaders = ["Content-Type":"application/x-www-form-urlencoded;charset=UTF-8",
            "User-Agent":"28_Dec_2015_Workshop_App",
            "Accept-Encoding":"gzip",
            "Authorization":"Basic SDFLZ0JMVUx1RDRFVTY3NjN5YlZVaWY3TTpMdUZXa1g2bUdzQUE4RjhZeTlPS3djb2Z4U01Da1NOUW5oaTJqMGhOMEwzZlBGUFJucw=="]
        
        let url = NSURL(string: "https://api.twitter.com/oauth2/token")
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        request.HTTPBody = "grant_type=client_credentials".dataUsingEncoding(NSUTF8StringEncoding)
        let session = NSURLSession(configuration: config)
        let dataTask = session.dataTaskWithRequest(request) { (data:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
            do {
            let dict = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                let token = dict.valueForKey("access_token") as! String
                self.callTwitterWithToken(token)
            }
            catch{}
        }
        dataTask.resume()
    }

    func callTwitterWithToken(token:String){
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        //Date?
        config.HTTPAdditionalHeaders = ["User-Agent":"28_Dec_2015_Workshop_App",
        "Accept-Encoding":"gzip",
        "Authorization":"Bearer \(token)"]
        
        let urlToCall = "https://api.twitter.com/1.1/search/tweets.json?q=&geocode=41.068861,29.0105796,\(selectedKm)km&count=20"
        let request = NSMutableURLRequest(URL: NSURL(string: urlToCall)!)
        let session = NSURLSession(configuration: config)
        let dataTask = session.dataTaskWithRequest(request) { (data:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
            do {
                let dict = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                self.allTweets = dict.valueForKey("statuses") as! [AnyObject]
                self.performSelectorOnMainThread("updateUI", withObject: nil, waitUntilDone: false)
            }
            catch{}
        }
        dataTask.resume()
        
    }
    
    func updateUI(){
        self.tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allTweets.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 206.0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TitleCell2", forIndexPath: indexPath)

        let tweet = self.allTweets[indexPath.row] as! NSDictionary
        
        let tweetUser = cell.contentView.viewWithTag(1) as! UILabel
        let tweetContent = cell.contentView.viewWithTag(2) as! UILabel
        let tweetTime = cell.contentView.viewWithTag(3) as! UILabel

        tweetContent.text = tweet["text"] as? String
        tweetUser.text = tweet["user"]!["screen_name"] as? String
        tweetTime.text = tweet["created_at"] as? String
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let tweet = self.allTweets[indexPath.row]
        let cont = self.storyboard?.instantiateViewControllerWithIdentifier("UserView") as! UserViewController
        cont.tweet = tweet as! NSDictionary
        self.navigationController?.pushViewController(cont, animated: true)
        
    }

}
