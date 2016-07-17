//
//  SettingsViewController.swift
//  client
//
//  Created by Anurag Agnihotri on 16/07/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import UIKit
import Bond

class SettingsViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: SettingsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = SettingsViewModel()
        // Do any additional setup after loading the view.
        self.setupNavigationBar()
        self.bindViewModel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func bindViewModel() {
        self.viewModel
            .settingsDataSourceArray
            .lift().bindTo(tableView) { indexPath, dataSource, tableView in
            
                let cell = tableView.dequeueReusableCellWithIdentifier("SettingsTableViewCell", forIndexPath: indexPath) as! SettingTableViewCell
                let settingsObject = dataSource[indexPath.section][indexPath.row]
                cell.typeIconLabel.text = settingsObject.0
                cell.dataLabel.text = settingsObject.1
                return cell
        }
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.barTintColor = UIColor(red: 4.0/255.0, green: 158.0/255.0, blue: 143.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Lobster 1.4", size: 20)!, NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.title = "Settings"
        
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 53
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let settingsObject = self.viewModel.settingsDataSourceArray.array[indexPath.row]
        switch settingsObject.1 {
        case "Logout":
            self.logoutUser()
            break
        default:
            break
        }
    }
    
    /**
     Method to logout User From the App.
     */
    func logoutUser() {
        NSUserDefaultsUtils.clearUserDefaults()
        (UIApplication.sharedApplication().delegate as! AppDelegate).redirectToLoginFlow()
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
