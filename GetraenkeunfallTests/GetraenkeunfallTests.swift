//
//  GetraenkeunfallTests.swift
//  GetraenkeunfallTests
//
//  Created by Alexander Karrer on 10.06.18.
//  Copyright © 2018 Alexander Karrer. All rights reserved.
//

import XCTest
@testable import Getraenkeunfall

class GetraenkeunfallTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testImportRules() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let hvc = HomeViewController()
        hvc.rules = Rules()s
        hvc.readRules()
        XCTAssertEqual(hvc.rules!.onePlayerGame.count, 15)
        XCTAssertEqual(hvc.rules!.rulesGeneral.count, 83)
        XCTAssertEqual(hvc.rules!.twoPlayerGame.count, 20)
        XCTAssertEqual(hvc.rules!.threePlayerGame.count, 7)
        XCTAssertEqual(hvc.rules!.onePlayerRuleGameRule.count, 10)
        XCTAssertEqual(hvc.rules!.onePlayerRuleGameResolve.count, 10)
        XCTAssertEqual(hvc.rules!.twoPlayerRuleGameRule.count, 3)
        XCTAssertEqual(hvc.rules!.twoPlayerRuleGameResolve.count, 3)
        XCTAssertEqual(hvc.rules!.threePlayerRuleGameRule.count, 1)
        XCTAssertEqual(hvc.rules!.threePlayerRuleGameResolve.count, 1)
    }
}
