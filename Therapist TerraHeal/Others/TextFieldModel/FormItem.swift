//
//  FormItem.swift
//  UONDA
//
//  Created by Jaydeep Vyas on 15/10/20.
//  Copyright © 2020 Jaydeep Vyas. All rights reserved.
//

import Foundation
//Protocol to validate TextFieldData
protocol FormValidable {
    var isValid: Bool {get set}
    var isMandatory: Bool {get set}
    var validationMessage: String {get set}
    func checkValidity()
}

// ViewModel to display and react to text events, to update data
class FormItem: FormValidable {

    var value: String?
    var title: String?
    var placeholder = ""
    var indexPath: IndexPath?
    var valueCompletion: ((String?) -> Void)?
    var isMandatory = true
    var isValid = true
    var uiProperties = FormItemUIProperties()
    var validationMessage: String = ""
    var textFieladType: Int = -1

    // MARK: Init
    init(title: String? = nil, placeholder: String, value: String? = nil) {
        self.placeholder = placeholder
        self.value = value
        self.title = title
    }

    // MARK: FormValidable
    func checkValidity() {
        if self.isMandatory {
            self.isValid = self.value != nil && self.value?.isEmpty == false
        } else {
            self.isValid = true
        }
    }
}
