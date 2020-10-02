//
//  Theme.swift
//  Terra Heal
//
//  Created by Jaydeep Vyas on 18/08/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import Foundation
import UIKit

class FadeScrollView: UIScrollView, UIScrollViewDelegate {
    
    let fadePercentage: Double = 0.25
    let gradientLayer = CAGradientLayer()
    let transparentColor = UIColor.clear.cgColor
    let opaqueColor = UIColor.black.cgColor
    
    var topOpacity: CGColor {
        let scrollViewHeight = frame.size.height
        let scrollContentSizeHeight = contentSize.height
        let scrollOffset = contentOffset.y
        let alpha:CGFloat = (scrollViewHeight >= scrollContentSizeHeight || scrollOffset <= 0) ? 1 : 0
        let color = UIColor(white: 0, alpha: alpha)
        return color.cgColor
    }
    
    var bottomOpacity: CGColor {
        let scrollViewHeight = frame.size.height
        let scrollContentSizeHeight = contentSize.height
        let scrollOffset = contentOffset.y
        
        let alpha:CGFloat = (scrollViewHeight >= scrollContentSizeHeight || scrollOffset + scrollViewHeight >= scrollContentSizeHeight) ? 1 : 0
        
        let color = UIColor(white: 0, alpha: alpha)
        return color.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.delegate = self
        let maskLayer = CALayer()
        maskLayer.frame = self.bounds
        gradientLayer.frame = CGRect(x: self.bounds.origin.x, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
        gradientLayer.colors = [topOpacity, opaqueColor, opaqueColor, bottomOpacity]
        gradientLayer.locations = [0, NSNumber(floatLiteral: fadePercentage), NSNumber(floatLiteral: 1 - fadePercentage), 1]
        maskLayer.addSublayer(gradientLayer)
        self.layer.mask = maskLayer
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        gradientLayer.colors = [topOpacity, opaqueColor, opaqueColor, bottomOpacity]
    }
    
}

class FadeTableView: UITableView, UIScrollViewDelegate {
    
    let gradientLayer = CAGradientLayer()
    let transparentColor = UIColor.clear.cgColor
    let opaqueColor = UIColor.black.cgColor
    @IBInspectable open var fadePercentage : Double = 0.25 {
        didSet{
            self.addGradient()
        }
    }
    @IBInspectable open var topInset : CGFloat = 100 {
        didSet{
            self.addGradient()
        }
    }
    @IBInspectable open var bottomInset : CGFloat = 100 {
        didSet{
            self.addGradient()
        }
    }
    var topOpacity: CGColor {
        let scrollViewHeight = frame.size.height
        let scrollContentSizeHeight = contentSize.height
        let scrollOffset = contentOffset.y
        let alpha:CGFloat = (scrollViewHeight >= scrollContentSizeHeight || scrollOffset <= 0) ? 1 : 0
        let color = UIColor(white: 0, alpha: alpha)
        return color.cgColor
    }
    
    var bottomOpacity: CGColor {
        let scrollViewHeight = frame.size.height
        let scrollContentSizeHeight = contentSize.height
        let scrollOffset = contentOffset.y
        let alpha:CGFloat = (scrollViewHeight >= scrollContentSizeHeight || scrollOffset + scrollViewHeight >= scrollContentSizeHeight) ? 1 : 0
        let color = UIColor(white: 0, alpha: alpha)
        return color.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addGradient()
        self.contentInset = UIEdgeInsets(top: topInset , left: 0.0, bottom: bottomInset, right: 0.0)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.addGradient()
    }
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.addGradient()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addGradient()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.updateColors()
    }
    
    func updateColors() {
        gradientLayer.colors = [topOpacity, opaqueColor, opaqueColor, bottomOpacity]
        gradientLayer.locations = [0, NSNumber(floatLiteral: fadePercentage), NSNumber(floatLiteral: 1 - fadePercentage), 1]
    }
    
    func addGradient() {
        let maskLayer = CALayer()
        maskLayer.frame = self.bounds
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
        self.updateColors()
        maskLayer.addSublayer(gradientLayer)
        self.layer.mask = maskLayer
    }
}

class FadeCollectionView: UICollectionView, UIScrollViewDelegate {
    
    let gradientLayer = CAGradientLayer()
    let transparentColor = UIColor.clear.cgColor
    let opaqueColor = UIColor.black.cgColor
    @IBInspectable open var fadePercentage : Double = 0.25 {
        didSet{
            self.addGradient()
        }
    }
    @IBInspectable open var topInset : CGFloat = 100 {
        didSet{
            self.addGradient()
        }
    }
    @IBInspectable open var bottomInset : CGFloat = 100 {
        didSet{
            self.addGradient()
        }
    }
    var topOpacity: CGColor {
        let scrollViewHeight = frame.size.height
        let scrollContentSizeHeight = contentSize.height
        let scrollOffset = contentOffset.y
        let alpha:CGFloat = (scrollViewHeight >= scrollContentSizeHeight || scrollOffset <= 0) ? 1 : 0
        let color = UIColor(white: 0, alpha: alpha)
        return color.cgColor
    }
    
    var bottomOpacity: CGColor {
        let scrollViewHeight = frame.size.height
        let scrollContentSizeHeight = contentSize.height
        let scrollOffset = contentOffset.y
        let alpha:CGFloat = (scrollViewHeight >= scrollContentSizeHeight || scrollOffset + scrollViewHeight >= scrollContentSizeHeight) ? 1 : 0
        let color = UIColor(white: 0, alpha: alpha)
        return color.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addGradient()
        self.contentInset = UIEdgeInsets(top: topInset , left: 0.0, bottom: bottomInset, right: 0.0)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.addGradient()
    }
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.addGradient()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addGradient()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.updateColors()
    }
    
    func updateColors() {
        gradientLayer.colors = [UIColor.red.cgColor,UIColor.green.cgColor,UIColor.green.cgColor,UIColor.red.cgColor]//[topOpacity, opaqueColor, opaqueColor, bottomOpacity]
        gradientLayer.locations = [0, NSNumber(floatLiteral: fadePercentage), NSNumber(floatLiteral: 1 - fadePercentage), 1]
    }
    
    func addGradient() {
        let maskLayer = CALayer()
        maskLayer.frame = self.bounds
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
        self.updateColors()
        maskLayer.addSublayer(gradientLayer)
        self.layer.mask = maskLayer
    }
}
