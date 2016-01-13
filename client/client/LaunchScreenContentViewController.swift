//
//  LaunchScreenContentViewController.swift
//  client
//
//  Created by Neha Yadav on 12/01/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import UIKit

class LaunchScreenContentViewController: UIViewController {
    
    @IBOutlet weak var contentImageView : UIImageView!
    
    var imageIndex: Int = 0
    var imageName: String = "" {
        
        didSet {
            
            if let imageView = contentImageView {
                imageView.image = UIImage(named: imageName)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        contentImageView!.image = UIImage(named: imageName)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
