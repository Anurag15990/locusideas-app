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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.registerNib(UINib(nibName: "ProjectInfo", bundle: nil), forCellReuseIdentifier: "ProjectInfo")
        tableView.registerNib(UINib(nibName: "ProjectDescription", bundle: nil), forCellReuseIdentifier: "ProjectDescription")
        tableView.separatorStyle = .None
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 4.0/255.0, green: 158.0/255.0, blue: 143.0/255.0, alpha: 1.0)
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
//        self.setNeedsStatusBarAppearanceUpdate()
        
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
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("ProjectInfo", forIndexPath: indexPath) as! ProjectInfo
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("ProjectDescription", forIndexPath: indexPath) as! ProjectDescription
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
            let text = "You might be asking why you need Alamofire in the first place. Apple provides the NSURLSession class and related classes for downloading content via HTTP, so why complicate things with another third party library? The short answer is that Alamofire is based on NSURLSession, but it frees you from writing boilerplate code and makes writing networking code much easier. You can access data on the Internet with very little effort, and your code will be much cleaner and easier to read.To use Alamofire, you first need to import it. To do this, open PhotoBrowserCollectionViewController.swift and add the following line to the top of the file: \n\n You might be asking why you need Alamofire in the first place. Apple provides the NSURLSession class and related classes for downloading content via HTTP, so why complicate things with another third party library? The short answer is that Alamofire is based on NSURLSession, but it frees you from writing boilerplate code and makes writing networking code much easier. You can access data on the Internet with very little effort, and your code will be much cleaner and easier to read.To use Alamofire, you first need to import it. To do this, open PhotoBrowserCollectionViewController.swift and add the following line to the top of the file:"
            return calculateHeightForString(text)
        }else {
            return 0
        }
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
