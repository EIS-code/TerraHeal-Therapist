//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import Foundation
import UIKit

class ThemeButton: UIButton {
    
    
    var isButtonHighlighted: Bool = false
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
    
    func setUpRoundedButton() {
        self.setImage(nil, for: .normal)
        self.setTitle(FontSymbol.next_arrow, for: .normal)
        self.setFont(name: FontName.System, size: 45)
        self.height(constant: JDDeviceHelper().offseter(offset: 60))
        self.setRound(withBorderColor: .clear, andCornerRadious: 0.0, borderWidth: 1.0)
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 20.0
        self.layer.shadowOpacity = 1.0
        self.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        self.layer.shadowColor = UIColor.lightGray.cgColor
    }
    
    func setFont(name:String,size:CGFloat){
        let finalSize = JDDeviceHelper().fontCalculator(size: size)
        self.titleLabel?.font = FontHelper.font(name: name, size: finalSize)
    }
    
    func setHighlighted(isHighlighted: Bool) {
        self.isButtonHighlighted = isHighlighted
        //self.isSelected = isHighlighted
        if isHighlighted {
            self.backgroundColor = UIColor.themePrimary
            self.setTitleColor(UIColor.white, for: .normal)
            self.setRound(withBorderColor: UIColor.clear, andCornerRadious: self.frame.height/2.0, borderWidth: 1.0)
        } else {
            self.backgroundColor = UIColor.themeLightTextColor
            self.setTitleColor(UIColor.themePrimary, for: .normal)
            self.setRound(withBorderColor: UIColor.themePrimary, andCornerRadious: self.frame.height/2.0, borderWidth: 1.0)
        }
        //self.tintColor = self.backgroundColor
    }
    
   
}


//MARK: FloatingRound Button
class FloatingRoundButton: ThemeButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpFloatingButton()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setUpFloatingButton()
    }
    
    func setUpFloatingButton() {
        self.clipsToBounds = true
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 5.0
        self.layer.shadowOpacity = 0.8
        self.layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
        self.layer.shadowColor = UIColor.gray.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.bounds.height/2.0
    }
    func setForwardButton() {
        self.backgroundColor = .themePrimary
        self.height(constant: JDDeviceHelper().offseter(offset: 60))
        self.setFont(name: FontName.System, size: 45)
        self.setTitle(FontSymbol.next_arrow, for: .normal)
    }
    func setBackButton() {
        self.backgroundColor = UIColor.themeSecondary
        self.height(constant: JDDeviceHelper().offseter(offset: 50))
        self.setFont(name: FontName.System, size: 37)
        self.setTitle(FontSymbol.back_arrow, for: .normal)
    }
    
}


//MARK: FloatingRoundCheckbox Button
@IBDesignable
public class JDRadioButton: UIButton {
    
    internal var outerCircleLayer = CAShapeLayer()
    internal var innerCircleLayer = CAShapeLayer()
    
    
    @IBInspectable public var outerCircleColor: UIColor = UIColor.themeLightTextColor {
        didSet {
            outerCircleLayer.strokeColor = outerCircleColor.cgColor
        }
    }
    @IBInspectable public var innerCircleCircleColor: UIColor = UIColor.themePrimary {
        didSet {
            setFillState()
        }
    }
    
    @IBInspectable public var outerCircleLineWidth: CGFloat = 5.0 {
        didSet {
            setCircleLayouts()
        }
    }
    @IBInspectable public var innerCircleGap: CGFloat = 0.0 {
        didSet {
            setCircleLayouts()
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        customInitialization()
    }
    // MARK: Initialization
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInitialization()
    }
    internal var setCircleRadius: CGFloat {
        let width = bounds.width
        let height = bounds.height
        
        let length = width > height ? height : width
        return (length - outerCircleLineWidth) / 2
    }
    
    private var setCircleFrame: CGRect {
        let width = bounds.width
        let height = bounds.height
        
        let radius = setCircleRadius
        let x: CGFloat
        let y: CGFloat
        
        if width > height {
            y = outerCircleLineWidth / 2
            x = (width / 2) - radius
        } else {
            x = outerCircleLineWidth / 2
            y = (height / 2) - radius
        }
        
        let diameter = 2 * radius
        return CGRect(x: x, y: y, width: diameter, height: diameter)
    }
    
    private var circlePath: UIBezierPath {
        return UIBezierPath(roundedRect: setCircleFrame, cornerRadius: setCircleRadius)
    }
    
    private var fillCirclePath: UIBezierPath {
        let trueGap = innerCircleGap + (outerCircleLineWidth / 2)
        return UIBezierPath(roundedRect: setCircleFrame.insetBy(dx: trueGap, dy: trueGap), cornerRadius: setCircleRadius)
        
    }
    
    private func customInitialization() {
        outerCircleLayer.frame = bounds
        outerCircleLayer.lineWidth = outerCircleLineWidth
        outerCircleLayer.fillColor = UIColor.clear.cgColor
        outerCircleLayer.strokeColor = outerCircleColor.cgColor
        layer.addSublayer(outerCircleLayer)
        
        innerCircleLayer.frame = bounds
        innerCircleLayer.lineWidth = outerCircleLineWidth
        innerCircleLayer.fillColor = UIColor.clear.cgColor
        innerCircleLayer.strokeColor = UIColor.clear.cgColor
        layer.addSublayer(innerCircleLayer)
        
        setFillState()
    }
    
    private func setCircleLayouts() {
        outerCircleLayer.frame = bounds
        outerCircleLayer.lineWidth = outerCircleLineWidth
        outerCircleLayer.path = circlePath.cgPath
        
        innerCircleLayer.frame = bounds
        innerCircleLayer.lineWidth = outerCircleLineWidth
        innerCircleLayer.path = fillCirclePath.cgPath
        
        self.clipsToBounds = true
        self.layer.cornerRadius = self.bounds.height/2.0
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 5.0
        self.layer.shadowOpacity = 0.8
        self.layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
        self.layer.shadowColor = UIColor.gray.cgColor
    }
    
    // MARK: Custom
    private func setFillState() {
        if self.isSelected {
            innerCircleLayer.fillColor = UIColor.themePrimary.cgColor
        } else {
            innerCircleLayer.fillColor = UIColor.themePrimaryLight.cgColor
        }
    }
    // Overriden methods.
    override public func prepareForInterfaceBuilder() {
        customInitialization()
    }
    override public func layoutSubviews() {
        super.layoutSubviews()
        setCircleLayouts()
    }
    override public var isSelected: Bool {
        didSet {
            setFillState()
        }
    }
}


//MARK: FloatingRoundCheckbox Button
@IBDesignable
public class JDCheckboxButton: UIButton {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setImages()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setImages()
    }
    
    let checkedImage = UIImage(named: "asset-checked")
    let uncheckedImage = UIImage(named: "asset-unchecked")
    
    func setImages() {
        self.setImage(uncheckedImage, for: .normal)
        self.setImage(checkedImage, for: .selected)
    }
    func checkboxAnimation(closure: @escaping () -> Void){
        guard let image = self.imageView else {return}
        
        UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear, animations: {
            image.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            
        }) { (success) in
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear, animations: {
                self.isSelected = !self.isSelected
                //to-do
                closure()
                image.transform = .identity
            }, completion: nil)
        }
        
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


