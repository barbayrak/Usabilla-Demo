//
//  BrowserEntity+CoreDataProperties.swift
//  UsabillaAssignment
//
//  Created by Kaan Baris BAYRAK on 22.04.2019.
//  Copyright © 2019 Kaan Baris Bayrak. All rights reserved.
//
//

import Foundation
import CoreData


extension BrowserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BrowserEntity> {
        return NSFetchRequest<BrowserEntity>(entityName: "BrowserEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var platform: String?
    @NSManaged public var version: String?
    @NSManaged public var feedbacks: NSSet?

}

// MARK: Generated accessors for feedbacks
extension BrowserEntity {

    @objc(addFeedbacksObject:)
    @NSManaged public func addToFeedbacks(_ value: FeedbackItemEntity)

    @objc(removeFeedbacksObject:)
    @NSManaged public func removeFromFeedbacks(_ value: FeedbackItemEntity)

    @objc(addFeedbacks:)
    @NSManaged public func addToFeedbacks(_ values: NSSet)

    @objc(removeFeedbacks:)
    @NSManaged public func removeFromFeedbacks(_ values: NSSet)

}
