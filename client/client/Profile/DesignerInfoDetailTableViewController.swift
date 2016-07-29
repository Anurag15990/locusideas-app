//
//  DesignerInfoDetailTableViewController.swift
//  client
//
//  Created by Neha Yadav on 20/04/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import UIKit

class DesignerInfoDetailTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var profileHeaderView = "MyProfileHeaderView"

    @IBOutlet weak var tableView : UITableView!
    var viewModel : DesignerProfileViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerNib(UINib(nibName: profileHeaderView, bundle: nil), forHeaderFooterViewReuseIdentifier: profileHeaderView)
        setupNavigationBar()
        tableView.separatorStyle = .None
        
        
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.barTintColor = UIColor(red: 4.0/255.0, green: 158.0/255.0, blue: 143.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Lobster 1.4", size: 20)!, NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_arrow_back_white_18pt"), style: .Plain, target: self, action: #selector(DesignerInfoDetailTableViewController.backButtonPressed(_:)))
        self.title = "Info"
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
        return self.viewModel.designerInfoSections.count
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.viewModel.designerInfoSections[section] {
        case .EducationExperienceSection:
            return viewModel.fetchUserEducationExperience()!.experience!.count
        case .WorkExperienceSection:
            return viewModel.fetchUserWorkExperience()!.experience!.count
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
       return 74
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch self.viewModel.designerInfoSections[indexPath.section] {
        case .EducationExperienceSection:
            let cell = tableView.dequeueReusableCellWithIdentifier("DesignersEducationExperienceCell", forIndexPath: indexPath) as! DesignersEducationExperienceCell
            let education = self.viewModel.fetchUserEducationExperience()!.experience![indexPath.row]
            cell.institutionLabel.text = education.school
            cell.degreeLabel.text = education.degree
            return cell
        case .WorkExperienceSection:
            let cell = tableView.dequeueReusableCellWithIdentifier("DesignersWorkExperienceCell", forIndexPath: indexPath) as! DesignersWorkExperienceCell
            let work = self.viewModel.fetchUserWorkExperience()!.experience![indexPath.row]
            cell.organizationLabel.text = work.organization
            cell.designationLabel.text = work.designation
            return cell
        default:
            return UITableViewCell()
        }
       
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableHeaderFooterViewWithIdentifier(self.profileHeaderView) as! MyProfileHeaderView
        
        switch self.viewModel.designerInfoSections[section] {
        case .EducationExperienceSection:
            headerView.headerLabel.text = "EDUCATION EXPERIENCE"
            
        case .WorkExperienceSection:
            headerView.headerLabel.text = "WORK EXPERIENCE"
            
        default: break
            
        }
        
        return headerView
    }
}
