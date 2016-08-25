//
//  ImageUploadService.swift
//  client
//
//  Created by Anurag Agnihotri on 25/08/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import Foundation

public protocol ImageUploadDelegate {
    
    func onImageUploadStart()
    
    func onImageUploadEnd()
    
}

class ImageUploadService {
    
    let imageWidth: CGFloat = 800
    let imageHeight: CGFloat = 800
    
    var delegate: ImageUploadDelegate?
    
    /**
     Give boundary string
     
     - returns: <#return value description#>
     */
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().UUIDString)"
    }
    
    func createBodyWithParametes(parameters:[[String: String]]?, boundary: String, image: UIImage) -> NSData {
        let body = NSMutableData()
        
        let error: NSError? = nil
        
        for param in parameters! {
            let paramName = param["name"]!
            
            body.appendString("--\(boundary)\r\n")
            body.appendString("Content-Disposition:form-data; name=\"\(paramName)\"")
            
            if let filename = param["fileName"] {
                
                let contentType = "image/jpg"//param["content-type"]!
                
                let resizeImage = UIImage().resizeImage(image, targetSize: CGSizeMake(imageWidth, imageHeight))
                let fileContent = UIImageJPEGRepresentation(resizeImage, 1)
                
                if (error != nil) {
                    print(error)
                }
                
                body.appendString("; filename=\"\(filename)\"\r\n")
                body.appendString("Content-Type: \(contentType)\r\n\r\n")
                body.appendData(fileContent!)
                
            } else if let paramValue = param["value"] {
                
                body.appendString("\r\n\r\n\(paramValue)")
            }
        }
        
        body.appendString("\r\n")
        body.appendString("--\(boundary)--\r\n")
        
        return body
    }
    
    func uploadUserProfilePicture(image: UIImage) {
        let uploadUrl = NSURL(string: "\(BaseRouter.baseURL)/api/users/\(UserService.getUser()!.id!)/picture")
        
        let request = NSMutableURLRequest(URL: uploadUrl!)
        request.HTTPMethod = "POST"
        
        if let token = NSUserDefaultsUtils.getAuthToken() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        } else {
            return
        }
        
        let boundary = generateBoundaryString()
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let imageData = UIImageJPEGRepresentation(image, 1)
        
        if(imageData == nil) { return }
        let parameters = [[ "name": "image", "fileName": "userprofile.jpg" ]]
        
        request.HTTPBody = createBodyWithParametes(parameters, boundary: boundary, image: image)
        print(request)
        
        if let delegate = self.delegate {
            delegate.onImageUploadStart()
        }
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            if error != nil {
                print("error= \(error)")
                return
            }
            
            print("***** response = \(response)")
            print("***** body = \(response.value)")
            
            if let delegate = self.delegate {
                delegate.onImageUploadEnd()
            }
        }
        task.resume()
    }    
}