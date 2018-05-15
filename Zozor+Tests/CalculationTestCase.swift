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
    
    func testGivenNumberEquals1_WhenAdd1_ThenResultIs2() {
        calculation.addNewNumber(1)
        calculation.addMathematicalOperator(mathematicalOperator: "+")
        calculation.addNewNumber(1)
        let result = calculation.result
        
        XCTAssertEqual(result, "2.0")
    }
    
    func testGivenNumberEquals2_WhenSubtract1_ThenResultIs1() {
        calculation.addNewNumber(2)
        calculation.addMathematicalOperator(mathematicalOperator: "-")
        calculation.addNewNumber(1)
        let result = calculation.result
        
        XCTAssertEqual(result, "1.0")
    }
    
    func testGivenNumberEquals5_WhenMultiplyBy3_ThenResultIs15() {
        calculation.addNewNumber(5)
        calculation.addMathematicalOperator(mathematicalOperator: "x")
        calculation.addNewNumber(3)
        let result = calculation.result
        
        XCTAssertEqual(result, "15.0")
    }
    
    func testGivenNumberEquals20_WhenDivideBy4_ThenResultIs5() {
        calculation.addNewNumber(20)
        calculation.addMathematicalOperator(mathematicalOperator: "/")
        calculation.addNewNumber(4)
        let result = calculation.result
        
        XCTAssertEqual(result, "5.0")
    }
    
    func testGivenNumberEquals12_WhenDivideBy0_ThenResultIsError() {
        calculation.addNewNumber(12)
        calculation.addMathematicalOperator(mathematicalOperator: "/")
        calculation.addNewNumber(0)
        let result = calculation.result
        
        XCTAssertEqual(result, "Error")
    }
    
    func testGivenNoTappedNumber_WhenPressEqualBtn_ThenExpressionIsNotCorrect() {
        calculation.stringNumbers = [""]
        
        XCTAssertEqual(calculation.isExpressionCorrect, false)
    }
    
    func testGivenTappedFisrtNumber_WhenDontTapSecondNumberAndPressEqualBtn_ThenExpressionIsNotCorrect() {
        calculation.stringNumbers = ["1", ""]
        
        XCTAssertEqual(calculation.isExpressionCorrect, false)
    }
    
    func testGivenTappedNumber_WhenCallisExpressionCorrect_ThenExpressionIsCorrect() {
        calculation.stringNumbers = ["2"]
        
        XCTAssertEqual(calculation.isExpressionCorrect, true)
    }
    
    func testGivenNoTappedNumber_WhenDontTapNumber_ThenCannotAddOperator() {
        calculation.stringNumbers = [""]
        
        XCTAssertEqual(calculation.canAddOperator, false)
    }
    
    func testGivenNoTappedNumber_WhenTapNumber_ThenCanAddOperator() {
        calculation.stringNumbers = ["", "1"]
        
        XCTAssertEqual(calculation.canAddOperator, true)
    }
    
    func testGivenNumberIs2AndOperatorIsMinus_WhenCallresetNumbersAndOperators_ThenstringNumbersIsEmptyAndmathematicalOperatorsIsPlus() {
        calculation.stringNumbers = ["2"]
        calculation.mathematicalOperators = ["-"]
        
        calculation.resetNumbersAndOperators()
        
        XCTAssertEqual(calculation.stringNumbers, [""])
        XCTAssertEqual(calculation.mathematicalOperators, ["+"])
    }
}
