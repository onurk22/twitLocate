//
//  RadiusSelectorViewController.swift
//  TwitLocate
//
//  Created by Onur Küçük on 7.12.2015.
//  Copyright © 2015 Onur Küçük. All rights reserved.
//

import UIKit

class RadiusSelectorViewController: UIViewController {

    @IBOutlet weak var kmSelector: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cont = segue.destinationViewController as! TweetViewController
        
        if self.kmSelector.selectedSegmentIndex == 0 {
            cont.selectedKm = 1
        }
        else if self.kmSelector.selectedSegmentIndex == 1 {
            cont.selectedKm = 5
        }
        else {
            cont.selectedKm = 10
        }
    }
}
