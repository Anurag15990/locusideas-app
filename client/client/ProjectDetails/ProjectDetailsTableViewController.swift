//
//  ProjectDetailsTableViewController.swift
//  client
//
//  Created by Neha Yadav on 02/02/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import UIKit

class ProjectDetailsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView : UITableView!
    
    var project : Project!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.registerNib(UINib(nibName: "ProjectInfo", bundle: nil), forCellReuseIdentifier: "ProjectInfo")
        tableView.registerNib(UINib(nibName: "ProjectDescription", bundle: nil), forCellReuseIdentifier: "ProjectDescription")
        tableView.registerNib(UINib(nibName: "ProjectGalleryCell", bundle: nil), forCellReuseIdentifier: "ProjectGalleryCell")
        tableView.separatorStyle = .None
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 4.0/255.0, green: 158.0/255.0, blue: 143.0/255.0, alpha: 1.0)
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_arrow_back_white_18pt"), style: .Plain, target: self, action: #selector(ProjectDetailsTableViewController.backButtonPressed(_:)))

        
//        self.setNeedsStatusBarAppearanceUpdate()
        
    }
    
    func backButtonPressed(sender: UIButton) {
        navigationController?.popViewControllerAnimated(true)
    }
    
//    override func preferredStatusBarStyle() -> UIStatusBarStyle {
//        return .LightContent
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2 + self.getProjectMediaCount()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("ProjectInfo", forIndexPath: indexPath) as! ProjectInfo
            cell.projectTitleLabel.text = self.getProjectTitle()
            cell.designerNameLabel.text = self.getProjectOwnerName()
            if let profilePicture = self.getProfileImage() {
                cell.designerProfileImage.kf_setImageWithURL(NSURL(string: profilePicture)!)
            }
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier("ProjectDescription", forIndexPath: indexPath) as! ProjectDescription
            cell.descriptionLabel.text = self.getProjectDescription()
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("ProjectGalleryCell", forIndexPath: indexPath) as! ProjectGalleryCell
            let media = self.getProjectMedia()[indexPath.row - 2].media
            cell.galleryImageView.kf_setImageWithURL(NSURL(string: (media?.url)!)!)
            return cell
        }
    }
    
    func calculateHeightForString(text: String) -> CGFloat {
        
        let annotationPadding = CGFloat(24)
        let font = UIFont(name: "Asap-regular", size: 14)!
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.9
        paragraphStyle.lineSpacing = 4.0
        
        
        let rect = NSString(string: text).boundingRectWithSize(CGSize(width: self.tableView.frame.width - 24, height: CGFloat(MAXFLOAT)), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName : font, NSParagraphStyleAttributeName: paragraphStyle], context: nil)
        
        let descriptionHeight = ceil(rect.height)
        let height = annotationPadding + descriptionHeight
        
        print(height)
        return height
        
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.row == 0{
            return 160
        } else if indexPath.row == 1{
            if let text = self.getProjectDescription() {
                return calculateHeightForString(text)
            }
        }else {
            return 300
        }
        return 0
    }
    
    func getProjectMediaCount() -> Int {
        
        return self.project!.medias!.initial!.count
        
    }
    
    func getProjectTitle() -> String {
        
        return self.project!.title!
    }
    
    func getProjectOwnerName() -> String {
        
        var fullName = ""
        
        if let firstName = self.project.owner?.user!.name?.firstName {
            fullName += firstName + " "
        }
        
        if let lastName = self.project.owner?.user!.name?.lastName {
            fullName += lastName
        }
        return fullName
    }
    
    func getProfileImage() -> String? {
        
        return self.project.owner?.user?.picture?.url
    }
    
    func getProjectDescription() -> String? {
        
        return self.project!.projectDescription
    }
    
    func getProjectMedia() -> [MediaObject.InitialMedia] {
        
        return self.project!.medias!.initial!
    
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
