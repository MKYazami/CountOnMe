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
    
    var alertMessageDelegate: AlertMessage?
    
    var updateDisplayDelegate: UpdateDisplay?
    
    // Contains numbers coming from calculator keyboard
    var stringNumbers: [String] = [""]
    
    // Contains mathematical operators coming from calculator keyboard
    var mathematicalOperators: [String] = ["+"]
    
    //Result of calculation
    var result: String {
        return performCalculation()
    }
    
    /// Checks if the expression is correct to preform calculation
    var isExpressionCorrect: Bool {
        if let stringNumber = stringNumbers.last {
            // Checks if the last item is empty (ex: [""])
            if stringNumber.isEmpty {
                // Checks if the array has only one item (empty) and ask the user to start a new calculation
                // Because when we start the app or complete a calculation stringNumbers = [""] (1 item empty)
                if stringNumbers.count == 1 {
                    alertMessageDelegate?.errorMessage(alertTitle: "Erreur !", message: "Démarrez un nouveau calcul !", actionTitle: "Ok")
                } else {
                    // Else warns the user that the calculation is not completed when the user entre equal button (ex: 3 + =)
                    alertMessageDelegate?.errorMessage(alertTitle: "Erreur !", message: "Entrez une expression correcte !", actionTitle: "Ok")
                }
                return false
            }
        }
        return true
    }
    
    /// Checks if a number has been entered by the user just before using an operator
    var canAddOperator: Bool {
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
                alertMessageDelegate?.errorMessage(alertTitle: "Erreur !", message: "Expression incorrecte !", actionTitle: "Ok")
                return false
            }
        }
        return true
    }
    
    // MARK: - Methods
    
    /// Adds the new number to the stringNumbers array
    ///
    /// - Parameter newNumber: new number to add
    func addNewNumber(_ newNumber: Int) {
        if var stringNumber = stringNumbers.last {
            stringNumber += "\(newNumber)"
            stringNumbers[stringNumbers.count-1] = stringNumber
        }

        updateDisplayDelegate?.updateScreenDisplay()
    }
    
    /// Adds mathematical operator to mathematicalOperators array
    ///
    /// - Parameter mathematicalOperator: "+", "-", "x" or "/"…
    func addMathematicalOperator(mathematicalOperator: String) {
        mathematicalOperators.append(mathematicalOperator)
        stringNumbers.append("")
        
        updateDisplayDelegate?.updateScreenDisplay()
    }
    
    /// Resets stringNumbers & operators to start new calculation
    func resetNumbersAndOperators() {
        stringNumbers = [String()]
        mathematicalOperators = ["+"]
    }
    
    /// Perform the total of calaculation
    ///
    /// - Parameters:
    ///   - stringNumbers: Array of coming numbers from the calculator keyboard
    ///   - operators: Array of coming operators from the calculator keyboard
    ///   - calculationExpression: The calculation expression done
    /// - Returns: The calculation expression & result in form of string
    private func performCalculation() -> String {
        let errorMessage: String = "Error"
        
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
                        return errorMessage
                    }
                default:
                    return errorMessage
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
