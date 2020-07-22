//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import Foundation
import UIKit

class ThemeView: UIView {
 
}




extension UIView {
    
    func applyTransform(withScale scale: CGFloat, anchorPoint: CGPoint) {
            layer.anchorPoint = anchorPoint
            let scale = scale != 0 ? scale : CGFloat.leastNonzeroMagnitude
            let xPadding = 1/scale * (anchorPoint.x - 0.5)*bounds.width
            let yPadding = 1/scale * (anchorPoint.y - 0.5)*bounds.height
            transform = CGAffineTransform(scaleX: scale, y: scale).translatedBy(x: xPadding, y: yPadding)
        }
    
    func height(constant: CGFloat) {
        setConstraint(value: constant, attribute: .height)
    }

    func width(constant: CGFloat) {
        setConstraint(value: constant, attribute: .width)
    }

    func setShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 5.0
        self.layer.shadowOpacity = 0.8
        self.layer.shadowOffset = CGSize(width: 1.0, height: -2.0)
        self.layer.shadowColor = UIColor.gray.cgColor
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
    
    func setAnchorPoint(_ anchorPoint: CGPoint) {
        var newPoint: CGPoint = CGPoint.init(x: self.bounds.size.width * anchorPoint.x, y: self.bounds.size.height * anchorPoint.y)
        var oldPoint: CGPoint = CGPoint.init(x: self.bounds.size.width * self.layer.anchorPoint.x, y: self.bounds.size.height * self.layer.anchorPoint.y)
        newPoint = newPoint.applying(self.transform)
        oldPoint = oldPoint.applying(self.transform)
        var position: CGPoint = self.layer.position
        position.x -= oldPoint.x
        position.x += newPoint.x
        position.y -= oldPoint.y
        position.y += newPoint.y
        self.translatesAutoresizingMaskIntoConstraints = true
        self.layer.anchorPoint = anchorPoint
        self.layer.position = position
    }
}
//MARK: Dashed UIView
extension UIView {

    func createDashedLine(from point1: CGPoint, to point2: CGPoint, color: UIColor, strokeLength: NSNumber, gapLength: NSNumber, width: CGFloat) {
        let shapeLayer = CAShapeLayer()

        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = width
        shapeLayer.lineDashPattern = [strokeLength, gapLength]

        let path = CGMutablePath()
        path.addLines(between: [point1, point2])
        shapeLayer.path = path
        shapeLayer.name = "dashed"
        if let oldLayer:  CAShapeLayer = layer.sublayers?.last(where: { (currentLayer) -> Bool in
            return currentLayer.name == "dashed"
        }) as?  CAShapeLayer {
            oldLayer.removeFromSuperlayer()
        }
        layer.addSublayer(shapeLayer)
    }

}
class DashedLineView: UIView {

    private let borderLayer = CAShapeLayer()
    private let radius: CGFloat = 10

    override func awakeFromNib() {

        super.awakeFromNib()

        borderLayer.strokeColor = UIColor.themePrimary.cgColor
        borderLayer.lineDashPattern = [3,3]
        borderLayer.backgroundColor = UIColor.clear.cgColor
        borderLayer.fillColor = UIColor.clear.cgColor

        layer.addSublayer(borderLayer)
    }

    override func draw(_ rect: CGRect) {

        borderLayer.path = UIBezierPath(roundedRect: rect, cornerRadius: radius).cgPath
        print("\(self)-\(rect)")
    }
}


//MARK:- Shake
extension UIView {
    func shake() {
        let force = 1.0
        let animation = CAKeyframeAnimation()
        animation.keyPath = "transform.rotation"
        animation.values = [0, 0.2*force, -0.2*force, 0.3*force, 0]
        animation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
        animation.duration = CFTimeInterval(0.3)
        animation.isAdditive = true
        animation.repeatCount = 1
        animation.beginTime = CACurrentMediaTime() + CFTimeInterval(0.1)
        layer.add(animation, forKey: "swing")
    }
}

//MARK:- Custom Segment Control
class CustomSegmentedControl: UISegmentedControl {

    override func layoutSubviews(){

        super.layoutSubviews()

        //corner radius
        let cornerRadius = bounds.height/2
        let maskedCorners: CACornerMask = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        //background
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = maskedCorners
        //foreground
        let foregroundIndex = numberOfSegments
        if subviews.indices.contains(foregroundIndex), let foregroundImageView = subviews[foregroundIndex] as? UIImageView
        {
            foregroundImageView.bounds = foregroundImageView.bounds.insetBy(dx: 5, dy: 5)
            foregroundImageView.image = UIImage()
            foregroundImageView.highlightedImage = UIImage()
            foregroundImageView.backgroundColor = UIColor.themePrimary
            foregroundImageView.clipsToBounds = true
            foregroundImageView.layer.masksToBounds = true

            foregroundImageView.layer.cornerRadius = 14
            foregroundImageView.layer.maskedCorners = maskedCorners
        }
    }
}

@IBDesignable class PaddedImageView: UIImageView {
    @IBInspectable open var padding: CGFloat = 0 {
        didSet{
            self.setPadding(padding: self.padding)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setPadding(padding: self.padding)
    }
    
    override init(image: UIImage?) {
        super.init(image: nil)
        self.setPadding(padding: self.padding)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setPadding(padding: self.padding)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        //self.setPadding(padding: self.padding)
    }
    func setPadding(padding:CGFloat) {
            self.image = self.image?.imageWithInsets(insetDimen: padding)
    }
}

extension UIImage {
    func imageWithInsets(insetDimen: CGFloat) -> UIImage {
        return imageWithInset(insets: UIEdgeInsets(top: insetDimen, left: insetDimen, bottom: insetDimen, right: insetDimen))
    }
    
    func imageWithInset(insets: UIEdgeInsets) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(
            CGSize(width: self.size.width + insets.left + insets.right,
                   height: self.size.height + insets.top + insets.bottom), false, self.scale)
        let origin = CGPoint(x: insets.left, y: insets.top)
        self.draw(at: origin)
        let imageWithInsets = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return imageWithInsets!
    }
    
}

