//
//  Calculation.swift
//  CountOnMe
//
//  Created by Mehdi on 04/05/2018.
//  Copyright © 2018 Ambroise Collon. All rights reserved.
//

import Foundation

class Calculation {
    
    /// Perform the total of calaculation
    ///
    /// - Parameters:
    ///   - stringNumbers: Array of coming numbers from the calculator keyboard
    ///   - operators: Array of coming operators from the calculator keyboard
    ///   - calculation: The calculation done
    /// - Returns: The result of calculation in form of string
    func performTotalCalculation(stringNumbers: [String], operators: [String], calculation: String) -> String {
        var total: Int = 0
        for (i, stringNumber) in stringNumbers.enumerated() {
            if let number = Int(stringNumber) {
                switch operators[i] {
                case "+":
                    total += number
                case "-":
                    total -= number
                case "x":
                    total *= number
                case "/":
                    if checkDivisorIsNotZero(divisor: number) {
                        total /= number
                    } else {
                        return "Error"
                    }
                default:
                    break
                }
            }
        }
        
        let result = "\(calculation)=\(total)"
        
        return result
    }
    
    /// Verify if a divisor is different from zero
    ///
    /// - Parameter divisor: Divisor to check
    /// - Returns: True if different from zero
    private func checkDivisorIsNotZero(divisor: Int) -> Bool {
        if divisor == 0 {
            return false
        } else {
            return true
        }
    }
}
