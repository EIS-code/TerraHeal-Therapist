//
//  KycInfoTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

class MyBookingTblSection: UITableViewHeaderFooterView {
    
    @IBOutlet weak var lblSelectDate: ThemeLabel!
    @IBOutlet weak var imgSelectDate: UIImageView!
    @IBOutlet weak var btnSelectDate: UIButton!
    @IBOutlet weak var imgFilterType: UIImageView!
    @IBOutlet weak var lblFilterType: ThemeLabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblSelectDate.setFont(name: FontName.Regular, size: FontSize.regular)
        self.lblFilterType.setFont(name: FontName.SemiBold, size: FontSize.subHeader)
        self.lblSelectDate.setText("HOME_SECTION_BTN_SELECT_DATE".localized())
        self.contentView.backgroundColor = UIColor.themeBackground
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
   
    
}

