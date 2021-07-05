//
//  LoginVC + TouchID.swift
//  TerraHealAdmin
//
//  Created by Jaydeep Vyas on 18/05/21.
//

import Foundation
import UIKit
import LocalAuthentication


// MARK: - Touch API Methods
extension LoginVC {

    func authenticateUser() {

        let context = LAContext()

        var error: NSError?

        if context.canEvaluatePolicy(
            LAPolicy.deviceOwnerAuthenticationWithBiometrics,
            error: &error) {

            // Device can use biometric authentication
            context.evaluatePolicy(
                LAPolicy.deviceOwnerAuthenticationWithBiometrics,
                localizedReason: "Access requires authentication",
                reply: {(success, error) in
                    DispatchQueue.main.async {

                        if let err = error {

                            switch err._code {

                            case LAError.Code.systemCancel.rawValue:
                                self.notifyUser("Session cancelled",
                                                err: err.localizedDescription)

                            case LAError.Code.userCancel.rawValue:
                                self.notifyUser("Please try again",
                                                err: err.localizedDescription)

                            case LAError.Code.userFallback.rawValue:
                                self.notifyUser("Authentication",
                                                err: "Password option selected")
                                // Custom code to obtain password here

                            default:
                                self.notifyUser("Authentication failed",
                                                err: err.localizedDescription)
                            }

                        } else {
                            self.imgChecked?.isHidden = false
                            if let person: Person = CoreDataManager.sharedManager.fetchPersons().first {
                                    self.wsLogin(username: person.username ?? "", password: person.password ?? "")
                            }
                            else {
                                self.openPersonePickerDialog()
                            }
                        }
                    }
            })

        } else {
            // Device cannot use biometric authentication
            if let err = error {
                switch err.code {

                case LAError.Code.biometryNotEnrolled.rawValue:
                    notifyUser("User is not enrolled",
                               err: err.localizedDescription)

                case LAError.Code.passcodeNotSet.rawValue:
                    notifyUser("A passcode has not been set",
                               err: err.localizedDescription)


                case LAError.Code.biometryNotAvailable.rawValue:
                    notifyUser("Biometric authentication not available",
                               err: err.localizedDescription)
                default:
                    notifyUser("Unknown error",
                               err: err.localizedDescription)
                }
            }
        }

    }


    func notifyUser(_ msg: String, err: String?) {
        let alert: CustomAlert = CustomAlert.fromNib()
        alert.initialize(message: msg.localized())
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            guard let self = self else { return } ; print(self)
            alert?.dismiss()
        }
        self.btnFigerPrint.isEnabled = true
    }
    
}
