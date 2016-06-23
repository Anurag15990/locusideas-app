//
//  CloudinaryService.swift
//  client
//
//  Created by Anurag Agnihotri on 6/24/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import Foundation
import Cloudinary

class CloudinaryService: NSObject {
    
    let API_KEY = "457641541578998"
    let CLOUD_NAME = "superapp"
    let API_SECRET = "AwazODq1ZDA7doDmNAOQKkubc"
    
    static var sharedInstance = CloudinaryService()
    
    var cloudinary: CLCloudinary?
    
    /**
     Various quality level used while optimizing images.
     
     - Low:    Quality 30
     - Medium: Quality 50
     - High:   Quality 80
     */
    enum Quality: String {
        case Low = "30"
        case Medium = "50"
        case High = "80"
    }
    
    /*
     * Default Quality
     */
    var quality = Quality.Medium.rawValue
    
    
    /**
     The enum accepts the parameters given below.
     
     - Width:              enter width in the format of string . EG: 50
     - Height:             enter Height in the format of string . EG: 60
     - Blur:               enter Blur in the format of string . EG: 50
     
     - Radius:             enter Radius of the image in the format of string . EG: 70
     
     - Border:             enter border size and color together in the format of string . eg : "2px_solid_black
     - Crop:               enter width in the format of string . EG: "thumb" ,"fill"
     */
    enum TRANSFORMATION {
        case Width
        case Height
        case Blur
        case Radius
        case Border
        case Crop
        case Quality
        case Effect
        case Color
        case Background
        case FetchFormat
    }
    
    /**
     The transformImage function is going to take the parameters given below.
     
     - parameter cloudinaryId:    This is the cloudinary id of the image.
     - parameter transformations: You can pass a single transformation or multiple transformations
     
     - returns: It will return the url of the photo which is converted according to the parameters you have provided.
     */
    func transformImage(cloudinaryId: String, transformations: [TRANSFORMATION : String]) -> String {
        
        
        if cloudinary == nil {
            cloudinary = CLCloudinary(url: "cloudinary://\(API_KEY):\(API_SECRET)@\(CLOUD_NAME)")
        }
        
        let transformation = CLTransformation()
        
        
        let setHeightWithInt = transformations[.Height]
        if setHeightWithInt != nil {
            transformation.setHeightWithInt(Int32(setHeightWithInt!)!)
        }
        
        let setWidthWithInt = transformations[.Width]
        if   setWidthWithInt != nil {
            transformation.setWidthWithInt(Int32(setWidthWithInt!)!)
        }
        
        let setEffect = transformations[.Blur]
        if  setEffect != nil {
            transformation.setEffect("blur" , param: setEffect)
        }
        
        let radius = transformations[.Radius]
        if radius != nil {
            transformation.radius = radius
        }
        
        let border = transformations[.Border]
        if border  != nil {
            transformation.border = border
        }
        
        let crop = transformations[.Crop]
        if  crop != nil {
            transformation.crop = crop
        }
        
        let quality = transformations[.Quality]
        
        if quality != nil {
            transformation.quality = quality
        } else {
            transformation.quality = quality
        }
        
        let effect = transformations[.Effect]
        if effect != nil {
            transformation.effect = effect
        }
        
        
        let color = transformations[.Color]
        if color != nil {
            transformation.param("color", value: color)
        }
        
        let background = transformations[.Background]
        if (background != nil) {
            transformation.background = background
        }
        
        let fetchFormat = transformations[.FetchFormat]
        
        if (fetchFormat != nil) {
            transformation.fetchFormat = fetchFormat
        }
        
        let modifiedUrl = cloudinary?.url(cloudinaryId, options: ["transformation": transformation])
        return modifiedUrl!
    }
}