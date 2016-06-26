//
//  UIImage_Gradient.swift
//  client
//
//  Created by Neha Yadav on 05/02/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import UIKit

class UIImage_Gradient : NSObject {
    
    static func imageWithGradient(img:UIImage!) -> UIImage {
        
        UIGraphicsBeginImageContext(img.size)
        let context = UIGraphicsGetCurrentContext()
        
        img.drawAtPoint(CGPointMake(0, 0))
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let locations : [CGFloat] = [0.0, 0.50, 1.0]
        
        let bottom = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).CGColor
        let top = UIColor(red: 0, green: 0, blue: 0, alpha: 0).CGColor
        
        let gradient = CGGradientCreateWithColors(colorSpace, [bottom, top, bottom], locations)
        
        let startPoint = CGPointMake(img.size.width/2, 0)
        let endPoint = CGPointMake(img.size.width/2, img.size.height)
        
        CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, CGGradientDrawingOptions(rawValue: 0))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image
    }
    
    static func imageWithFullGradient(img:UIImage!, color:UIColor) -> UIImage{
        
        UIGraphicsBeginImageContext(img.size)
        let context = UIGraphicsGetCurrentContext()
        
        img.drawAtPoint(CGPointMake(0, 0))
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let locations : [CGFloat] = [0.0, 1.0]
        
        let bottom = color.CGColor
        
        let gradient = CGGradientCreateWithColors(colorSpace, [bottom, bottom], locations)
        
        let startPoint = CGPointMake(img.size.width/2, 0)
        let endPoint = CGPointMake(img.size.width/2, img.size.height)
        
        CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, CGGradientDrawingOptions(rawValue: 0))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image
    }
    
    static func imageWithGradientAtBottom(img:UIImage!) -> UIImage{
        
        UIGraphicsBeginImageContext(img.size)
        let context = UIGraphicsGetCurrentContext()
        
        img.drawAtPoint(CGPointMake(0, 0))
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let locations : [CGFloat] = [0.50, 1.0]
        
        let bottom = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5).CGColor
        let top = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0).CGColor
        
        let gradient = CGGradientCreateWithColors(colorSpace, [top, bottom], locations)
        
        let startPoint = CGPointMake(img.size.width/2, 0)
        let endPoint = CGPointMake(img.size.width/2, img.size.height)
        
        CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, CGGradientDrawingOptions())
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image
    }
    
    static func imageLayerForGradientBackground(frame: CGRect) -> UIImage{
        
        let layer = CAGradientLayer.gradientLayerForBounds(frame)
        UIGraphicsBeginImageContext(layer.bounds.size)
        layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    static func blackBottomLayer() -> CAGradientLayer {
        let topColor = UIColor.clearColor()
        let bottomColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.70)
        
        let gradientColors = [topColor.CGColor, bottomColor.CGColor]
        let gradientLocations : [CGFloat] = [0.50, 1.0]
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations
        
        return gradientLayer
    }
    
    static func layerGradientAtTopAndBottomWithColor(color: UIColor) -> CAGradientLayer{
        
        let middleColor = UIColor.clearColor()
        let gradientColor = color
        
        let gradientColors = [gradientColor.CGColor, middleColor.CGColor, gradientColor.CGColor]
        let gradientLocations : [CGFloat] = [0.0, 0.5, 1.0]
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations
        
        return gradientLayer
    }
}
