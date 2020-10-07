//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

class PersonPickerCell: TableCell {

    @IBOutlet weak var lblName: ThemeLabel!
    @IBOutlet weak var vwBg: UIView!
    @IBOutlet weak var ivSelected: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblName?.setFont(name: FontName.Bold, size: FontSize.subHeader)
        self.vwBg.backgroundColor = UIColor.white

        self.vwBg?.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
      
    }

    func setData(data: PersonData ) {
        self.lblName.setText(data.username)
        if data.isSelected {
            self.ivSelected.isHidden = false

            self.vwBg?.setRound(withBorderColor: .themePrimary, andCornerRadious: 10.0, borderWidth: 1.0)
        } else {
            self.ivSelected.isHidden = true
            self.vwBg?.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
        }


    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
