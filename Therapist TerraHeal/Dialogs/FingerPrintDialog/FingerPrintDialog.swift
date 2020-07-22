//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Aatish. All rights reserved.
//

import UIKit
import LocalAuthentication


class FingerPrintDialog: ThemeBottomDialogView {

    @IBOutlet weak var lblTitle: ThemeLabel!
    @IBOutlet weak var imgChecked: UIImageView!
    var onBtnDoneTapped : (() -> Void)? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    
    func initialize(title:String, buttonTitle:String,cancelButtonTitle:String) {
        self.initialSetup()
        self.imgChecked?.isHidden = true
        self.lblTitle.text = title
        if cancelButtonTitle.isEmpty() {
            self.btnCancel.isHidden = true
        } else {
            self.btnCancel.setTitle(cancelButtonTitle, for: .normal)
            self.btnCancel.isHidden = false
        }
        if buttonTitle.isEmpty() {
            self.btnNext.isHidden = true
        } else {
            self.btnNext.setTitle(buttonTitle, for: .normal)
            self.btnNext.isHidden = false
        }
    }

    override func initialSetup() {
        super.initialSetup()
        self.lblTitle.setFont(name: FontName.Bold, size: FontSize.label_26)
    }
    
    @IBAction func onClickBtnDone(_ sender: Any) {
        if self.onBtnDoneTapped != nil {
            self.onBtnDoneTapped!();
        }
    }
    
    @IBAction func btnFingerPrintTapped(_ sender: UIButton) {
          authenticateUser(self)
    }
   
}


// MARK: - Touch API Methods
extension FingerPrintDialog {


    func authenticateUser(_ sender: Any) {

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
    }
}
