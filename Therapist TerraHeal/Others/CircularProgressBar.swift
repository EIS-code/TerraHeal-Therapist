//
//  CircularProgressBar.swift
//  Therapist TerraHeal
//
//  Created by Jaydeep Vyas on 24/07/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import Foundation
import UIKit

class CircularProgressView: UIView {
    var progressLyr = CAShapeLayer()
    var fromValue = 0.0
    var progress: Float  = 0.0
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeCircularPath()
    }
    var progressClr = UIColor.white {
        didSet {
            progressLyr.strokeColor = progressClr.cgColor
        }
    }
    
    func makeCircularPath() {
        self.backgroundColor = UIColor.clear
        self.layer.cornerRadius = self.bounds.size.width/2
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: bounds.size.width/2, y: bounds.size.height/2), radius: (bounds.size.width - 1.5)/2, startAngle: CGFloat(-0.5 * .pi), endAngle: CGFloat(1.5 * .pi), clockwise: true)
        progressLyr.path = circlePath.cgPath
        progressLyr.fillColor = UIColor.clear.cgColor
        progressLyr.strokeColor = progressClr.cgColor
        progressLyr.lineWidth = 10.0
        //progressLyr.strokeEnd = 0.0
        progressLyr.name = "progressLayer"
   }
    
    func setProgressWithAnimation(duration: TimeInterval, value: Float) {
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
       /* guard let layers = self.layer.sublayers else {
            return
        }
        for layer:CALayer in layers {
            if layer.name == "progressLayer" {
                       layer.removeFromSuperlayer()
            }
        }*/
        layer.addSublayer(progressLyr)
        animation.duration = duration
        animation.fromValue = self.fromValue
        animation.toValue = value
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        progressLyr.strokeEnd = CGFloat(value)
        self.fromValue = Double(value)
        self.progress = value
        progressLyr.add(animation, forKey: "animateprogress")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        makeCircularPath()
    }
}
