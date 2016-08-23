//
//  GooglePlacesServices.swift
//  client
//
//  Created by Anurag Agnihotri on 23/08/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import Foundation
import GooglePlaces

class GooglePlacesServices: NSObject {
    
    static let sharedInstance = GooglePlacesServices()
    
    func getPlaces(place: String, placeType: GMSPlacesAutocompleteTypeFilter = .City,
                   successCallback: ((predictions: [GMSAutocompletePrediction]) -> Void),
                   errorCallback: ((error: NSError) -> Void)) {
        
        let placesClient = GMSPlacesClient()
        
        let filter = GMSAutocompleteFilter()
        filter.type = placeType
        
        placesClient.autocompleteQuery(place, bounds: nil, filter: filter) { (predictions, error) in
            
            guard error == nil else {
                errorCallback(error: error!)
                return
            }
            
            if let predictions = predictions {
                successCallback(predictions: predictions)
            }
            
        }
    }
    
}