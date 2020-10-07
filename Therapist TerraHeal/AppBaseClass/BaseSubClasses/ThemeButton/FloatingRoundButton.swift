//
//  FloatingRoundButton.swift
//  Terra Heal
//
//  Created by Jaydeep Vyas on 08/09/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import Foundation
import UIKit



//MARK: FloatingRound Button
class FloatingRoundButton: ThemeButton {
    
    @IBInspectable open var enableFloating: Bool = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        if enableFloating {
            self.setUpFloatingButton()
        }
        
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        if enableFloating {
            self.setUpFloatingButton()
        }
    }
    
    
    func setUpFloatingButton() {
        
        self.clipsToBounds = true
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowColor =  UIColor.init(red: 178/255, green: 179/255, blue: 181/255, alpha: 1.0).cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if enableFloating {
            self.layer.cornerRadius = self.bounds.height/2.0
        }
    }
   
}

class BackButton: FloatingRoundButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backButton()
    }
    
    func backButton(textColor: UIColor = UIColor.themeLightTextColor, backgroundColor: UIColor = UIColor.themePrimary, borderColor: UIColor = UIColor.themePrimary) {
        self.setImage(nil, for: .normal)
        self.height(constant: CommonSize.Button.back, direction: .horizontal)
        self.backgroundColor = backgroundColor
        self.setFont(name: FontName.System, size: 24)
        self.setText(FontSymbol.back_arrow, for: .normal)
    }
}

class CancelButton: FloatingRoundButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.cancelButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.cancelButton()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.bounds.height/2.0
    }
    func cancelButton(textColor: UIColor = UIColor.themeLightTextColor, backgroundColor: UIColor = UIColor.themePrimary, borderColor: UIColor = UIColor.themePrimary) {
         self.backgroundColor = backgroundColor
         self.setImage(nil, for: .normal)
         self.height(constant: CommonSize.Button.cancel, direction: .horizontal)
         self.setFont(name: FontName.System, size: 30)
         self.setText(FontSymbol.cancel, for: .normal)
    }
}

class DialogFloatingProceedButton: FloatingRoundButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.forwardButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.forwardButton()
    }
    
    func forwardButton(textColor: UIColor = UIColor.themeLightTextColor, backgroundColor: UIColor = UIColor.themePrimary, borderColor: UIColor = UIColor.themePrimary) {
         self.backgroundColor = backgroundColor
         self.height(constant: CommonSize.Button.forwardButton, direction: .horizontal)
         self.setFont(name: FontName.System, size: 30)
         self.setText(FontSymbol.next_arrow, for: .normal)
    }
}

class FloatingProceedButton: FloatingRoundButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.forwardButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.forwardButton()
    }
    
    func forwardButton(textColor: UIColor = UIColor.themeLightTextColor, backgroundColor: UIColor = UIColor.themePrimary, borderColor: UIColor = UIColor.themePrimary) {
         self.backgroundColor = backgroundColor
         self.height(constant: CommonSize.Button.forwardButton, direction: .horizontal)
         self.setFont(name: FontName.System, size: 30)
         self.setText(FontSymbol.next_arrow, for: .normal)
    }
}
