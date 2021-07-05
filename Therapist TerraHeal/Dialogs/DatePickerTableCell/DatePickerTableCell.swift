//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

class DatePickerTableCell: SelectionBorderTableCell {


    @IBOutlet weak var btnStartTime: UIButton!
    @IBOutlet weak var btnEndTime: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupTimer()
    }
    func setupTimer() {
        self.btnStartTime.setRound(withBorderColor: .themePrimary, andCornerRadious: 3.0, borderWidth: 1.0)
        self.btnEndTime.setRound(withBorderColor: .themePrimary, andCornerRadious: 3.0, borderWidth: 1.0)
        self.btnStartTime.setTitleColor(.themeSecondary, for: .normal)
        self.btnEndTime.setTitleColor(.themeSecondary, for: .normal)

    }

    override func layoutSubviews() {
        super.layoutSubviews()
       // self.vwBg?.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)

    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
