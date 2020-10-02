//
//  TextField + InputConfiguration.swift
//  Terra Heal
//
//  Created by Jaydeep Vyas on 06/07/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import Foundation
import UIKit

enum TextFieldContentType: Int {
    
    case Name = 0
    case Surname = 1
    case Gender = 2
    case DOB = 3
    case Phone = 4
    case EmergencyContact = 5
    case Email = 6
    case City = 7
    case Country = 8
    case Nif = 9
    case IdPassport = 10
    case Number = 11
    case Default = 12
    case Password = 13
    case Currency = 14
    
}

public struct InputTextFieldDetail {
    var isMadatory:Bool = true
    var textContentType: UITextContentType = .name
    var texFieldType: TextFieldContentType = .Name
    var minLength: Int = 0
    var maxLength: Int = 20
    var keyBoardType: UIKeyboardType = .default
    
    static func getEmailConfiguration() -> InputTextFieldDetail {
        return InputTextFieldDetail(isMadatory: true, textContentType: .emailAddress, texFieldType: .Email, minLength: 2, maxLength: 20, keyBoardType: .emailAddress)
    }
    static func getMobileConfiguration() -> InputTextFieldDetail {
        return InputTextFieldDetail(isMadatory: true, textContentType: .telephoneNumber, texFieldType: .Phone, minLength: 8, maxLength: 10, keyBoardType: .phonePad)
    }
    
    static func getNameConfiguration() -> InputTextFieldDetail {
        return InputTextFieldDetail(isMadatory: true, textContentType: .name, texFieldType: .Name, minLength: 2, maxLength: 20, keyBoardType: .default)
    }
    static func getCurrencyConfiguration() -> InputTextFieldDetail {
        return InputTextFieldDetail(isMadatory: true, textContentType: .name, texFieldType: .Currency, minLength: 2, maxLength: 20, keyBoardType: .decimalPad)
    }
    static func getNumberConfiguration() -> InputTextFieldDetail {
        return InputTextFieldDetail(isMadatory: true, textContentType: .postalCode, texFieldType: .Number, minLength: 2, maxLength: 20, keyBoardType: .numberPad)
    }
    static func getPassowordConfiguration() -> InputTextFieldDetail {
           return InputTextFieldDetail(isMadatory: true, textContentType: .password, texFieldType: .Password, minLength: 6, maxLength: 20, keyBoardType: .default)
    }
}
