//
//  UITextField + Extension.swift
//  StringExtension
//
//  Created by Jaydeep on 30/11/19.
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import Foundation
import UIKit

public extension UITextField {

    func setInputViewDatePicker(target: Any, selector: Selector) {
        
        // Create a UIDatePicker object and assign to inputView
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))//1
        datePicker.datePickerMode = .date //2
        datePicker.backgroundColor = UIColor.white
        datePicker.textLabelColor = UIColor.themePrimary
        self.inputView = datePicker //3

        // Create a toolbar and assign it to inputAccessoryView
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0)) //4
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) //5
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel)) // 6
        let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector) //7
        toolBar.setItems([cancel, flexible, barButton], animated: false) //8
        self.inputAccessoryView = toolBar //9
    }

    @objc func tapCancel() {
        self.resignFirstResponder()
    }

}
@IBDesignable
extension UIDatePicker {
    @IBInspectable var textLabelColor: UIColor? {
        get {
            return self.value(forKey: "textColor") as? UIColor
        }
        set {
            self.setValue(newValue, forKey: "textColor")
            self.performSelector(inBackground: "setHighlightsToday:", with:newValue) //For some reason this line makes the highlighted text appear the same color but can not be changed from textColor.
        }
    }
}