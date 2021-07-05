//
//  FormItemUI.swift
//  UONDA
//
//  Created by Jaydeep Vyas on 15/10/20.
//  Copyright © 2020 Jaydeep Vyas. All rights reserved.
//

import Foundation
import UIKit


/// UIKit properties for ViewModels
struct FormItemUIProperties {
    var keyboardType = UIKeyboardType.default
    var textContentType: UITextContentType = .name
    var secureEntry: Bool = false
    var rightImage: String?
    var suggesion: UITextAutocorrectionType = .default
    var minLength: Int = 0
    var maxLength: Int = 50

    static func getEmailConfiguration() -> FormItemUIProperties {
        FormItemUIProperties.init(keyboardType: .emailAddress, textContentType: .emailAddress, secureEntry: false, rightImage: nil, suggesion: .yes)
    }
    static func getNameConfiguration() -> FormItemUIProperties {
        return FormItemUIProperties.init(keyboardType: .default, textContentType: .givenName, secureEntry: false, rightImage: nil, suggesion: .yes)
    }
    static func getLastNameConfiguration() -> FormItemUIProperties {
        return FormItemUIProperties.init(keyboardType: .default, textContentType: .familyName, secureEntry: false, rightImage: nil,suggesion: .yes)
    }
    static func getPasswordConfiguration() -> FormItemUIProperties {
        return FormItemUIProperties.init(keyboardType: .default, textContentType: .name, secureEntry: false, rightImage:nil,suggesion: .no ,minLength: 6,maxLength: 12)
    }

}

