//
//  GeoLocation.swift
//  UsabillaAssignment
//
//  Created by Kaan Baris BAYRAK on 15.04.2019.
//  Copyright © 2019 Kaan Baris Bayrak. All rights reserved.
//

import Foundation

struct GeoLocation : Codable {
    let latitude : Double
    let longtitude : Double
    let countryCode : String
    let city : String?
    
    private enum CodingKeys : String, CodingKey {
        case latitude = "lat",longtitude = "lon",countryCode = "country",city
    }
}
