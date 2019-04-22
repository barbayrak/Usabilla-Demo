//
//  InsightControllerSpec.swift
//  UsabillaAssignmentTests
//
//  Created by Kaan Baris BAYRAK on 22.04.2019.
//  Copyright © 2019 Kaan Baris Bayrak. All rights reserved.
//

import XCTest
import Quick
import Nimble
@testable import UsabillaAssignment

class InsightControllerSpec: QuickSpec {

    override func spec() {
        
        var insightController : InsightsController!
        
        beforeEach {
            insightController = (UIStoryboard(name: "Insight", bundle: nil).instantiateViewController(withIdentifier: "InsightId") as! InsightsController)
            let geoLocation = GeoLocation(latitude: 1.0, longtitude: 2.0, countryCode: "NL", city: "Amsterdam")
            let browser = Browser(name: "Chrome", version: "1.0", platform: "iOS")
            let feedbackItem = FeedbackItem(id: "1", browser: browser, geo: geoLocation, rating: 5, labels: ["exampleLabel"], createdAt: 1391445344)
            insightController.feedbacks = [feedbackItem]
            
            // Actually waits for view to initialize
            _ = insightController.view
        }
        
        context("Insight Controller") {
            it("should have loaded analyzes") {
                expect(insightController.insightCollectionView.numberOfItems(inSection: 0)).toEventually(equal(7))
            }
        }
        
    }

}
