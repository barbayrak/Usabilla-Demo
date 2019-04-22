//
//  BrowserEntity+CoreDataClass.swift
//  UsabillaAssignment
//
//  Created by Kaan Baris BAYRAK on 21.04.2019.
//  Copyright © 2019 Kaan Baris Bayrak. All rights reserved.
//
//

import Foundation
import CoreData

//Auto Generated From Model.xcdatamodeld
@objc(BrowserEntity)
public class BrowserEntity: NSManagedObject {
    
    class func getOrCreate(item : FeedbackItem , context : NSManagedObjectContext) -> BrowserEntity {
        
        let request: NSFetchRequest<BrowserEntity> = BrowserEntity.fetchRequest()
        request.predicate = NSPredicate(format: "name = %@ AND platform = %@ AND version = %@", item.browser.name,item.browser.platform,item.browser.version)
        
        do {
            let matchedBrowsers = try context.fetch(request)
            if matchedBrowsers.count > 0 {
                return matchedBrowsers[0]
            }
        } catch let error{
            print(error)
        }
        
        let browser = BrowserEntity(context: context)
        browser.name = item.browser.name
        browser.platform = item.browser.platform
        browser.version = item.browser.version
        return browser
        
    }
    
    func getObjectFromEntity() -> Browser{
        return Browser(name: self.name!, version: self.version!, platform: self.platform!)
    }
    
}
