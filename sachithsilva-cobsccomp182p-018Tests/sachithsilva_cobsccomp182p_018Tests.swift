//
//  sachithsilva_cobsccomp182p_018Tests.swift
//  sachithsilva-cobsccomp182p-018Tests
//
//  Created by Sachith Silvaon 2/8/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import XCTest
@testable import sachithsilva_cobsccomp182p_018

class sachithsilva_cobsccomp182p_018Tests: XCTestCase {


    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        
    }

    func testLogin() {
        let value = true
        FirebaseManager.login(email: "g@gmail.com",password: "nibm@123"){
            (success:Bool) in
            print("ffff",success)
            XCTAssertEqual(success, value)
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

