//
//  DesignerWorkExperienceHeaderView.swift
//  client
//
//  Created by Neha Yadav on 20/04/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import UIKit

class DesignerWorkExperienceHeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var containerView : ContainerView!
    @IBOutlet weak var titleLabel : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.backgroundColor = UIColor(red: 247.0/255.0, green: 247.0/255.0, blue: 247.0/255.0, alpha: 1)
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor(red: 151.0/255.0, green: 151.0/255.0, blue: 151.0/255.0, alpha: 1).CGColor
    }
    
    
}
