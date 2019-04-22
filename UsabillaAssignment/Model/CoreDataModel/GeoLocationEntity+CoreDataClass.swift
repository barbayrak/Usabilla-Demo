//
//  GeoLocationEntity+CoreDataClass.swift
//  UsabillaAssignment
//
//  Created by Kaan Baris BAYRAK on 21.04.2019.
//  Copyright © 2019 Kaan Baris Bayrak. All rights reserved.
//
//

import Foundation
import CoreData

//Auto Generated From Model.xcdatamodeld
@objc(GeoLocationEntity)
public class GeoLocationEntity: NSManagedObject {
    
    class func getOrCreate(item : FeedbackItem , context : NSManagedObjectContext) -> GeoLocationEntity {
        
        let request: NSFetchRequest<GeoLocationEntity> = GeoLocationEntity.fetchRequest()
        request.predicate = NSPredicate(format: "latitude = %@ AND longtitude = %@", NSNumber(value: item.geo.latitude),NSNumber(value: item.geo.longtitude))
        
        do {
            let matchedGeos = try context.fetch(request)
            if matchedGeos.count > 0 {
                return matchedGeos[0]
            }
        } catch let error{
            print(error)
        }
        
        let geo = GeoLocationEntity(context: context)
        geo.latitude = item.geo.latitude
        geo.longtitude = item.geo.longtitude
        geo.countryCode = item.geo.countryCode
        return geo
        
    }
    
    func getObjectFromEntity() -> GeoLocation{
        return GeoLocation(latitude: self.latitude, longtitude: self.longtitude, countryCode: self.countryCode ?? "", city: "")
    }
    
}
