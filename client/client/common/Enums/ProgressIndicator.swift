//
//  ProgressIndicator.swift
//  client
//
//  Created by Anurag Agnihotri on 7/6/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import Foundation

/**
 Progress Indicator Enum to decide the Status Of Rest API Calls.
 
 - None:       <#None description#>
 - InProgress: <#InProgress description#>
 - Finished:   <#Finished description#>
 */
enum ProgressIndicator {
    case None
    case InProgress
    case Finished
}