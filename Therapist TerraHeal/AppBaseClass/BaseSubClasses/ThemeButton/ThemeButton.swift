//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import Foundation
import UIKit

class ThemeButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.tintColor = self.backgroundColor
    }
  
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.tintColor = self.backgroundColor
    }
    
    override public var isHighlighted: Bool {
        didSet {
            /* To get rid of the tint background */
            self.tintColor = self.backgroundColor
        }
    }
    
    func setImage(_ image: UIImage?, for state: UIControl.State, withAnimation:Bool = false) {
        UIView.transition(with: self,
                          duration:0.5,
                          options: .transitionCrossDissolve,
                          animations: { self.setImage(image, for: state)},
                          completion: nil)
    }
    
    func setFont(name:String,size:CGFloat){
        let finalSize = JDDeviceHelper.fontCalculator(size: size)
        self.titleLabel?.font = FontHelper.font(name: name, size: finalSize)
    }

}


class FilledRoundedButton: ThemeButton {
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.fillButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.fillButton()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.bounds.height/2.0
        self.layer.masksToBounds = true
    }
    func fillButton(textColor: UIColor = UIColor.themeLightTextColor, backgroundColor: UIColor = UIColor.themeSecondary, borderColor: UIColor = UIColor.clear, buttonHeight:CGFloat = CommonSize.Button.standard) {
        self.setFont(name: FontName.SemiBold, size: FontSize.button_14)
        self.height(constant: buttonHeight, direction: .horizontal)
        self.backgroundColor = backgroundColor
        self.setTitleColor(textColor, for: .normal)
    }
    
}

class RoundedBorderButton: ThemeButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.borderedButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.borderedButton()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.bounds.height/2.0
        self.layer.masksToBounds = true
    }
    func borderedButton(textColor: UIColor = UIColor.themeSecondary, backgroundColor: UIColor = UIColor.clear, borderColor: UIColor = UIColor.themeSecondary) {
        self.setFont(name: FontName.SemiBold, size: FontSize.button_14)
        self.height(constant: CommonSize.Button.standard, direction: .horizontal)
        self.backgroundColor = backgroundColor
        self.setTitleColor(textColor, for: .normal)
        self.setRound(withBorderColor:borderColor, andCornerRadious: self.bounds.height/2.0, borderWidth: 1.0)
    }
}


//MARK: Underlined Button
class UnderlineTextButton: ThemeButton {
    
    override func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle(title, for: .normal)
        self.setAttributedTitle(self.attributedString(), for: .normal)
    }
    
    private func attributedString() -> NSAttributedString? {
        let attributes : [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font : self.titleLabel?.font ?? UIFont.systemFont(ofSize: 14),
            NSAttributedString.Key.foregroundColor : self.titleColor(for: .normal) ?? UIColor.red,
            NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue
        ]
        let attributedString = NSAttributedString(string: self.currentTitle!, attributes: attributes)
        return attributedString
    }
}

class DialogCancelButton: UnderlineTextButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setFont(name: FontName.Regular, size: FontSize.button_21)
        self.setTitleColor(UIColor.themePrimary, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setFont(name: FontName.Regular, size: FontSize.button_21)
        self.setTitleColor(UIColor.themePrimary, for: .normal)
    }
   
    override func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle(title, for: .normal)
    }

}

class DialogFilledRoundedButton: ThemeButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.fillButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.fillButton()
    }
    
    override func layoutSubviews() {
           super.layoutSubviews()
           self.layer.cornerRadius = self.bounds.height/2.0
           self.layer.masksToBounds = true
    }
    
    func fillButton(textColor: UIColor = UIColor.themeLightTextColor, backgroundColor: UIColor = UIColor.themeSecondary, borderColor: UIColor = UIColor.clear) {
        self.setFont(name: FontName.SemiBold, size: FontSize.button_14)
        self.height(constant: CommonSize.Button.standard, direction: .horizontal)
        self.width(constant: CommonSize.Button.standardLargeWidth, direction: .horizontal)
        self.contentEdgeInsets = UIEdgeInsets.init(top: 10, left: 0, bottom: 10, right: 0)
        self.backgroundColor = backgroundColor
        self.setTitleColor(textColor, for: .normal)
        self.setRound(withBorderColor: borderColor, andCornerRadious: self.frame.height/2.0, borderWidth: 1.0)
    }
}
