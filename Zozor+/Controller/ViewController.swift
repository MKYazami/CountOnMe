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
    var stringNumbers: [String] = [String()]
    var operators: [String] = ["+"]
    var index = 0
    var isExpressionCorrect: Bool {
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

    var canAddOperator: Bool {
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
                errorMessage(alertTitle: "Erreur !", message: "Expression incorrecte !", actionTitle: "Ok")
                return false
            }
        }
        return true
    }

    // MARK: - Outlets

    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!

    // MARK: - Action

    @IBAction func tappedNumberButton(_ sender: UIButton) {
        for (i, numberButton) in numberButtons.enumerated() where sender == numberButton {
                addNewNumber(i)
        }
    }

    @IBAction func plus() {
        if canAddOperator {
        	operators.append("+")
        	stringNumbers.append("")
            updateDisplay()
        }
    }

    @IBAction func minus() {
        if canAddOperator {
            operators.append("-")
            stringNumbers.append("")
            updateDisplay()
        }
    }

    @IBAction func equal() {
        calculateTotal()
    }

    @IBAction func clearScreenDisplay() {
        textView.text = ""
        clear()
    }
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Start the application with clear screen
        textView.text = ""
    }

    func addNewNumber(_ newNumber: Int) {
        if let stringNumber = stringNumbers.last {
            var stringNumberMutable = stringNumber
            stringNumberMutable += "\(newNumber)"
            stringNumbers[stringNumbers.count-1] = stringNumberMutable
        }
        updateDisplay()
    }

    //########### Move to Model
    func calculateTotal() {
        if !isExpressionCorrect {
            return
        }

        var total = 0
        for (i, stringNumber) in stringNumbers.enumerated() {
            if let number = Int(stringNumber) {
                if operators[i] == "+" {
                    total += number
                } else if operators[i] == "-" {
                    total -= number
                }
            }
        }

        textView.text! += "=\(total)"

        clear()
    }
    //############ ./ Move to Model

    func updateDisplay() {
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

    func clear() {
        stringNumbers = [String()]
        operators = ["+"]
        index = 0
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
