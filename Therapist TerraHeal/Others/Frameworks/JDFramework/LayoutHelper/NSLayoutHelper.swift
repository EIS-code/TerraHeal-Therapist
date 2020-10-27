//  NSLayoutHelper.swift
//  Layout Helper
//
//  Created by Kuldeep Tanwar on 4/15/19.
//  Copyright © 2019 Kuldeep Tanwar. All rights reserved.
import UIKit


@IBDesignable class NSLayoutHelper : NSLayoutConstraint {
   
  
    
    @IBInspectable var isVerticalDirection: Bool = true {
        didSet { deviceConstant(value:iPhone11Pro, isVerticalDirection: isVerticalDirection) }
    }
    @IBInspectable var iPhone11Pro: CGFloat = 0.0 {
        didSet { deviceConstant(value:iPhone11Pro) }
    }
    open func deviceConstant(value:CGFloat, isVerticalDirection:Bool = true) {
        if self.isVerticalDirection{
                constant = JDDeviceHelper.offseter(scaleFactor: 1.0, offset: value, direction: .vertical)
        } else {
            constant = JDDeviceHelper.offseter(scaleFactor: 1.0, offset: value, direction: .horizontal)
        }
    }
}

extension UIView {
    
    
    func height(constant: CGFloat, isAuto:Bool = true, direction:Direction = .vertical) {
        var newConstant =  constant
        if isAuto {
            newConstant = JDDeviceHelper.offseter(scaleFactor: 1.0, offset: constant, direction: direction)
        }
        setConstraint(value: newConstant, attribute: .height)
    }

    func width(constant: CGFloat, isAuto:Bool = true, direction:Direction = .horizontal) {
        var newConstant =  constant
        if isAuto {
            newConstant = JDDeviceHelper.offseter(scaleFactor: 1.0, offset: constant, direction: direction)
        }
        setConstraint(value: newConstant, attribute: .width)
    }

    func leftPadding(constant: CGFloat, isAuto:Bool = true, direction:Direction = .horizontal) {
        var newConstant =  constant
        if isAuto {
            newConstant = JDDeviceHelper.offseter(scaleFactor: 1.0, offset: constant, direction: direction)
        }
        setConstraint(value: newConstant, attribute: .leading)
    }
    func rightPadding(constant: CGFloat, isAuto:Bool = true, direction:Direction = .horizontal) {
        var newConstant =  constant
        if isAuto {
            newConstant = JDDeviceHelper.offseter(scaleFactor: 1.0, offset: constant, direction: direction)
        }
        setConstraint(value: newConstant, attribute: .trailing)
    }
    func topPadding(constant: CGFloat, isAuto:Bool = true, direction:Direction = .vertical) {
        var newConstant =  constant
        if isAuto {
            newConstant = JDDeviceHelper.offseter(scaleFactor: 1.0, offset: constant, direction: direction)
        }
        setConstraint(value: newConstant, attribute: .top)
    }
    func bottomPadding(constant: CGFloat, isAuto:Bool = true, direction:Direction = .vertical) {
        var newConstant =  constant
        if isAuto {
            newConstant = JDDeviceHelper.offseter(scaleFactor: 1.0, offset: constant, direction: direction)
        }
        setConstraint(value: newConstant, attribute: .bottom)
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
                               relatedBy: NSLayoutConstraint.Relation.greaterThanOrEqual,
                               toItem: nil,
                               attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                               multiplier: 1,
                               constant: value)
        self.addConstraint(constraint)
    }
}
