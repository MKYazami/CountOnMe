//
//  ViewController.swift
//  CountOnMe
//
//  Created by Ambroise COLLON on 30/08/2016.
//  Copyright © 2016 Ambroise Collon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak private var calculatorScreenView: UITextView!
    @IBOutlet private var numberButtons: [UIButton]!

    // MARK: - Action

    @IBAction private func tappedNumberButton(_ sender: UIButton) {
        for (i, numberButton) in numberButtons.enumerated() where sender == numberButton {
                addNewNumber(i)
        }
    }

    @IBAction private func plus() {
        if canAddOperator {
            addMathematicalOperator(mathematicalOperator: "+")
        }
    }

    @IBAction private func minus() {
        if canAddOperator {
            addMathematicalOperator(mathematicalOperator: "-")
        }
    }
    
    @IBAction private func multiply() {
        if canAddOperator {
            addMathematicalOperator(mathematicalOperator: "x")
        }
    }
    
    @IBAction private func divide() {
        if canAddOperator {
            addMathematicalOperator(mathematicalOperator: "/")
        }
    }
    
    @IBAction private func equal() {
        displayCalculationAndResult()
    }

    @IBAction private func clearScreenDisplay() {
        calculatorScreenView.text = ""
        resetNumbersAndOperators()
    }
    
    // MARK: - Properties
    
    // Access to Calculation type
    private var calculation = Calculation()
    
    // Contains numbers coming from calculator keyboard
    private var stringNumbers: [String] = [""]
    
    // Contains mathematical operators coming from calculator keyboard
    private var mathematicalOperators: [String] = ["+"]
    
    /// Checks if the expression is correct to preform calculation
    private var isExpressionCorrect: Bool {
        if let stringNumber = stringNumbers.last {
            // Checks if the last item is empty (ex: [""])
            if stringNumber.isEmpty {
                // Checks if the array has only one item (empty) and ask the user to start a new calculation
                // Because when we start the app or complete a calculation stringNumbers = [""] (1 item empty)
                if stringNumbers.count == 1 {
                    errorMessage(alertTitle: "Erreur !", message: "Démarrez un nouveau calcul !", actionTitle: "Ok")
                } else {
                    // Else warns the user that the calculation is not completed when the user entre equal button (ex: 3 + =)
                    errorMessage(alertTitle: "Erreur !", message: "Entrez une expression correcte !", actionTitle: "Ok")
                }
                return false
            }
        }
        return true
    }
    
    /// Checks if a number has been entered by the user just before using an operator
    private var canAddOperator: Bool {
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
                errorMessage(alertTitle: "Erreur !", message: "Expression incorrecte !", actionTitle: "Ok")
                return false
            }
        }
        return true
    }
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Start the application with clear screen
        calculatorScreenView.text = ""
    }

    /// Adds the new number to the stringNumbers array
    ///
    /// - Parameter newNumber: new number to add
    private func addNewNumber(_ newNumber: Int) {
        guard var stringNumber = stringNumbers.last else { return }
        stringNumber += "\(newNumber)"
        stringNumbers[stringNumbers.count-1] = stringNumber
        
        updateScreenDisplay()
    }
    
    /// Adds mathematical operator to mathematicalOperators array
    ///
    /// - Parameter mathematicalOperator: "+", "-", "x" or "/"…
    private func addMathematicalOperator(mathematicalOperator: String) {
        mathematicalOperators.append(mathematicalOperator)
        stringNumbers.append("")
        updateScreenDisplay()
    }

    /// Displays the calculation expression and result
    private func displayCalculationAndResult() {
        if !isExpressionCorrect {
            return
        }
        
        //Getting result from the model
        let result: String = calculation.performCalculation(stringNumbers: stringNumbers, mathematicalOperators: mathematicalOperators)
        
        calculatorScreenView.text! += "\n=\n\(result)"

        resetNumbersAndOperators()
    }

    /// Updates screen display each time the user enter number or operator
    private func updateScreenDisplay() {
        var mathematicalExpression: String = ""
        for (stringNumbersIndex, stringNumber) in stringNumbers.enumerated() {
            // Add operator to display
            if stringNumbersIndex > 0 {
                mathematicalExpression += mathematicalOperators[stringNumbersIndex]
            }
            // Add number to display
            mathematicalExpression += stringNumber
        }
        
        calculatorScreenView.text = mathematicalExpression
    }

    /// Resets stringNumbers & operators to start new calculation
    private func resetNumbersAndOperators() {
        stringNumbers = [String()]
        mathematicalOperators = ["+"]
    }

    
    
}

extension ViewController: AlertMessage {
    
    /// Allows to customize an UIAlert
    ///
    /// - Parameters:
    ///   - alertTitle: The title of the alert to present (As : error, warning…)
    ///   - message: Message explaining the error
    ///   - actionTitle: The title to present to valid the alert message (As : Ok, I understand…)
    func errorMessage(alertTitle: String, message: String, actionTitle: String) {
        let alertMessage = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        alertMessage.addAction(UIAlertAction(title: actionTitle, style: .cancel, handler: nil))
        self.present(alertMessage, animated: true, completion: nil)
    }
}
