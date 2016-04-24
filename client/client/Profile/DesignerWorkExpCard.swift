//
//  DesignerWorkExpCard.swift
//  client
//
//  Created by Neha Yadav on 22/04/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import UIKit

class DesignerWorkExpCard: UITableViewCell {
    
    @IBOutlet weak var containerView : UIView!
    @IBOutlet weak var companyNameLabel : UILabel!
    @IBOutlet weak var designationLabel: UILabel!
    @IBOutlet weak var jobDescriptionLabel : UILabel!
    @IBOutlet weak var servingPeriodLabel : UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .None
        containerView.layer.borderWidth = 0.5
        containerView.layer.borderColor = UIColor.lightGrayColor().CGColor
    }
    
    
}
