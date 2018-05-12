//
//  AlertMessage.swift
//  CountOnMe
//
//  Created by Mehdi on 12/05/2018.
//  Copyright © 2018 Ambroise Collon. All rights reserved.
//

import Foundation

protocol AlertMessage {
    func errorMessage(alertTitle: String, message: String, actionTitle: String)
}
