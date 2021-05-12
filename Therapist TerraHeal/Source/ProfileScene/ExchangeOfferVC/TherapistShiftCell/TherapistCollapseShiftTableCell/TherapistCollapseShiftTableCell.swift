//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

class TherapistCollapseShiftTableCell: TableCell {

    @IBOutlet weak var imgCell: UIImageView!
    @IBOutlet weak var lblTherapistName: ThemeLabel!
    @IBOutlet weak var btnSelectTherapist: JDRadioButton!
    @IBOutlet weak var vwCellBg: UIView!
    var parentDialog: UIView? = nil


    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblTherapistName?.setFont(name: FontName.Regular, size: FontSize.regular)
        self.imgCell.setRound()
    }

    func setData(data:AvailabilityCellDetail) {
        self.lblTherapistName?.setText("Therapist name")
        self.btnSelectTherapist.isSelected = false
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.imgCell.setRound()
        self.vwCellBg.setRound(withBorderColor: .themePrimary, andCornerRadious: 9.0, borderWidth: 1.0)

    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
