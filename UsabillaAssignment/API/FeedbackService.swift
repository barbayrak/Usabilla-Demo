//
//  FeedbackService.swift
//  UsabillaAssignment
//
//  Created by Kaan Baris BAYRAK on 15.04.2019.
//  Copyright © 2019 Kaan Baris Bayrak. All rights reserved.
//

import Foundation

class FeedbackService : NSObject {
    
    static let shared = FeedbackService()
    
    func fetchFeedbacks(completion: @escaping (Result<Feedback,Error>) -> ()){
        let targetUrlString = "http://cache.usabilla.com/example/apidemo.json"
        guard let url = URL(string: targetUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let err = error {
                completion(.failure(err))
                return
            }
            
            do{
                let feedbacks = try JSONDecoder().decode(Feedback.self, from: data!)
                completion(.success(feedbacks))
            }catch let resultJsonError {
                completion(.failure(resultJsonError))
            }
        }.resume()
    }
}
