//
//  COLLECTIONCELL.swift
//  Terra Heal
//
//  Created by Jaydeep Vyas on 15/09/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import Foundation
import UIKit

struct CollectionCellShadowProperty {
    var radius: CGFloat = 10
    var color: UIColor = UIColor.init(hex: "#00000026")
    var offset: CGSize = CGSize.init(width: 0.0, height: 3.0)
    var opacity: Float = 1.0
}

class CollectionShadowCell: CollectionCell {
    var shadowProperty: CellShadowProperty = CellShadowProperty.init()
    @IBInspectable open var radius : CGFloat = 10 {
           didSet{self.setupLayout()}
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    func setupLayout() {
         
    }
    
}

class SelectionBorderCollectionCell: CollectionShadowCell {
    
    @IBOutlet weak var vwCellBg: UIView!
    @IBOutlet weak var imgCellSelected: UIImageView!
    var cellBorderColor : UIColor = UIColor.themePrimary {
        didSet{ self.setupLayout()}
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.vwCellBg?.backgroundColor = UIColor.white
    }
    
    func setData(isSelected: Bool) {
        self.isSelected = isSelected
        self.setupLayout()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupLayout()
           
    }
    
    
    override func setupLayout() {
        super.setupLayout()
        //self.imgCellSelected?.setRound()
        if self.isSelected {
            self.imgCellSelected?.isHidden = false
            self.vwCellBg?.setRound(withBorderColor: self.cellBorderColor, andCornerRadious: JDDeviceHelper.offseter(offset: radius), borderWidth: 1.0)
            self.addShadow(viewForShadow: self.vwCellBg)
        } else {
            self.imgCellSelected?.isHidden = true
            self.vwCellBg?.setRound(withBorderColor: .clear, andCornerRadious: JDDeviceHelper.offseter(offset: radius), borderWidth: 1.0)
            self.vwCellBg?.removeShadow()
        }
    }
    
    
}

//MARK: Shadow Property
extension CollectionShadowCell {
    
    func addShadow(viewForShadow: UIView?) {
        if shadowProperty.opacity != 0.0 {
                viewForShadow?.layer.masksToBounds = false
                viewForShadow?.layer.shadowRadius = shadowProperty.radius
                viewForShadow?.layer.shadowOpacity = shadowProperty.opacity
                viewForShadow?.layer.shadowOffset = shadowProperty.offset
                viewForShadow?.layer.shadowColor = shadowProperty.color.cgColor
        }
    }
}
