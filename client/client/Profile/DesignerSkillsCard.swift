//
//  DesignerSkillsCard.swift
//  client
//
//  Created by Neha Yadav on 03/05/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import Foundation
import UIKit

class DesignerSkillsCard: UITableViewCell {
    
    @IBOutlet weak var skillLabel : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        skillLabel.text = "Adobe Illustrator"
        
    }
    
}
