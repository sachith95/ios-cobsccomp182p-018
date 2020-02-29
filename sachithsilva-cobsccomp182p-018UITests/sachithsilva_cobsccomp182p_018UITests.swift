//
//  sachithsilva_cobsccomp182p_018UITests.swift
//  sachithsilva-cobsccomp182p-018UITests
//
//  Created by Sachith Silva on 2/8/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import XCTest

class sachithsilva_cobsccomp182p_018UITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //login test
    func testExample() {
        
        let app = XCUIApplication()
        app.textFields["Email address"].tap()
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
    
        app.buttons["Log In"].tap()

        
    }
    // create account test
    func testCreateAccount()  {
        
        let app = XCUIApplication()
        app.buttons["Create New NIBM Event Account"].tap()
        app.textFields["Email"].tap()
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()

        
        let communityUserNameTextField = app.textFields["Community/User Name"]
        communityUserNameTextField.tap()
 

        
        let contactNumberTextField = app.textFields["Contact Number"]
        contactNumberTextField.tap()
        app.buttons["Sign Up"].tap()
    }

}
