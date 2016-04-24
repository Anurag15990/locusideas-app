//
//  DesignerWorkExpCard.swift
//  client
//
//  Created by Neha Yadav on 22/04/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import UIKit

class DesignerWorkExpCard: UITableViewCell {
    
    @IBOutlet weak var containerView : ContainerView!
    @IBOutlet weak var companyNameLabel : UILabel!
    @IBOutlet weak var designationLabel: UILabel!
    @IBOutlet weak var jobDescriptionLabel : UILabel!
    @IBOutlet weak var servingPeriodLabel : UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        companyNameLabel.text = "jabong".uppercaseString
        designationLabel.text = "UI/UX Design Intern"
        jobDescriptionLabel.text = "Interned as a graphic designer at Jabong.com and worked on multiple projects including IOFW (India Online Fashion Week), On site and social media creatives."
        servingPeriodLabel.text = "6 months"
        
        
    }
    
    
}
