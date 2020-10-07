//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

class CustomCountryPhoneCodePickerCell: TableCell {



    @IBOutlet weak var countryFlag: ThemeLabel!
    @IBOutlet weak var lblCountryPhoneCode: ThemeLabel!
    @IBOutlet weak var lblCountryName: ThemeLabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.lblCountryName?.setFont(name: FontName.Bold, size: FontSize.subHeader)
        self.lblCountryPhoneCode?.setFont(name: FontName.Bold, size: FontSize.subHeader)
    }

    func setData(data: CountryPhone ) {
        self.lblCountryName.setText(data.countryName)
        self.lblCountryPhoneCode.setText(data.countryPhoneCode)
        self.countryFlag.setText(data.countryFlag)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
