//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import Foundation
import UIKit

class ThemeButton: UIButton {


    override func draw(_ rect: CGRect) {
    }

    func setUpRoundedButton() {
        self.setImage(nil, for: .normal)
        self.setTitle(FontSymbol.arrow, for: .normal)
        self.setFont(name: FontName.System, size: 45)
        self.height(constant: JDDeviceHelper().offseter(offset: 60))
        self.setRound(withBorderColor: .clear, andCornerRadious: 0.0, borderWidth: 1.0)

    }

    func setFont(name:String,size:CGFloat){
        let finalSize = JDDeviceHelper().fontCalculator(size: size)
        self.titleLabel?.font = FontHelper.font(name: name, size: finalSize)
    }

    /*var colorPast: Bool = true

    override var isHighlighted: Bool {
        didSet {
            if isHighlighted && colorPast {
                self.layer.borderColor = UIColor.clear.cgColor

                borderDissapear(highlighted: isHighlighted)
                colorPast = false
            } else if !isHighlighted && !colorPast {
                self.layer.borderColor = UIColor.themePrimary.cgColor
                borderDissapear(highlighted: isHighlighted)
                colorPast = true
            }
        }
    }*/
    func setSelected() {
        self.isHighlighted = true
        borderDissapear(hideBorder: false)
    }
    func setDeselect() {
        self.isHighlighted = false
        borderDissapear(hideBorder: true)
    }

    func borderDissapear (hideBorder: Bool) {
        let animation = CABasicAnimation(keyPath: "borderColor")
        animation.duration = 0.1
        animation.autoreverses = false
        animation.repeatCount = 1
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        if hideBorder {
            animation.fromValue = UIColor.themePrimary.cgColor.copy(alpha: 1.0)
            animation.toValue = UIColor.themePrimary.cgColor.copy(alpha: 0.0)
        } else if !hideBorder {
            animation.fromValue = UIColor.themePrimary.cgColor.copy(alpha: 0.0)
            animation.toValue = UIColor.themePrimary.cgColor.copy(alpha: 1.0)
        }
        self.layer.add(animation, forKey: "borderColor")
    }

    func setUnderlineTitle(_ title: String?, for state: UIControl.State) {
        self.setAttributedTitle(self.attributedString(title: title), for: .normal)
    }

    func resetNormalTitle(_ title: String?, for state: UIControl.State) {
        self.setAttributedTitle(nil, for: .normal)
        self.setTitle(title, for: .normal)
    }


    private func attributedString(title:String?) -> NSAttributedString? {
        if let normalTitle = title {
            let attributes: [NSAttributedString.Key: Any] = [
                NSAttributedString.Key.font: self.titleLabel?.font ?? UIFont.systemFont(ofSize: 14),
                NSAttributedString.Key.foregroundColor: self.titleColor(for: .normal) ?? UIColor.red,
                NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue
            ]
            let attributedString = NSAttributedString(string:normalTitle, attributes: attributes)
            return attributedString
        }
        return nil

    }
}


//MARK: Underlined Button
class UnderlineTextButton: ThemeButton {

    override func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle(title, for: .normal)
        self.setAttributedTitle(self.attributedString(), for: .normal)
    }

    private func attributedString() -> NSAttributedString? {
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: self.titleLabel?.font ?? UIFont.systemFont(ofSize: 14),
            NSAttributedString.Key.foregroundColor: self.titleColor(for: .normal) ?? UIColor.red,
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        let attributedString = NSAttributedString(string: self.currentTitle!, attributes: attributes)
        return attributedString
    }
}


extension UIView {
    func height(constant: CGFloat) {
        setConstraint(value: constant, attribute: .height)
    }

    func width(constant: CGFloat) {
        setConstraint(value: constant, attribute: .width)
    }

    private func removeConstraint(attribute: NSLayoutConstraint.Attribute) {
        constraints.forEach {
            if $0.firstAttribute == attribute {
                removeConstraint($0)
            }
        }
    }

    private func setConstraint(value: CGFloat, attribute: NSLayoutConstraint.Attribute) {
        removeConstraint(attribute: attribute)
        let constraint =
            NSLayoutConstraint(item: self,
                               attribute: attribute,
                               relatedBy: NSLayoutConstraint.Relation.equal,
                               toItem: nil,
                               attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                               multiplier: 1,
                               constant: value)
        self.addConstraint(constraint)
    }
}
