//
//  FeedbackService.swift
//  UsabillaAssignment
//
//  Created by Kaan Baris BAYRAK on 15.04.2019.
//  Copyright © 2019 Kaan Baris Bayrak. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class FeedbackService : NSObject {
    
    static let shared = FeedbackService()
    let persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func fetchAndSyncFeedbacks(completion : @escaping ([FeedbackItem]?,Error?) -> ()){
        let targetUrlString = "http://cache.usabilla.com/example/apidemo.json"
        guard let url = URL(string: targetUrlString) else { return }
        
        //Normally URLSession caches the data locally(url cacheing key-value) so it simulates offline data but i am using Core Data to support it so i wrote a config for session inorder to disable url cache
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        let session = URLSession.init(configuration: config)
        
        session.dataTask(with: url) { (data, response, error) in
            if let err = error {
                let result = self.getDataFromLocalDatabase()
                completion(result,err)
                return
            }
            
            do{
                let feedbacks = try JSONDecoder().decode(Feedback.self, from: data!)
                DispatchQueue.main.async {
                    self.updateLocalDatabase(items: feedbacks.items)
                    print("Syncing Local Database Finished")
                    let result = self.getDataFromLocalDatabase()
                    completion(result,nil)
                }
            }catch let parseError {
                let result = self.getDataFromLocalDatabase()
                completion(result,parseError)
            }
        }.resume()
    }
    
    func updateLocalDatabase(items: [FeedbackItem]){
        print("Updating Local Database")
        managedObjectContext.performAndWait {
            for item in items {
                _ = FeedbackItemEntity.getOrCreate(item: item, context: self.managedObjectContext)
                do {
                    try self.managedObjectContext.save()
                }catch let error {
                    print("Core Data Error : ",error)
                }
            }
            print("Local Database Updated")
        }
    }
    
    func getDataFromLocalDatabase() -> [FeedbackItem]{
        print("Local Data Fetching Started")
        let request: NSFetchRequest<FeedbackItemEntity> = NSFetchRequest<FeedbackItemEntity>(entityName:"FeedbackItemEntity")
        request.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending:false)]
        
        do {
            let fetchedObjects = try self.managedObjectContext.fetch(request)
            print("Local Data Fetched With Count -> " , fetchedObjects.count)
            return fetchedObjects.map({ return $0.getObjectFromEntity() })
        } catch let error{
            print("Core Data fetch error : ", error)
            return [FeedbackItem]()
        }
    }
    
}
