//
//  LoginViewModel.swift
//  Therapist TerraHeal
//
//  Created by Jaydeep Vyas on 22/07/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import Foundation
import UIKit

protocol LoginViewModelDelegate {
    func sendValue(from emailTextField: String?, passwordTextField: String?)
}

protocol ViewControllerDelegate: class {
    func getInformationBack(handledString:String?)
}

class LoginViewModel: LoginViewModelDelegate {
    
    weak var delegate: ViewControllerDelegate?
    
    func sendValue(from emailTextField: String?, passwordTextField: String?) {
        guard let email = emailTextField else { return }
        guard let password = emailTextField else { return }
        delegate?.getInformationBack(handledString: "\(email + password)")
    }
}
