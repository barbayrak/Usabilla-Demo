//
//  DashboardFilterUITests.swift
//  UsabillaAssignmentUITests
//
//  Created by Kaan Baris BAYRAK on 22.04.2019.
//  Copyright © 2019 Kaan Baris Bayrak. All rights reserved.
//

import XCTest

class DashboardFilterUITests: XCTestCase {

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
    
    func testFilterNavigateBackAndForth(){
        let app = XCUIApplication()
        app.navigationBars["Dashboard"].children(matching: .button).element(boundBy: 1).tap()
        app.buttons["back"].tap()
        XCTAssertTrue(app.navigationBars["Dashboard"].exists)
    }
    
    func testFilterClear(){
        let app = XCUIApplication()
        app.navigationBars["Dashboard"].children(matching: .button).element(boundBy: 1).tap()
        app/*@START_MENU_TOKEN@*/.segmentedControls/*[[".scrollViews.segmentedControls",".segmentedControls"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.buttons["3+"].tap()
        app.buttons["Clear"].tap()
        XCTAssertTrue(app.segmentedControls.buttons.element(boundBy: 0).isSelected)
    }
    
    func testFilter(){
        let app = XCUIApplication()
        app.navigationBars["Dashboard"].children(matching: .button).element(boundBy: 1).tap()
        
        let startTimeTextField = app/*@START_MENU_TOKEN@*/.textFields["Start Time"]/*[[".scrollViews.textFields[\"Start Time\"]",".textFields[\"Start Time\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        startTimeTextField.tap()
        
        let datePickersQuery = app.datePickers
        datePickersQuery.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "January")
        datePickersQuery.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "22")
        datePickersQuery.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: "2014")
        
        let endTimeTextField = app/*@START_MENU_TOKEN@*/.textFields["End Time"]/*[[".scrollViews.textFields[\"End Time\"]",".textFields[\"End Time\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        endTimeTextField.tap()
        
        let datePickersQuery2 = app.datePickers
        datePickersQuery2.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "January")
        datePickersQuery2.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "23")
        datePickersQuery2.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: "2014")
        
        app/*@START_MENU_TOKEN@*/.segmentedControls/*[[".scrollViews.segmentedControls",".segmentedControls"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.buttons["3+"].tap()
        app/*@START_MENU_TOKEN@*/.buttons["Complete"]/*[[".scrollViews.buttons[\"Complete\"]",".buttons[\"Complete\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }

}
