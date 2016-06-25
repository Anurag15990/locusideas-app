//
//  DesignerLinksCard.swift
//  client
//
//  Created by Neha Yadav on 30/04/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import Foundation
import UIKit

class DesignerLinksCard : UITableViewCell {

    @IBOutlet weak var containerView : UIView!
    @IBOutlet weak var iconLabel : UILabel!
    @IBOutlet weak var linkLabel : UILabel!
    
    override func awakeFromNib() {
        
        setUpInitialView()
    }
    
    func setUpInitialView() {
        
        iconLabel.backgroundColor = UIColor(red: 59.0/255.0, green: 89.0/255.0, blue: 152.0/255.0, alpha: 1.0)
        iconLabel.layer.cornerRadius = 5.0
        iconLabel.clipsToBounds = true
        
        
        self.selectionStyle = .None
        containerView.layer.borderWidth = 0.5
        containerView.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        
    }


}
