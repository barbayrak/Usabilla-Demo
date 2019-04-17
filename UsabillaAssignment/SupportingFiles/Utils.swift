//
//  Utils.swift
//  UsabillaAssignment
//
//  Created by Kaan Baris BAYRAK on 17.04.2019.
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
    UIColor(netHex: 0x34495E)
]

extension Array {
    
    func groupBy<T>(by criteria: (Element) -> T) -> [T: Int] {
        var groups = [T: Int]()
        for element in self{
            let key = criteria(element)
            if groups.keys.contains(key) == false {
                groups[key] = 0
            }
            groups[key]? += 1
        }
        return groups
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}
