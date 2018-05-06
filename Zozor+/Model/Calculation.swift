//
//  Calculation.swift
//  CountOnMe
//
//  Created by Mehdi on 04/05/2018.
//  Copyright © 2018 Ambroise Collon. All rights reserved.
//

import Foundation

class Calculation {
    
    // MARK: - Properties
    
    // MARK: - Methods
    
    /// Perform the total of calaculation
    ///
    /// - Parameters:
    ///   - stringNumbers: Array of coming numbers from the calculator keyboard
    ///   - operators: Array of coming operators from the calculator keyboard
    ///   - calculationExpression: The calculation expression done
    /// - Returns: The calculation expression & result in form of string
    func performCalculation(stringNumbers: [String], mathematicalOperators: [String]) -> String {
        var result: Float = 0.0
        for (stringNumbersIndex, stringNumber) in stringNumbers.enumerated() {
            if let number = Float(stringNumber) {
                // operators share the same stringNumbers index, because the index sequence is the same for both
                switch mathematicalOperators[stringNumbersIndex] {
                case "+":
                    result += number
                case "-":
                    result -= number
                case "x":
                    result *= number
                case "/":
                    if checkDivisorIsNotZero(divisor: number) {
                        result /= number
                    } else {
                        return "Error"
                    }
                default:
                    break
                }
            }
        }
        
        return "\(result)"
    }
    
    /// Verify if a divisor is different from zero
    ///
    /// - Parameter divisor: Divisor to check
    /// - Returns: True if different from zero
    private func checkDivisorIsNotZero(divisor: Float) -> Bool {
        if divisor == 0.0 {
            return false
        } else {
            return true
        }
    }
}
