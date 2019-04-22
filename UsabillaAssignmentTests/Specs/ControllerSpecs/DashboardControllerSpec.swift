//
//  DashboardControllerSpec.swift
//  UsabillaAssignmentTests
//
//  Created by Kaan Baris BAYRAK on 22.04.2019.
//  Copyright © 2019 Kaan Baris Bayrak. All rights reserved.
//

import XCTest
import Quick
import Nimble
@testable import UsabillaAssignment

class DashboardControllerSpec: QuickSpec {

    override func spec() {
        
        var dashboardController : DashboardController!
        
        beforeEach {
            dashboardController = (UIStoryboard(name: "Dashboard", bundle: nil).instantiateViewController(withIdentifier: "DashboardId") as! DashboardController)
            
            // Actually waits for view to initialize
            _ = dashboardController.view
        }
        
        context("Dashboard Controller") {
            it("should have loaded charts") {
                expect(dashboardController.dashboardCollectionView.numberOfItems(inSection: 0)).toEventually(equal(5))
            }
        }
        
    }

}
