//
//  GeoLocationEntity+CoreDataProperties.swift
//  UsabillaAssignment
//
//  Created by Kaan Baris BAYRAK on 22.04.2019.
//  Copyright © 2019 Kaan Baris Bayrak. All rights reserved.
//
//

import Foundation
import CoreData


extension GeoLocationEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GeoLocationEntity> {
        return NSFetchRequest<GeoLocationEntity>(entityName: "GeoLocationEntity")
    }

    @NSManaged public var countryCode: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longtitude: Double
    @NSManaged public var feedbacks: NSSet?

}

// MARK: Generated accessors for feedbacks
extension GeoLocationEntity {

    @objc(addFeedbacksObject:)
    @NSManaged public func addToFeedbacks(_ value: FeedbackItemEntity)

    @objc(removeFeedbacksObject:)
    @NSManaged public func removeFromFeedbacks(_ value: FeedbackItemEntity)

    @objc(addFeedbacks:)
    @NSManaged public func addToFeedbacks(_ values: NSSet)

    @objc(removeFeedbacks:)
    @NSManaged public func removeFromFeedbacks(_ values: NSSet)

}
