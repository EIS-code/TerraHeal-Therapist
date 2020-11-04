//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

class CreditCardTblCell: TableCell {

    @IBOutlet weak var lblName: ThemeLabel!
    @IBOutlet weak var btnDefult: ThemeButton!
    @IBOutlet weak var ivCard: UIImageView!
    @IBOutlet weak var lblCardValue: ThemeLabel!
    @IBOutlet weak var vwImgBg: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblName?.setFont(name: FontName.Bold, size: FontSize.subHeader)
        self.lblCardValue?.setFont(name: FontName.Regular, size: FontSize.subHeader)
        self.btnDefult?.setFont(name: FontName.Regular, size: FontSize.button_13)
        
    }

    func setData(data: CreditCardDetail ) {
        self.lblName.text = data.name
        self.lblCardValue.text = data.value
        self.btnDefult.isHidden = data.isSeleced
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutIfNeeded()
        self.btnDefult.setRound(withBorderColor: .clear, andCornerRadious: JDDeviceHelper.offseter(offset: 5), borderWidth: 1.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
