//
//  Feedback.swift
//  UsabillaAssignment
//
//  Created by Kaan Baris BAYRAK on 15.04.2019.
//  Copyright © 2019 Kaan Baris Bayrak. All rights reserved.
//

import Foundation

struct FeedbackItem : Codable {
    let id : String
    let browser : Browser
    let geo : GeoLocation
    let rating : Int
    let labels : [String]
    var createdAt : Int
    
    private enum CodingKeys : String, CodingKey {
        case id, browser = "computed_browser", geo, rating , labels , createdAt = "creation_date"
    }
}
