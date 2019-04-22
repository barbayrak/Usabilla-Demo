//
//  FeedbackItemEntity+CoreDataClass.swift
//  UsabillaAssignment
//
//  Created by Kaan Baris BAYRAK on 21.04.2019.
//  Copyright © 2019 Kaan Baris Bayrak. All rights reserved.
//
//

import Foundation
import CoreData

//Auto Generated From Model.xcdatamodeld
@objc(FeedbackItemEntity)
public class FeedbackItemEntity: NSManagedObject {

    class func getOrCreate(item : FeedbackItem , context : NSManagedObjectContext) -> FeedbackItemEntity {
        
        let request: NSFetchRequest<FeedbackItemEntity> = FeedbackItemEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", item.id)
        
        do {
            let matchedFeedbacks = try context.fetch(request)
            if matchedFeedbacks.count > 0 {
                 return matchedFeedbacks[0]
            }
        } catch let error{
            print(error)
        }
        
        let feedback = FeedbackItemEntity(context: context)
        feedback.createdAt =  Int32(item.createdAt)
        feedback.id = item.id
        feedback.rating = Int32(item.rating)
        feedback.labels = item.labels
        feedback.browser = BrowserEntity.getOrCreate(item : item ,context: context)
        feedback.geo = GeoLocationEntity.getOrCreate(item : item ,context: context)
        return feedback
    }
    
    func getObjectFromEntity() -> FeedbackItem{
        return FeedbackItem(id: self.id!, browser: self.browser!.getObjectFromEntity(), geo: self.geo!.getObjectFromEntity(), rating: Int(self.rating), labels: self.labels!, createdAt: Int(self.createdAt))
    }
    
}
