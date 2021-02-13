//
//  CatFactsUITests.swift
//  CatFactsUITests
//
//  Created by Jhennyfer Rodrigues de Oliveira on 05/02/21.
//

import XCTest
import CatFacts




class CatFactsUITests: XCTestCase {
   
    

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let tabBar = app.tabBars["Tab Bar"]
        
        let image = app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .image).element(boundBy: 1)
        image.tap()
        image/*@START_MENU_TOKEN@*/.swipeLeft()/*[[".swipeUp()",".swipeLeft()"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        
        let heartemptyButton = app.collectionViews/*@START_MENU_TOKEN@*/.buttons["heartEmpty"]/*[[".cells.buttons[\"heartEmpty\"]",".buttons[\"heartEmpty\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        heartemptyButton.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["New fact"]/*[[".buttons[\"New fact\"].staticTexts[\"New fact\"]",".staticTexts[\"New fact\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let favoriteButton = tabBar.buttons["Favorite"]
        favoriteButton.tap()
        
        let catFactsButton = tabBar.buttons["Cat Facts"]
        catFactsButton.tap()
        heartemptyButton.tap()
        favoriteButton.tap()
        catFactsButton.tap()
        tabBar.buttons["Favorite"].tap()
        tabBar.buttons["Cat Facts"].tap()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
