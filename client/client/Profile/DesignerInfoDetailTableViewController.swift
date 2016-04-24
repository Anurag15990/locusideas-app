//
//  DesignerInfoDetailTableViewController.swift
//  client
//
//  Created by Neha Yadav on 20/04/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import UIKit

class DesignerInfoDetailTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView : UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerNib(UINib(nibName: "DesignerWorkExpCard", bundle: nil), forCellReuseIdentifier: "DesignerWorkExpCard")
        tableView.registerNib(UINib(nibName: "DesignerWorkExperienceHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "DesignerWorkExperienceHeaderView")

        navigationController?.navigationBar.barTintColor = UIColor(red: 4.0/255.0, green: 158.0/255.0, blue: 143.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Lobster 1.4", size: 20)!, NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_arrow_back_white_18pt"), style: .Plain, target: self, action: "backButtonPressed:")
        self.title = "Info"
        
        tableView.separatorStyle = .None
        
        
    }

    func backButtonPressed(sender: UIButton) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DesignerWorkExpCard", forIndexPath: indexPath) as! DesignerWorkExpCard
        return cell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cell = self.tableView.dequeueReusableHeaderFooterViewWithIdentifier("DesignerWorkExperienceHeaderView")
        let header = cell as! DesignerWorkExperienceHeaderView
        
        switch section {
            
        case 0 :
            header.titleLabel.text = "WORK EXPERIENCE"
        case 1 :
            header.titleLabel.text = "EDUCATION"
        default :
            break
        }
        
        return cell
    }
}
