//
//  Browser.swift
//  UsabillaAssignment
//
//  Created by Kaan Baris BAYRAK on 15.04.2019.
//  Copyright © 2019 Kaan Baris Bayrak. All rights reserved.
//

import Foundation

struct Browser : Codable {
    let name : String
    let version : String
    let platform : String
    
    private enum CodingKeys : String, CodingKey {
        case name = "Browser", version = "Version", platform = "Platform"
    }
}
