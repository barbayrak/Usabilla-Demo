//
//  InsightViewModel.swift
//  UsabillaAssignment
//
//  Created by Kaan Baris BAYRAK on 18.04.2019.
//  Copyright © 2019 Kaan Baris Bayrak. All rights reserved.
//

import Foundation

class InsightViewModel : NSObject {
    
    var titleString : String = ""
    var descriptionString : String = ""
    var iconName : String = ""
    var colorHex : String = "#"
    
    init(items : [FeedbackItem] , targetAnalysis : TargetAnalysis){
        super.init()
        
        switch targetAnalysis {
        case .RatingPrediction:
            predictRating(feedbacks : items)
        case .BrowserHighRatingAnalysis:
            analyzeBrowserHighRating(feedbacks : items)
        case .BrowserLowRatingAnalysis:
            analyzeBrowserLowRating(feedbacks : items)
        case .LocationHighRatingAnalysis:
            analyzeLocationHighRating(feedbacks: items)
        case .LocationLowRatingAnalysis:
            analyzeLocationLowRating(feedbacks: items)
        case .PlatformHighRatingAnalysis:
            analyzePlatformHighRating(feedbacks: items)
        case .PlatformLowRatingAnalysis:
            analyzePlatformLowRating(feedbacks: items)
        }
    }
    
    func predictRating(feedbacks : [FeedbackItem]){
        
        let maxTimeItem = feedbacks.max(by: { $0.createdAt > $1.createdAt })
        let maxDate = maxTimeItem?.createdAt
        let predictTime = maxDate! + 87000 // Adding +~1 day(87000 * 1000 miliseconds) to last date to predict tomorrow's rating prediction
        
        let model = ratingPredictor()
        if let nextRatingPrediction = try? model.prediction(input: ratingPredictorInput(createdAt: Double(predictTime))) {
            let predictedRating = Double(nextRatingPrediction.rating)
            let maxTimeRating = Double(maxTimeItem!.rating)
            if(predictedRating > maxTimeRating) {
                //Ratings will go up
                self.titleString = "Ratings will rise!"
                self.descriptionString = "Congrats! Keep up the good work.Your ratings will probably go up!"
                self.iconName = "goesUp"
                self.colorHex = "#FFAE1B"
            }else{
                //Rating will go down
                self.titleString = "Care about your feedbacks!"
                self.descriptionString = "Be careful about your ratings.Your ratings will probably go down"
                self.iconName = "goesDown"
                self.colorHex = "#E84919"
            }
        }
        
    }
    
    func analyzeBrowserHighRating(feedbacks : [FeedbackItem]){
        let browserData = Dictionary(grouping: feedbacks, by: { $0.browser.name })
        let maxAverageBrowser = browserData.max { (b1, b2) -> Bool in
            return average(array: b1.value.map({ return $0.rating })) < average(array: b2.value.map({ return $0.rating }))
        }
        let averageRatingOnMax = average(array: (maxAverageBrowser?.value.map({ return $0.rating }) ?? [0]))
        self.titleString = "Browser"
        self.descriptionString = "\(maxAverageBrowser?.key ?? "") is the browser with highest rating on average \(averageRatingOnMax.clean)"
        self.iconName = "thumbsUp"
        self.colorHex = "#00B21F"
    }
    
    func analyzeBrowserLowRating(feedbacks : [FeedbackItem]){
        let browserData = Dictionary(grouping: feedbacks, by: { $0.browser.name })
        let minAverageBrowser = browserData.min { (b1, b2) -> Bool in
            return average(array: b1.value.map({ return $0.rating })) < average(array: b2.value.map({ return $0.rating }))
        }
        let averageRatingOnMin = average(array: (minAverageBrowser?.value.map({ return $0.rating }) ?? [0]))
        self.titleString = "Browser"
        self.descriptionString = "\(minAverageBrowser?.key ?? "") is the browser with lowest rating on average \(averageRatingOnMin.clean)"
        self.iconName = "thumbsDown"
        self.colorHex = "#B20022"
    }
    
    func analyzeLocationHighRating(feedbacks : [FeedbackItem]){
        let locationData = Dictionary(grouping: feedbacks, by: { $0.geo.countryCode })
        let maxAverageLocation = locationData.max { (b1, b2) -> Bool in
            return average(array: b1.value.map({ return $0.rating })) < average(array: b2.value.map({ return $0.rating }))
        }
        let averageRatingOnMax = average(array: (maxAverageLocation?.value.map({ return $0.rating }) ?? [0]))
        self.titleString = "Location"
        self.descriptionString = "\(maxAverageLocation?.key ?? "") is the country with highest rating on average \(averageRatingOnMax.clean)"
        self.iconName = "thumbsUp"
        self.colorHex = "#00B21F"
    }
    
    func analyzeLocationLowRating(feedbacks : [FeedbackItem]){
        let locationData = Dictionary(grouping: feedbacks, by: { $0.geo.countryCode })
        let minAverageLocation = locationData.min { (b1, b2) -> Bool in
            return average(array: b1.value.map({ return $0.rating })) < average(array: b2.value.map({ return $0.rating }))
        }
        let averageRatingOnMin = average(array: (minAverageLocation?.value.map({ return $0.rating }) ?? [0]))
        self.titleString = "Location"
        self.descriptionString = "\(minAverageLocation?.key ?? "") is the country with lowest rating on average \(averageRatingOnMin.clean)"
        self.iconName = "thumbsDown"
        self.colorHex = "#B20022"
    }
    
    func analyzePlatformHighRating(feedbacks : [FeedbackItem]){
        let platformData = Dictionary(grouping: feedbacks, by: { $0.browser.platform })
        let maxAveragePlatform = platformData.max { (b1, b2) -> Bool in
            return average(array: b1.value.map({ return $0.rating })) < average(array: b2.value.map({ return $0.rating }))
        }
        let averageRatingOnMax = average(array: (maxAveragePlatform?.value.map({ return $0.rating }) ?? [0]))
        self.titleString = "Platform"
        self.descriptionString = "\(maxAveragePlatform?.key ?? "") is the platform with highest rating on average \(averageRatingOnMax.clean)"
        self.iconName = "thumbsUp"
        self.colorHex = "#00B21F"
    }
    
    func analyzePlatformLowRating(feedbacks : [FeedbackItem]){
        let platformData = Dictionary(grouping: feedbacks, by: { $0.browser.platform })
        let minAveragePlatform = platformData.min { (b1, b2) -> Bool in
            return average(array: b1.value.map({ return $0.rating })) < average(array: b2.value.map({ return $0.rating }))
        }
        let averageRatingOnMin = average(array: (minAveragePlatform?.value.map({ return $0.rating }) ?? [0]))
        self.titleString = "Platform"
        self.descriptionString = "\(minAveragePlatform?.key ?? "") is the platform with lowest rating on average \(averageRatingOnMin.clean)"
        self.iconName = "thumbsDown"
        self.colorHex = "#B20022"
    }
    
    func average(array: [Int])-> Double {
        var total = 0
        for number in array {
            total += number
        }
        return Double(total)/Double(array.count)
    }
}
