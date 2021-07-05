//
//  LoginVC + Dialogs.swift
//  TerraHealAdmin
//
//  Created by Jaydeep Vyas on 19/05/21.
//

import Foundation
import UIKit
//MARK: - Dialogs

extension LoginVC {

    func openPersonePickerDialog() {
        let alert: PersonPickerDialog = PersonPickerDialog.fromNib()
        alert.initialize(title: "FINGER_PRINT_DIALOG_PICK_USER_TITLE".localized(), buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_BACK".localized())
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            guard let self = self else { return } ; print(self)
            alert?.dismiss()
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self] (person) in
            guard let self = self else { return } ; print(self)
            alert?.dismiss()
            self.wsLogin(username: self.loginForm.username ?? "", password: self.loginForm.password ?? "")
        }
    }

    func openPasswordDialog() {
        let alert: CustomTextFieldDialog = CustomTextFieldDialog.fromNib()
        alert.initialize(title: "FINGER_PRINT_DIALOG_PASSWORD_TITLE".localized(), data: "", buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_BACK".localized())
        alert.show(animated: true)
        //alert.configTextField(data: InputTextFieldDetail.getPassowordConfiguration())
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            guard let self = self else { return } ; print(self)
            alert?.dismiss()
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self] (description) in
            guard let self = self else { return } ; print(self)
            alert?.dismiss()
        }
    }

    func openRegisterFingerPrintDialog() {
        let alertFingerPrint: FingerPrintDialog = FingerPrintDialog.fromNib()
        alertFingerPrint.initialize(title: "FINGER_PRINT_DIALOG_REGISTER_TITLE".localized(), buttonTitle: "BTN_YES_PROCEED".localized(), cancelButtonTitle: "BTN_CANCEL".localized())
        alertFingerPrint.show(animated: true)
        alertFingerPrint.onBtnCancelTapped = {
            [weak alertFingerPrint, weak self] in
            guard let self = self else {return}; print(self)
            alertFingerPrint?.dismiss();
            Common.appDelegate.loadMainVC()
        }
        alertFingerPrint.onBtnDoneTapped = {[weak alertFingerPrint, weak self] in
            guard let self = self else {return}; print(self)
            alertFingerPrint?.dismiss();
            CoreDataManager.sharedManager.create(username: self.loginForm.username!, password: self.loginForm.password!)
            Common.appDelegate.loadMainVC()
        }
    }

    func checkFignerPrintData() {
        let count = CoreDataManager.sharedManager.fetchPersons().count
        if count == 0  {
            Common.showAlert(message: "VALIDATION_MSG_MANUAL_LOGIN_FIRST".localized())
            self.btnFigerPrint.isEnabled = true
        } else {
            self.authenticateUser()
        }
    }

    func openLoginFingerPrintDialog() {
        let alertFingerPrint: FingerPrintDialog = FingerPrintDialog.fromNib()
        alertFingerPrint.initialize(title: "FINGER_PRINT_DIALOG_LOGIN_TITLE".localized(), buttonTitle: "BTN_YES_PROCEED".localized(), cancelButtonTitle: "FINGER_PRINT_DIALOG_BTN_PASSWORD".localized())
        alertFingerPrint.show(animated: true)
        alertFingerPrint.onBtnCancelTapped = {
            [weak alertFingerPrint, weak self] in
            guard let self = self else {return}; print(self)
            alertFingerPrint?.dismiss();
            self.btnFigerPrint.isEnabled = true
            self.openPasswordDialog()
        }
        alertFingerPrint.onBtnDoneTapped = {
            [weak alertFingerPrint, weak self] in
            guard let self = self else {return}; print(self)
            alertFingerPrint?.dismiss();
            self.btnFigerPrint.isEnabled = true
            if CoreDataManager.sharedManager.fetchPersons().count == 1 {
                if let person: Person = CoreDataManager.sharedManager.fetchPersons().first {
                    self.wsLogin(username: person.username ?? "", password: person.password ?? "")
                }
            } else {
                self.openPersonePickerDialog()
            }
        }
    }
}
