//
//  UITabBarExtension.swift
//  client
//
//  Created by Anurag Agnihotri on 19/07/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import Foundation
import UIKit

extension UITabBarItem {
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.image = self.image?.imageWithRenderingMode(.AlwaysOriginal)
    }
}