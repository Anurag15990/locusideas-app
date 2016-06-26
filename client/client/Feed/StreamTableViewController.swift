//
//  StreamTableViewController.swift
//  client
//
//  Created by Neha Yadav on 20/01/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import UIKit
import Kingfisher

class StreamTableViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView : UITableView!
    
    var viewModel: StreamViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = StreamViewModel()
        
        setupNavigationBar()
        
        tableView.registerNib(UINib(nibName: "StreamDesignCard", bundle: nil), forCellReuseIdentifier: "StreamDesignCard")
        tableView.separatorStyle = .None
        
        bindViewModel()
    }
    
    /**
     Method to setup Navigation Bar.
     */
    func setupNavigationBar() {
        navigationController?.navigationBar.barTintColor = UIColor(red: 4.0/255.0, green: 158.0/255.0, blue: 143.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Lobster 1.4", size: 20)!, NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.title = "Trending"
    }
    

    func bindViewModel() {
        
        viewModel.streamArrayObservable.lift().bindTo(tableView) { indexPath, dataSource, tableView in
            
            let cell = tableView.dequeueReusableCellWithIdentifier("StreamDesignCard", forIndexPath: indexPath) as! StreamDesignCard
            
            let project = dataSource[indexPath.section][indexPath.row]
            
            if let url = self.viewModel.fetchProjectPictureUrl(project) {
                cell.designCoverImage.kf_setImageWithURL(NSURL(string: url)!)
            }
            
            if let title = self.viewModel.fetchProjectTitle(project) {
                cell.designTitleLabel.text = title
            }
            
            cell.designerNameLabel.text = self.viewModel.fetchProjectOwnerName(project)
            
            return cell
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 430
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let vc = storyboard?.instantiateViewControllerWithIdentifier("ProjectDetailsTableViewController") as! ProjectDetailsTableViewController
        let project = viewModel.streamArrayObservable.array[indexPath.row]
        vc.project = project
        self.navigationController?.pushViewController(vc, animated: true)
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
