//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

class LanguageTableCell: SelectionBorderTableCell {

    @IBOutlet weak var lblName: ThemeLabel!
    @IBOutlet weak var lblFlag: ThemeLabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblName?.setFont(name: FontName.Bold, size: FontSize.subHeader)
    }

    func setData(data: LanguageDetail ) {
        self.lblName.text = data.name
        self.lblFlag.text = data.image
        super.setData(title: data.name, isSelected: data.isSelected)
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
