//
//  DesignerProfileProjectsCell.swift
//  client
//
//  Created by Anurag Agnihotri on 20/07/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import UIKit
import Kingfisher

class DesignerProfileProjectsCell: UICollectionViewCell {
 
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var projectName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        coverImage.kf_setImageWithURL(NSURL(string: "http://res.cloudinary.com/dxtera6ex/image/upload/v1466760360/576cfc73f8d94e68746add05.jpg")!, placeholderImage: UIImage(named: "Placeholder"))
    }
}
