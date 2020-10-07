//
//  UIControl + SetText + Extension.swift
//  Therapist TerraHeal
//
//  Created by Jaydeep Vyas on 07/10/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import Foundation
import UIKit

public extension UITextField {
    func setText(_ textToSet:String?) {
        guard let value = textToSet else {
            self.text = ""
            return
        }
        self.text = value
    }
    func setPlaceholder(_ textToSet:String?) {
        guard let value = textToSet else {
            self.placeholder = ""
            return
        }
        self.placeholder = value
    }

    
}
public extension UITextView {
    func setText(_ textToSet:String?) {
        guard let value = textToSet else {
            self.text = ""
            return
        }
        self.text = value
    }
    func setPlaceholder(_ textToSet:String?) {
        guard let value = textToSet else {
            self.placeholder = ""
            return
        }
        self.placeholder = value
    }


}

public extension UILabel {
    func setText(_ textToSet:String?) {
         guard let value = textToSet else {
                   self.text = ""
                   return
               }
               self.text = value
    }
}
public extension UIButton {
    func setText(_ textToSet:String?, for state: UIControl.State = .normal) {
        guard let value = textToSet else {
            self.setTitle("", for: state)
            return
        }
        self.setTitle(value, for: state)
    }
}
