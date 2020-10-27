//
//  ThemeTableCells.swift
//  Terra Heal
//
//  Created by Jaydeep Vyas on 11/09/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import Foundation
import UIKit


class TableCell: UITableViewCell {
    var parentVC: UIViewController? = nil
     var indexPath: IndexPath? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
}


struct CellShadowProperty {
    var radius: CGFloat = 19
    var color: UIColor =  UIColor.init(hex: "#3C80D116")
    var offset: CGSize = CGSize.init(width: 0.0, height: 12.0)
    var opacity: Float = 1.0
}

class ShadowTableCell: TableCell {
    var shadowProperty: CellShadowProperty = CellShadowProperty.init()
    @IBOutlet weak var vwCellBg: UIView!
       
}

struct SelectionBorderTableCellDetail {
    var id:String = ""
    var title:String = ""
    var isSelected:Bool = false
    var indexPath: IndexPath = IndexPath.init(row: -1, section: -1)
}

class SelectionBorderTableCell: ShadowTableCell {
   
    @IBOutlet weak var lblCellTitle: ThemeLabel!
    @IBOutlet weak var imgCellSelected: UIImageView!
    
   @IBInspectable open var radius : CGFloat = 15 {
        didSet{self.setupLayout()}
    }
    
    var cellBorderColor : UIColor = UIColor.themePrimary {
        didSet{ self.setupLayout()}
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblCellTitle?.setFont(name: FontName.Bold, size: FontSize.subHeader)
        self.vwCellBg?.backgroundColor = UIColor.white
    }
    
    func setData(title: String, isSelected: Bool) {
           self.lblCellTitle?.text = title
           self.isSelected = isSelected
           self.setupLayout()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupLayout()
           
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
           super.setSelected(selected, animated: animated)
    }
    
    func setupLayout() {
        //self.imgCellSelected?.setRound()
        if self.isSelected {
            self.imgCellSelected?.isHidden = false
            self.vwCellBg?.setRound(withBorderColor: self.cellBorderColor, andCornerRadious: JDDeviceHelper.offseter(offset: radius), borderWidth: 1.0)
            self.addShadow()
        } else {
            self.imgCellSelected?.isHidden = true
            self.vwCellBg?.setRound(withBorderColor: .clear, andCornerRadious: JDDeviceHelper.offseter(offset: radius), borderWidth: 1.0)
            self.vwCellBg?.removeShadow()
        }
    }
    
    
}

//MARK: Shadow Property
extension ShadowTableCell {
    
    func addShadow() {
        if shadowProperty.opacity != 0.0 {
                self.vwCellBg?.layer.masksToBounds = false
                self.vwCellBg?.layer.shadowRadius = shadowProperty.radius
                self.vwCellBg?.layer.shadowOpacity = shadowProperty.opacity
                self.vwCellBg?.layer.shadowOffset = shadowProperty.offset
                self.vwCellBg?.layer.shadowColor = shadowProperty.color.cgColor
        }
    }
}
