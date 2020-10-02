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
        self.lblSelectDate.setFont(name: FontName.Bold, size: FontSize.header)
        self.lblFilterType.setFont(name: FontName.Bold, size: FontSize.header)
        self.lblSelectDate.text = "HOME_SECTION_BTN_SELECT_DATE".localized()
    }
    

    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
 
}

