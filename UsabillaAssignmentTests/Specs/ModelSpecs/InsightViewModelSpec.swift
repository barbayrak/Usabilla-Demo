//
//  InsightViewModelSpec.swift
//  UsabillaAssignmentTests
//
//  Created by Kaan Baris BAYRAK on 22.04.2019.
//  Copyright © 2019 Kaan Baris Bayrak. All rights reserved.
//

import XCTest
import Quick
import Nimble
@testable import UsabillaAssignment

class InsightViewModelSpec: QuickSpec {
    
    override func spec() {
        
        var insightViewModel : InsightViewModel!
        
        beforeEach {
            let geoLocation = GeoLocation(latitude: 1.0, longtitude: 2.0, countryCode: "NL", city: "Amsterdam")
            let browser = Browser(name: "Chrome", version: "1.0", platform: "iOS")
            let feedbackItem = FeedbackItem(id: "1", browser: browser, geo: geoLocation, rating: 5, labels: ["exampleLabel"], createdAt: 1391445344)
            insightViewModel = InsightViewModel(items: [feedbackItem], targetAnalysis: TargetAnalysis.BrowserHighRatingAnalysis)
        }
        
        describe("Insight View Model") {
            it("is not nil") {
                expect(insightViewModel).notTo(beNil())
            }
        }

        describe("Insight View Model") {
            it("variables are valid") {
                expect(insightViewModel.colorHex).to(equal("#00B21F"))
                expect(insightViewModel.titleString).to(equal("Browser"))
                expect(insightViewModel.descriptionString).notTo(equal(""))
                expect(insightViewModel.iconName).to(equal("thumbsUp"))
            }
        }
        
    }
    
}
