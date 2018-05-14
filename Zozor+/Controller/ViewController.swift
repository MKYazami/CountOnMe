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
                calculation.addNewNumber(i)
        }
    }

    @IBAction private func plus() {
        if calculation.canAddOperator {
            calculation.addMathematicalOperator(mathematicalOperator: "+")
        }
    }

    @IBAction private func minus() {
        if calculation.canAddOperator {
            calculation.addMathematicalOperator(mathematicalOperator: "-")
        }
    }
    
    @IBAction private func multiply() {
        if calculation.canAddOperator {
            calculation.addMathematicalOperator(mathematicalOperator: "x")
        }
    }
    
    @IBAction private func divide() {
        if calculation.canAddOperator {
            calculation.addMathematicalOperator(mathematicalOperator: "/")
        }
    }
    
    @IBAction private func equal() {
        displayCalculationAndResult()
    }

    @IBAction private func clearScreenDisplay() {
        calculatorScreenView.text = ""
        calculation.resetNumbersAndOperators()
    }
    
    // MARK: - Properties
    
    // Access to Calculation type
    private var calculation = Calculation()
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Start the application with clear screen
        calculatorScreenView.text = ""
        
        //Affecting delegates to self
        calculation.alertMessageDelegate = self
        calculation.updateDisplayDelegate = self
    }

    /// Displays the calculation expression and result
    private func displayCalculationAndResult() {
        if !calculation.isExpressionCorrect {
            return
        }
        
        //Getting result from the model
        let result: String = calculation.result
        
        calculatorScreenView.text! += "\n=\n\(result)"

        calculation.resetNumbersAndOperators()
    }
 
}

extension ViewController: AlertMessage, UpdateDisplay {
    
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
    
    /// Updates screen display each time the user enter number or operator
    func updateScreenDisplay() {
        var mathematicalExpression: String = ""
        for (stringNumbersIndex, stringNumber) in calculation.stringNumbers.enumerated() {
            // Add operator to display
            if stringNumbersIndex > 0 {
                mathematicalExpression += calculation.mathematicalOperators[stringNumbersIndex]
            }
            // Add number to display
            mathematicalExpression += stringNumber
        }
        
        calculatorScreenView.text = mathematicalExpression
    }
}
