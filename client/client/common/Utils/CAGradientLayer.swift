//
//  CAGradientLayer.swift
//  client
//
//  Created by Neha Yadav on 05/02/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import UIKit

extension CAGradientLayer {
    class func gradientLayerForBounds(bounds: CGRect) -> CAGradientLayer {
        let layer = CAGradientLayer()
        layer.frame = bounds
        layer.colors = [UIColor(red: 0, green: 0, blue: 0, alpha: 0.70).CGColor, UIColor.clearColor().CGColor]
        return layer
    }
}
