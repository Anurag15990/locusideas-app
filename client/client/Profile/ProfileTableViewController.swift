//
//  ProfileTableViewController.swift
//  client
//
//  Created by Neha Yadav on 07/02/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import UIKit

class ProfileTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerNib(UINib(nibName: "ProfileInfoCard", bundle: nil), forCellReuseIdentifier: "ProfileInfoCard")
        tableView.separatorStyle = .None
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 4.0/255.0, green: 158.0/255.0, blue: 143.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Lobster 1.4", size: 20)!, NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.title = "Profile"
        
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_settings_white_18pt"), style: .Plain, target: self, action: nil)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 270
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ProfileInfoCard", forIndexPath: indexPath) as! ProfileInfoCard
        return cell
    }

}
