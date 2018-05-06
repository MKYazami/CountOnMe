//
//  Zozor_Tests.swift
//  CountOnMeTests
//
//  Created by Ambroise COLLON on 30/08/2016.
//  Copyright © 2016 Ambroise Collon. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CalculationTestCase: XCTestCase {
    var calculation: Calculation!
    
    override func setUp() {
        super.setUp()
        calculation = Calculation()
    }
    
    func testGivenNumerEquals1_WhenAdd1_TheResultIs2() {
        let result = calculation.performCalculation(stringNumbers: ["1", "1"], mathematicalOperators: ["+", "+"])
        
        XCTAssertEqual(result, "2.0")
    }
    
    func testGivenNumerEquals2_WhenSubtract1_TheResultIs1() {
        let result = calculation.performCalculation(stringNumbers: ["2", "1"], mathematicalOperators: ["+", "-"])
        
        XCTAssertEqual(result, "1.0")
    }
    
    func testGivenNumerEquals5_WhenMultiplyBy3_TheResultIs15() {
        let result = calculation.performCalculation(stringNumbers: ["5", "3"], mathematicalOperators: ["+", "x"])
        
        XCTAssertEqual(result, "15.0")
    }
    
    func testGivenNumerEquals20_WhenDivideBy4_TheResultIs5() {
        let result = calculation.performCalculation(stringNumbers: ["20", "4"], mathematicalOperators: ["+", "/"])
        
        XCTAssertEqual(result, "5.0")
    }
    
    func testGivenNumerEquals12_WhenDivideBy0_TheResultIsError() {
        let result = calculation.performCalculation(stringNumbers: ["12", "0"], mathematicalOperators: ["+", "/"])
        
        XCTAssertEqual(result, "Error")
    }
}
