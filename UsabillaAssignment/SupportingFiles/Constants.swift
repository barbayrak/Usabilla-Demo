//
//  Constatns.swift
//  UsabillaAssignment
//
//  Created by Kaan Baris BAYRAK on 20.04.2019.
//  Copyright © 2019 Kaan Baris Bayrak. All rights reserved.
//

import Foundation
import UIKit

let colors = [
    UIColor(netHex: 0xE74C3C),
    UIColor(netHex: 0xA569BD),
    UIColor(netHex: 0x5499C7),
    UIColor(netHex: 0x48C9B0),
    UIColor(netHex: 0xF4D03F),
    UIColor(netHex: 0x34495E),
    UIColor(netHex: 0xb71c1c),
    UIColor(netHex: 0xc2185b),
    UIColor(netHex: 0x8e24aa),
    UIColor(netHex: 0x651fff),
    UIColor(netHex: 0x0091ea),
    UIColor(netHex: 0x64ffda)
]

func findSQLiteLocation() {
    let path = FileManager
        .default
        .urls(for: .applicationSupportDirectory, in: .userDomainMask)
        .last?
        .absoluteString
        .replacingOccurrences(of: "file://", with: "")
        .removingPercentEncoding

    print("SQLitePath : ",path ?? "Not found")
}
