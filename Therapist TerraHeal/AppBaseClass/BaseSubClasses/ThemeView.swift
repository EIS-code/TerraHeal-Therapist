//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import Foundation
import UIKit

class ThemeView: UIView {
    
    
}


class ThemeCardView: UIView {
    var gradientLayer: CAGradientLayer? = nil
    var gradientColor: [UIColor] = []

    
    func addGradientFade(colors:[Any]) {
            gradientLayer =  CAGradientLayer()
            gradientLayer!.frame = self.bounds
            //gradientLayer!.colors = colors
            gradientLayer!.name = "gradient"
            if let oldLayer:  CAGradientLayer = self.layer.sublayers?.last(where: { (currentLayer) -> Bool in
                    return currentLayer.name == "gradient"
                }) as?  CAGradientLayer
            {
                oldLayer.removeFromSuperlayer()
            }
            self.layer.addSublayer(gradientLayer!)
            //self.setShadow(radius: 20, opacity: 1.0, offset: CGSize.zero, color: UIColor.init(hex: "#0000001F"))
    }

    func topRound() {
         //self.roundCorners(corners: [.topLeft,.topRight], radius: 45.0)
         self.layer.cornerRadius = 45
         self.layer.borderColor = UIColor.init(hex: "#F6F6F4").cgColor
         self.setShadow(radius: 20, opacity: 1.0, offset: CGSize.zero, color: UIColor.init(hex: "#0000001F"))

    }


}



class ThemeTopGradientView: UIView {
    var gradientLayer: CAGradientLayer? = nil
    @IBInspectable open var enableGradient : Bool = false {
        didSet{
            self.addGradientFade()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.addGradientFade()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = .clear
        self.addGradientFade()
    }
    override func layoutSubviews() {
        self.gradientLayer?.frame = self.bounds
    }
    
    func addGradientFade() {
        if enableGradient {
            gradientLayer =  CAGradientLayer()
            let gradientColor = UIColor.white
            gradientLayer!.frame = self.bounds
            gradientLayer!.colors = [gradientColor.withAlphaComponent(1.0).cgColor,gradientColor.withAlphaComponent(0.8).cgColor, gradientColor.withAlphaComponent(0.5).cgColor,gradientColor.withAlphaComponent(0.0).cgColor]
            gradientLayer!.name = "gradient"
            
            if let oldLayer:  CAGradientLayer = self.layer.sublayers?.last(where: { (currentLayer) -> Bool in
                return currentLayer.name == "gradient"
            }) as?  CAGradientLayer {
                oldLayer.removeFromSuperlayer()
            }
            self.layer.addSublayer(gradientLayer!)
        } else {
            gradientLayer = nil
        }
    }
}

class ThemeBottomGradientView: UIView {
    var gradientLayer: CAGradientLayer? = nil
    @IBInspectable open var enableGradient : Bool = false {
        didSet{
            self.addGradientFade()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.addGradientFade()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = .clear
        self.addGradientFade()
    }
    override func layoutSubviews() {
        self.gradientLayer?.frame = self.bounds
    }
    
    func addGradientFade() {
        if enableGradient {
            gradientLayer =  CAGradientLayer()
            let gradientColor = UIColor.white
            gradientLayer!.frame = self.bounds
            gradientLayer!.colors = [gradientColor.withAlphaComponent(0.0).cgColor,gradientColor.withAlphaComponent(0.5).cgColor, gradientColor.withAlphaComponent(0.8).cgColor,gradientColor.withAlphaComponent(1.0).cgColor]
            gradientLayer!.name = "gradient"
            
            if let oldLayer:  CAGradientLayer = self.layer.sublayers?.last(where: { (currentLayer) -> Bool in
                return currentLayer.name == "gradient"
            }) as?  CAGradientLayer {
                oldLayer.removeFromSuperlayer()
            }
            self.layer.addSublayer(gradientLayer!)
        } else {
            gradientLayer = nil
        }
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

