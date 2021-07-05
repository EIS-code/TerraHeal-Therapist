//
//  LoginViewModel.swift
//  UONDA
//
//  Created by Jaydeep Vyas on 15/10/20.
//  Copyright © 2020 Jaydeep Vyas. All rights reserved.
//

import Foundation


class LoginViewModel {
    var formItems = [FormItem]()
    var title: String?
    var username: String?
    var password: String?

    private enum TextFieldType: Int {
        case email = 0
        case password = 1
    }
    init() {
        self.configureItems()
        self.title = "Login form"
    }

    // MARK: Form Validation
    @discardableResult
    func isValid() -> (Bool, String) {
        var isValid = true
        var strMessage = ""

        for item in self.formItems {
            let valueToValidate = item.value ?? ""
            switch item.textFieladType {
            case TextFieldType.email.rawValue:
                if !valueToValidate.isValidEmail() {
                    isValid = false
                    strMessage = "VALIDATION_MSG_INVALID_EMAIL".localized()
                    break;
                }
            case TextFieldType.password.rawValue:
                if !valueToValidate.isValidPassword {
                    isValid = false
                    strMessage = "VALIDATION_MSG_INVALID_PASSWORD".localized()
                    break;
                }
            default:
                isValid = true
                strMessage = ""
            }
            if isValid == false {
                break
            }
        }
        return (isValid, strMessage)
    }

    /// Prepare all form Items ViewModels for the DirectStudioForm
    private func configureItems() {
        // Username
        let usernameItem = FormItem(title: "LOGIN_TXT_EMAIL".localized(), placeholder: "LOGIN_TXT_EMAIL".localized(), value: "")
        usernameItem.value = self.username
        usernameItem.uiProperties.keyboardType = .emailAddress
        usernameItem.uiProperties.rightImage = nil
        usernameItem.textFieladType = TextFieldType.email.rawValue
        usernameItem.valueCompletion = { [weak self, weak usernameItem] value in
            self?.username = value
            usernameItem?.value = value
        }

        //Password
        let passwordItem = FormItem(title: "LOGIN_TXT_PASSWORD".localized(), placeholder: "LOGIN_TXT_PASSWORD".localized(), value: "")
        passwordItem.uiProperties.keyboardType = .default
        passwordItem.uiProperties.secureEntry = true
        passwordItem.value = self.password
        passwordItem.textFieladType = TextFieldType.password.rawValue
        passwordItem.uiProperties.rightImage = ImageAsset.TextField.password//ImageAsset.TextField.password
        passwordItem.valueCompletion = { [weak self, weak passwordItem] value in
            self?.password = value
            passwordItem?.value = value
        }

        self.formItems = [usernameItem, passwordItem]
    }
}
