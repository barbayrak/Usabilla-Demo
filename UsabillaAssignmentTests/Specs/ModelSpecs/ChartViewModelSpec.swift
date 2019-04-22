//
//  ChartViewModelSpec.swift
//  UsabillaAssignmentTests
//
//  Created by Kaan Baris BAYRAK on 22.04.2019.
//  Copyright © 2019 Kaan Baris Bayrak. All rights reserved.
//

import XCTest
import Quick
import Nimble
@testable import UsabillaAssignment

class ChartViewModelSpec: QuickSpec {

    override func spec() {
        
        var chartViewModel : ChartViewModel!
        
        beforeEach {
            let geoLocation = GeoLocation(latitude: 1.0, longtitude: 2.0, countryCode: "NL", city: "Amsterdam")
            let browser = Browser(name: "Chrome", version: "1.0", platform: "iOS")
            let feedbackItem = FeedbackItem(id: "1", browser: browser, geo: geoLocation, rating: 5, labels: ["exampleLabel"], createdAt: 1391445344)
            chartViewModel = ChartViewModel(items: [feedbackItem], kpi: KPI.Browser, defaultChartType: ChartType.Bar)
        }
        
        describe("Chart View Model") {
            it("is not nil") {
                expect(chartViewModel).notTo(beNil())
            }
        }
        
        describe("Chart View Model") {
            it("variables are valid") {
                expect(chartViewModel.chartType).to(equal(ChartType.Bar))
                expect(chartViewModel.titleString).to(equal("Browsers"))
                expect(chartViewModel.groupedData.count).to(equal(1))
            }
        }
        
    }

}
