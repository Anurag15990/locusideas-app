//
//  SetLocationViewController.swift
//  client
//
//  Created by Anurag Agnihotri on 23/08/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import UIKit
import GooglePlaces

class SetLocationViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var googlePredictions = [GMSAutocompletePrediction]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initialSetup() {
        self.searchBar.delegate = self
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

extension SetLocationViewController: UISearchBarDelegate {
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        GooglePlacesServices.sharedInstance.getPlaces(searchText, successCallback: { (predictions) in
            
            self.googlePredictions = predictions
            self.tableView.reloadData()
            
        }) { (error) in
        
            print(error.localizedDescription)
        }
    }
}

extension SetLocationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return googlePredictions.count + 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("DetectLocationTableViewCell", forIndexPath: indexPath) as! DetectLocationTableViewCell
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("GooglePredictionsTableViewCell", forIndexPath: indexPath) as! GooglePredictionsTableViewCell
            cell.predictionLabel.attributedText = self.googlePredictions[indexPath.row - 1].attributedPrimaryText
            return cell
        }
    }
}
