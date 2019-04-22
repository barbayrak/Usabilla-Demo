//
//  DashboardFilterControllerSpec.swift
//  UsabillaAssignmentTests
//
//  Created by Kaan Baris BAYRAK on 22.04.2019.
//  Copyright © 2019 Kaan Baris Bayrak. All rights reserved.
//

import XCTest
import Quick
import Nimble
@testable import UsabillaAssignment

class DashboardFilterControllerSpec: QuickSpec {

    override func spec() {
        
        var dashboardFilterController : DashboardFilterController!
        var minDate : Int!
        var maxDate : Int!
        var fromRating : Int!
 
        beforeEach {
            dashboardFilterController = (UIStoryboard(name: "Dashboard", bundle: nil).instantiateViewController(withIdentifier: "DashboardFilterId") as! DashboardFilterController)
            
            minDate = 1391445344
            maxDate = 1393445344
            fromRating = 3
            
            dashboardFilterController.minDate = minDate
            dashboardFilterController.maxDate = maxDate
            dashboardFilterController.fromRating = fromRating
            
            // Actually waits for view to initialize
            _ = dashboardFilterController.view
        }
        
        context("Dashboard Filter Controller") {
            it("variables are valid") {
                expect(dashboardFilterController.filterMinDate).to(equal(minDate))
                expect(dashboardFilterController.filterMaxDate).to(equal(maxDate))
                expect(dashboardFilterController.fromRating).to(equal(fromRating))
                expect(dashboardFilterController.ratingSegmented.selectedSegmentIndex).to(equal(2))
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMM d, yyyy"
                
                expect(dashboardFilterController.startDateTextField.text).to(equal(dateFormatter.string(from:  Date(timeIntervalSince1970: Double(minDate)))))
                expect(dashboardFilterController.endDateTextField.text).to(equal(dateFormatter.string(from:  Date(timeIntervalSince1970: Double(maxDate)))))
            }
        }
        
    }

}
