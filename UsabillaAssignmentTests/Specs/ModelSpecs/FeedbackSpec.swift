//
//  FeedbackSpec.swift
//  UsabillaAssignmentTests
//
//  Created by Kaan Baris BAYRAK on 22.04.2019.
//  Copyright © 2019 Kaan Baris Bayrak. All rights reserved.
//

import XCTest
import Quick
import Nimble
@testable import UsabillaAssignment

class FeedbackSpec: QuickSpec {

    override func spec() {
        
        var feedback : Feedback!
        var feedbackItem : FeedbackItem!
        var browser : Browser!
        var geoLocation : GeoLocation!
        
        beforeEach {
            geoLocation = GeoLocation(latitude: 1.0, longtitude: 2.0, countryCode: "NL", city: "Amsterdam")
            browser = Browser(name: "Chrome", version: "1.0", platform: "iOS")
            feedbackItem = FeedbackItem(id: "1", browser: browser, geo: geoLocation, rating: 5, labels: ["exampleLabel"], createdAt: 1391445344)
            feedback = Feedback(items: [feedbackItem])
        }
        
        describe("Feedback Model") {
            
            it("is not nil") {
                expect(feedback).notTo(beNil())
                expect(feedback.items).notTo(beNil())
            }
            
            it("has one item") {
                expect(feedback.items.count).to(equal(1))
            }
    
        }
        
        describe("FeedbackItem Model") {
            it("is not nil"){
                expect(feedbackItem).notTo(beNil())
            }
            
            it("variables are valid"){
                expect(feedbackItem.browser).notTo(beNil())
                expect(feedbackItem.geo).notTo(beNil())
                expect(feedbackItem.id).to(equal("1"))
                expect(feedbackItem.rating).to(equal(5))
                expect(feedbackItem.labels).to(equal(["exampleLabel"]))
            }
        }
        
        describe("Browser Model") {
            it("is not nil"){
                expect(browser).notTo(beNil())
            }
            
            it("variables are valid"){
                expect(browser.name).to(equal("Chrome"))
                expect(browser.version).to(equal("1.0"))
                expect(browser.platform).to(equal("iOS"))
            }
        }
        
        describe("GeoLocation Model") {
            it("is not nil"){
                expect(geoLocation).notTo(beNil())
            }
            
            it("variables are valid"){
                expect(geoLocation.city).to(equal("Amsterdam"))
                expect(geoLocation.countryCode).to(equal("NL"))
                expect(geoLocation.latitude).to(equal(1.0))
                expect(geoLocation.longtitude).to(equal(2.0))
            }
        }
        
    }

}
