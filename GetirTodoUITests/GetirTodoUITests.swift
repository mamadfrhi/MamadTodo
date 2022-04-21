//
//  GetirTodoUITests.swift
//  GetirTodoUITests
//
//  Created by Umut Afacan on 21.12.2020.
//

import XCTest

class GetirTodoUITests: XCTestCase {
    
    private func testEmptyAddPage() {
        let app = XCUIApplication()
        app.navigationBars["To Do List"].buttons["Add"].tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Save"]/*[[".buttons[\"Save\"].staticTexts[\"Save\"]",".staticTexts[\"Save\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let alert = app.alerts["Warning"]
        XCTAssertTrue(alert.exists)
    }
    
    private func testFilledAddPage() {
        
        let app = XCUIApplication()
        app.navigationBars["To Do List"].buttons["Add"].tap()
        app.textFields["Title"].tap()
        var mainPageViewExist = app.navigationBars["To Do List"].exists
        XCTAssertFalse(mainPageViewExist)
        
        // write a in titleTextField
        let aKey = app/*@START_MENU_TOKEN@*/.keys["a"]/*[[".keyboards.keys[\"a\"]",".keys[\"a\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        aKey.tap()
        aKey.tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .textView).element.tap()
        
        // write B in descriptionTextView
        let bKey = app/*@START_MENU_TOKEN@*/.keys["B"]/*[[".keyboards.keys[\"B\"]",".keys[\"B\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        bKey.tap()
        bKey.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Save"]/*[[".buttons[\"Save\"].staticTexts[\"Save\"]",".staticTexts[\"Save\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        mainPageViewExist = app.navigationBars["To Do List"].exists
        XCTAssertTrue(mainPageViewExist)   
    }
}
