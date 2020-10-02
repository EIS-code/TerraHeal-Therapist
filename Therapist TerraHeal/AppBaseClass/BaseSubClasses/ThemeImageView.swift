//
//  ThemeImageView.swift
//  Terra Heal
//
//  Created by Jaydeep Vyas on 17/08/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import Foundation
import UIKit


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

@IBDesignable class RoundedImageView: UIImageView {
    @IBInspectable open var enableFloating: Bool = true
    @IBInspectable open var enablePadding: Bool = true
    @IBInspectable open var padding: CGFloat = 0 {
        didSet{
            self.setPadding(padding: self.padding)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        if enableFloating {
            self.setUpFloating()
        }
        if enablePadding {
         self.setPadding(padding: self.padding)
        }
        
    }
    
    override init(image: UIImage?) {
        super.init(image: nil)
        if enableFloating {
            self.setUpFloating()
        }
        if enablePadding {
         self.setPadding(padding: self.padding)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        if enableFloating {
            self.setUpFloating()
        }
        if enablePadding {
         self.setPadding(padding: self.padding)
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        if enableFloating {
            self.layer.cornerRadius = self.bounds.height/2.0
        }
        //self.setPadding(padding: self.padding)
    }
    
    func setUpFloating() {
        self.clipsToBounds = true
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 5.0
        self.layer.shadowOpacity = 0.8
        self.layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
        self.layer.shadowColor = UIColor.gray.cgColor
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
    func imageWithImage(scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}

