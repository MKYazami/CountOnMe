//
//  ViewController.swift
//  CountOnMe
//
//  Created by Ambroise COLLON on 30/08/2016.
//  Copyright © 2016 Ambroise Collon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Properties
    private var calculation = Calculation()
    private var stringNumbers: [String] = [String()]
    private var operators: [String] = ["+"]
    private var index = 0
    private var isExpressionCorrect: Bool {
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
                if stringNumbers.count == 1 {
                    errorMessage(alertTitle: "Erreur !", message: "Démarrez un nouveau calcul !", actionTitle: "Ok")
                } else {
                    errorMessage(alertTitle: "Erreur !", message: "Entrez une expression correcte !", actionTitle: "Ok")
                }
                return false
            }
        }
        return true
    }

    private var canAddOperator: Bool {
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
                errorMessage(alertTitle: "Erreur !", message: "Expression incorrecte !", actionTitle: "Ok")
                return false
            }
        }
        return true
    }

    // MARK: - Outlets

    @IBOutlet weak private var textView: UITextView!
    @IBOutlet private var numberButtons: [UIButton]!

    // MARK: - Action

    @IBAction private func tappedNumberButton(_ sender: UIButton) {
        for (i, numberButton) in numberButtons.enumerated() where sender == numberButton {
                addNewNumber(i)
        }
    }

    @IBAction private func plus() {
        if canAddOperator {
            makeOperation(mathematicalOperator: "+")
        }
    }

    @IBAction private func minus() {
        if canAddOperator {
            makeOperation(mathematicalOperator: "-")
        }
    }
    
    @IBAction private func multiply() {
        if canAddOperator {
            makeOperation(mathematicalOperator: "x")
        }
    }
    
    @IBAction private func divide() {
        if canAddOperator {
            makeOperation(mathematicalOperator: "/")
        }
    }
    
    @IBAction private func equal() {
        displayCalculationAndTotalResult()
    }

    @IBAction private func clearScreenDisplay() {
        textView.text = ""
        clear()
    }
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Start the application with clear screen
        textView.text = ""
    }

    private func addNewNumber(_ newNumber: Int) {
        if var stringNumber = stringNumbers.last {
            stringNumber += "\(newNumber)"
            stringNumbers[stringNumbers.count-1] = stringNumber
        }
        updateDisplay()
    }

    func displayCalculationAndTotalResult() {
        if !isExpressionCorrect {
            return
        }
        
        textView.text! = calculation.performTotalCalculation(stringNumbers: stringNumbers, operators: operators, calculation: textView.text!)

        clear()
    }

    private func updateDisplay() {
        var text = ""
        for (i, stringNumber) in stringNumbers.enumerated() {
            // Add operator
            if i > 0 {
                text += operators[i]
            }
            // Add number
            text += stringNumber
        }
        textView.text = text
    }

    private func clear() {
        stringNumbers = [String()]
        operators = ["+"]
        index = 0
    }

    /// Perform an operation according to the arithmetic symbol
    ///
    /// - Parameter mathematicalOperator: "+", "-", "x" or "/"
    private func makeOperation(mathematicalOperator: String) {
        operators.append(mathematicalOperator)
        stringNumbers.append("")
        updateDisplay()
    }
    
    /// Allows to customize an UIAlert
    ///
    /// - Parameters:
    ///   - alertTitle: The title of the alert to present (As : error, warning…)
    ///   - message: Message explaining the error
    ///   - actionTitle: The title to present to valid the alert message (As : Ok, I understand…)
    private func errorMessage(alertTitle: String, message: String, actionTitle: String) {
        let alertMessage = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        alertMessage.addAction(UIAlertAction(title: actionTitle, style: .cancel, handler: nil))
        self.present(alertMessage, animated: true, completion: nil)
    }
}
