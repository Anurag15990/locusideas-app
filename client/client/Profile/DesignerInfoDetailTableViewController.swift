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
        tableView.registerNib(UINib(nibName: "DesignerSkillsCard", bundle: nil), forCellReuseIdentifier: "DesignerSkillsCard")
        tableView.registerNib(UINib(nibName: "DesignerLinksCard", bundle: nil), forCellReuseIdentifier: "DesignerLinksCard")

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
        return 7
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        switch indexPath.section {
            
        case 3 :
            return 20
        case 4 :
            return 50
        case 6 :
            return 30
        default :
            return 140
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DesignerWorkExpCard", forIndexPath: indexPath) as! DesignerWorkExpCard
        
        switch indexPath.section {
            
        case 0 :
            cell.companyNameLabel.text = "jabong".uppercaseString
            cell.designationLabel.text = "UI/UX Design Intern"
            cell.servingPeriodLabel.text = "6 months"
            cell.jobDescriptionLabel.text = "Interned as a graphic designer at Jabong.com and worked on multiple projects including IOFW (India Online Fashion Week), On site and social media creatives."
            
        case 1 :
            cell.companyNameLabel.text = "national institute of fashion technology, mumbai".uppercaseString
            cell.designationLabel.text = "Fashion Communication"
            cell.servingPeriodLabel.text = "August 2012 - Present"
            cell.jobDescriptionLabel.text = "This course includes Fashion Studies, History and Philosophy of Design, Communication Concepts & Processes, Writing Skills, Consumer Behavior in Fashion, Computer Application, Graphic Design, Visual Merchandising, Photography."
            
        case 3 :
           _ = tableView.dequeueReusableCellWithIdentifier("DesignerSkillsCard", forIndexPath: indexPath)
            as! DesignerSkillsCard
        case 4 :
            _ = tableView.dequeueReusableCellWithIdentifier("DesignerLinksCard", forIndexPath: indexPath) as! DesignerLinksCard
            
        case 6 :
            let cell = tableView.dequeueReusableCellWithIdentifier("DesignerContactCard", forIndexPath: indexPath) as! DesignerContactCard
            
            if indexPath.row == 0 {
                cell.contactIconLabel.text = ""
            }
            
        default :
            break
        }
        
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
        case 2 :
            header.titleLabel.text = "SPECIALIZATION"
        case 3 :
            header.titleLabel.text = "SKILLS"
        case 4 :
            header.titleLabel.text = "LINKS"
        case 5 :
            header.titleLabel.text = "STATS"
        case 6 :
            header.titleLabel.text = "CONTACT"
        default :
            break
        }
        
        return cell
    }
}
