//
//  ProjectDetailsTableViewController.swift
//  client
//
//  Created by Neha Yadav on 02/02/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import UIKit
import IDMPhotoBrowser
import Kingfisher

class ProjectDetailsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, IDMPhotoBrowserDelegate {

    @IBOutlet weak var tableView : UITableView!
    
    private var screenWidth = UIScreen.mainScreen().bounds.size.width
    private var imageViewHeight: CGFloat = 300

    
    var project : Project!
    
    var medias =  Array<MediaObject.InitialMedia>()
    
    var photos = [IDMPhoto]()
    
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

        self.assignMediasArray()
    }
    
    /**
     Method to Assign Media Array.
     */
    func assignMediasArray() {
        
        ProjectService.sharedInstance.fetchProjectMediaById(self.project.id!, successCallback: { (media) in
           
            if let projectMedias = media.projectMedias {
                
                self.medias = projectMedias
                
                for media in self.medias {
                    self.photos.append(self.constructIDMPhoto(media))
                }
                
                self.tableView.reloadData()
            
            }
            
            
        }) { (error) in
                print(error.localizedDescription)
        }
        
       
    }
    
    /**
     Method to Construct IDM Photo from Media Object.
     
     - parameter media: <#media description#>
     
     - returns: <#return value description#>
     */
    func constructIDMPhoto(media: MediaObject.InitialMedia) -> IDMPhoto {
        let photoObj:IDMPhoto = IDMPhoto()
        
        if let url = media.media?.url {
            
            photoObj.photoURL = NSURL(string: url)

        }
        
        return photoObj
    }
    
    func backButtonPressed(sender: UIButton) {
        navigationController?.popViewControllerAnimated(true)
    }
    

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
            let media = self.medias[indexPath.row - 2].media
            cell.galleryImageView.kf_setImageWithURL(NSURL(string: (media?.url)!)!, placeholderImage: UIImage(named: "Placeholder"))
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row != 0 && indexPath.row != 1 {
            showImage(self.photos, animatedView: tableView.cellForRowAtIndexPath(indexPath)!.contentView, index: UInt(indexPath.row - 2))
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
            if let media = self.medias[indexPath.row - 2].media {
                let imageRatio: CGFloat = CGFloat(media.height!) / CGFloat(media.width!)
                if imageRatio == 0 || imageRatio < 0 {
                    return imageViewHeight
                }
                return screenWidth * imageRatio
            }
            return imageViewHeight
        }
        return 0
    }
    
    /**
     Method to Get Media Count
     
     - returns: <#return value description#>
     */
    func getProjectMediaCount() -> Int {
        
        return self.medias.count
        
    }
    
    /**
     Method to Get Project Title.
     
     - returns: <#return value description#>
     */
    func getProjectTitle() -> String {
        
        return self.project!.title!
    }
    
    /**
     Method to Get Project Owner Name
     
     - returns: <#return value description#>
     */
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
    
    /**
     Method to Get Profile Image of the User.
     
     - returns: <#return value description#>
     */
    func getProfileImage() -> String? {
        
        return self.project.owner?.user?.picture?.url
    }
    
    func getProjectDescription() -> String? {
        
        return self.project!.projectDescription
    }
    
    func getProjectMedia() -> [MediaObject.InitialMedia] {
        
        return self.project!.medias!.initial!
    
    }
    
    /**
     Method to Open Gallery Image View with all Photos Array and Selected Photo Index.
     
     - parameter photos:       <#photos description#>
     - parameter animatedView: <#animatedView description#>
     - parameter index:        <#index description#>
     */
    func showImage(photos: [IDMPhoto], animatedView:UIView, index: UInt) {
        let browser:IDMPhotoBrowser = IDMPhotoBrowser(photos: photos,animatedFromView: animatedView)
        browser.displayArrowButton = true
        browser.displayCounterLabel = false
        browser.displayActionButton = false
        browser.displayDoneButton = true
        browser.delegate = self
        browser.setInitialPageIndex(index)
        self.presentViewController(browser, animated: true, completion: nil)
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
