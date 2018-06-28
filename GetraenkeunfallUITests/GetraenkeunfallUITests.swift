//
//  GetraenkeunfallUITests.swift
//  GetraenkeunfallUITests
//
//  Created by Alexander Karrer on 10.06.18.
//  Copyright © 2018 Alexander Karrer. All rights reserved.
//

import XCTest

class GetraenkeunfallUITests: XCTestCase {
    var app: XCUIApplication!
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testStartGame() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        let neuesSpielButton = app.buttons["NEUES SPIEL"]
        neuesSpielButton.tap()
        app.buttons["ZURÜCK"].tap()
        neuesSpielButton.tap()
        
        let tablesQuery = app.tables
        
        tablesQuery/*@START_MENU_TOKEN@*/.textFields["Spieler 1"]/*[[".cells.textFields[\"Spieler 1\"]",".textFields[\"Spieler 1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery.textFields["Spieler 1"].typeText("Test 1")
        
        let spieler2TextField = tablesQuery/*@START_MENU_TOKEN@*/.textFields["Spieler 2"]/*[[".cells.textFields[\"Spieler 2\"]",".textFields[\"Spieler 2\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        spieler2TextField.tap()
        spieler2TextField.typeText("Test 2")
        
        let spieler3TextField = tablesQuery/*@START_MENU_TOKEN@*/.textFields["Spieler 3"]/*[[".cells.textFields[\"Spieler 3\"]",".textFields[\"Spieler 3\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        spieler3TextField.tap()
        spieler3TextField.typeText("Test 3")
        
        let window = app.children(matching: .window).element(boundBy: 0)
        window.children(matching: .other).element(boundBy: 2).children(matching: .other).element.children(matching: .table).element.tap()
        
        let weiterButton = app.buttons["WEITER"]
        weiterButton.tap()
        app.buttons["CHILLIG"].tap()
        
        let button = app.buttons["Button"]
        button.tap()
        button.tap()
        
        let changeplaymodeButton = app.buttons["changePlayMode"]
        changeplaymodeButton.tap()
        app.buttons["NORMAL"].tap()
        changeplaymodeButton.tap()
        app.buttons["GETRÄNKEUNFALL"].tap()
        app.buttons["addPlayers"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["plus"]/*[[".cells.buttons[\"plus\"]",".buttons[\"plus\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.textFields["Spieler 4"]/*[[".cells.textFields[\"Spieler 4\"]",".textFields[\"Spieler 4\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery.textFields["Spieler 4"].typeText("Test 4")
        window.children(matching: .other).element(boundBy: 9).children(matching: .other).element.children(matching: .table).element.tap()
        weiterButton.tap()
        app.buttons["quit"].tap()
        
    }
    
}
