//
//  ProjectGalleryCell.swift
//  client
//
//  Created by Neha Yadav on 04/02/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import UIKit

class ProjectGalleryCell: UITableViewCell {

    @IBOutlet weak var galleryImageView : UIImageView!
    @IBOutlet weak var gradientView : UIView!
    @IBOutlet weak var moreLabel : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        galleryImageView.clipsToBounds = true
        galleryImageView.image = UIImage_Gradient.imageWithGradientAtBottom(UIImage(named: "Studio_pepperfry.jpg"))
        self.selectionStyle = .None
        
//        setBackgroundLayer()
    }
    
    func setBackgroundLayer() {
        print(gradientView.layer.sublayers?.count)
        
        if let sublayers = gradientView.layer.sublayers{
            if sublayers.count > 1 {
                self.gradientView.layer.sublayers?.removeFirst()
            }
        }
        
        let backgroundLayer : CAGradientLayer = UIImage_Gradient.blackBottomLayer()
        backgroundLayer.frame = self.gradientView.frame
        self.gradientView.layer.insertSublayer(backgroundLayer, atIndex: 0)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
