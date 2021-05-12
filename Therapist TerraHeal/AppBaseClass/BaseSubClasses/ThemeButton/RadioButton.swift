//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import Foundation
import UIKit



//MARK: RadioButton
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
            innerCircleLayer.fillColor =  self.innerCircleCircleColor.cgColor  //UIColor.themePrimary.cgColor
        } else {
            innerCircleLayer.fillColor = UIColor.themePrimaryLightBackground.cgColor
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
