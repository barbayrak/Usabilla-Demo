//
//  DashboardUITests.swift
//  UsabillaAssignmentUITests
//
//  Created by Kaan Baris BAYRAK on 22.04.2019.
//  Copyright © 2019 Kaan Baris Bayrak. All rights reserved.
//

import XCTest

class DashboardUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testScrolling(){
        let app = XCUIApplication()
        let collectionViewsQuery = app.collectionViews
        for _ in 1...5 {
            collectionViewsQuery.element.swipeUp()
        }
        for _ in 1...5 {
            collectionViewsQuery.element.swipeDown()
        }
        XCTAssertTrue(collectionViewsQuery.children(matching: .cell).element(boundBy: 0).exists)
    }
    
    func testChartTypeSwitch(){
        let app = XCUIApplication()
        let collectionViewsQuery = app.collectionViews
        let cell = collectionViewsQuery.children(matching: .cell).element(boundBy: 0)
        cell/*@START_MENU_TOKEN@*/.buttons["barChart"]/*[[".segmentedControls.buttons[\"barChart\"]",".buttons[\"barChart\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        cell/*@START_MENU_TOKEN@*/.buttons["horizontalBarChart"]/*[[".segmentedControls.buttons[\"horizontalBarChart\"]",".buttons[\"horizontalBarChart\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        cell/*@START_MENU_TOKEN@*/.buttons["pieChart"]/*[[".segmentedControls.buttons[\"pieChart\"]",".buttons[\"pieChart\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCTAssertTrue(cell.segmentedControls.buttons.element(boundBy: 0).isSelected)
        
        let cell2 = collectionViewsQuery.children(matching: .cell).element(boundBy: 1)
        cell2.buttons["pieChart"].tap()
        cell2.buttons["horizontalBarChart"].tap()
        cell2/*@START_MENU_TOKEN@*/.buttons["barChart"]/*[[".segmentedControls.buttons[\"barChart\"]",".buttons[\"barChart\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCTAssertTrue(cell2.segmentedControls.buttons.element(boundBy: 1).isSelected)
    }
    
    func testMoveItem(){
        let app = XCUIApplication()
        let collectionViewsQuery = app.collectionViews
        let cell = collectionViewsQuery.children(matching: .cell).element(boundBy: 0)
        let cell2 = collectionViewsQuery.children(matching: .cell).element(boundBy: 1)
        
        cell.buttons["pieChart"].tap()
        cell2.buttons["barChart"].tap()
        
        XCTAssertTrue(cell.segmentedControls.buttons.element(boundBy: 0).isSelected)
        XCTAssertTrue(cell2.segmentedControls.buttons.element(boundBy: 1).isSelected)
        
        let startPoint = cell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        let finishPoint = cell2.coordinate(withNormalizedOffset: CGVector(dx: 0.7, dy: 0))
        
        startPoint.press(forDuration: 3, thenDragTo: finishPoint)
        
        let newCell = collectionViewsQuery.children(matching: .cell).element(boundBy: 0)
        let newCell2 = collectionViewsQuery.children(matching: .cell).element(boundBy: 1)
        
        XCTAssertTrue(newCell.segmentedControls.buttons.element(boundBy: 1).isSelected)
        XCTAssertTrue(newCell2.segmentedControls.buttons.element(boundBy: 0).isSelected)
    }

}
