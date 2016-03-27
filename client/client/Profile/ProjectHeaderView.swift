//
//  ProjectHeaderView.swift
//  client
//
//  Created by Neha Yadav on 27/03/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import UIKit

class ProjectHeaderView: UITableViewCell {
    
    @IBOutlet weak var projectView : UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        projectView.layer.backgroundColor = UIColor(red: 54.0/255.0, green: 165.0/255.0, blue: 177.0/255.0, alpha: 0.8).CGColor
        self.selectionStyle = .None
    }
}
