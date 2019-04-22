//
//  FeedbackItemEntity+CoreDataProperties.swift
//  UsabillaAssignment
//
//  Created by Kaan Baris BAYRAK on 22.04.2019.
//  Copyright © 2019 Kaan Baris Bayrak. All rights reserved.
//
//

import Foundation
import CoreData


extension FeedbackItemEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FeedbackItemEntity> {
        return NSFetchRequest<FeedbackItemEntity>(entityName: "FeedbackItemEntity")
    }

    @NSManaged public var createdAt: Int32
    @NSManaged public var id: String?
    @NSManaged public var labels: [String]?
    @NSManaged public var rating: Int32
    @NSManaged public var browser: BrowserEntity?
    @NSManaged public var geo: GeoLocationEntity?

}
