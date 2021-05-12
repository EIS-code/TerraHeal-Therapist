//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

class ShiftTableCell: TableCell {

    @IBOutlet weak var lblShifName: ThemeLabel!
    @IBOutlet weak var lblTime: ThemeLabel!
    @IBOutlet weak var btnSelectShift: UIButton!
    @IBOutlet weak var vwCellBg: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblShifName?.setFont(name: FontName.Regular, size: FontSize.regular)
        self.lblTime?.setFont(name: FontName.Bold, size: FontSize.subHeader)
        self.vwCellBg.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
        self.btnSelectShift.setRound(withBorderColor: .clear, andCornerRadious: 5.0, borderWidth: 1.0)
    }

    func setData(data:AvailabilityCellDetail) {
        self.lblShifName.setText(data.shiftName)
        self.lblTime.setText(data.shiftTime)
        if data.isSelected {
            self.btnSelectShift.setImage(ImageAsset.getImage(ImageAsset.Button.shiftSelected), for: .normal)
        } else {
            self.btnSelectShift.setImage(nil, for: .normal)
        }


    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.vwCellBg?.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)

    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
