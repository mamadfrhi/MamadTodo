//
//  MamadTodoUITests.swift
//  MamadTodoUITests
//
//  Created by iMamad on 04.08.22.
//

import XCTest

/**
 Please press command + k on the simulator before running
 the tests below.
 **/

class MamadTodoUITests: XCTestCase {
    
    override class func setUp() {
        XCUIApplication().launch()
    }
    
    func testWarningOnEmptyAddPage() {
        let app = XCUIApplication()
        app.navigationBars["To Do List"].buttons["Add"].tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Save"]/*[[".buttons[\"Save\"].staticTexts[\"Save\"]",".staticTexts[\"Save\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let warningAlert = app.alerts["Warning"]
        XCTAssertTrue(warningAlert.exists)
    }
    
    // Test below uses viretual keyboard on simulator
    // don't forget to toggle the virtual keybaord
    // shortcut ctrl + k
    func testFilledAddPage() {
        // given
        let app = XCUIApplication()
        app.navigationBars["To Do List"].buttons["Add"].tap()
        var mainPageViewExist = app.navigationBars["To Do List"].exists
        XCTAssertTrue(mainPageViewExist)
        
        app.textFields["Title"].tap()
        // write in titleTextField
        let AKey = app.keys["A"]
        let spaceKey = app.keys["space"]
        let BKey = app.keys["B"]
        let aKey = app.keys["a"]
        AKey.tap()
        spaceKey.tap()
        BKey.tap()
        aKey.tap()
        
        // write in descriptionTextView
        app.textViews["descriptionTextView"].tap()
        AKey.tap()
        aKey.tap()
        
        // when
        app/*@START_MENU_TOKEN@*/.staticTexts["Save"]/*[[".buttons[\"Save\"].staticTexts[\"Save\"]",".staticTexts[\"Save\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        // then
        mainPageViewExist = app.navigationBars["To Do List"].exists
        XCTAssertTrue(mainPageViewExist)
    }
    
    // MARK: DetailPage Tests
    func testDetailsPage() {
        // given - SUT
        let app = XCUIApplication()
        let firstCell = app.tables["tableView"].cells.element(boundBy: 0)
        
        // when
        firstCell.tap()
        
        // then
        var detailsTextView = app.textViews["detailsTextView"]
        XCTAssertNotNil(detailsTextView.value)
        XCTAssertTrue(detailsTextView.exists)
        
        // when
        detailsTextView.swipeDown()
        detailsTextView = app.textViews["detailsTextView"]
        XCTAssertFalse(detailsTextView.exists)
        
    }
}
