//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit


class BookingDetailTblCell: TableCell {

    @IBOutlet weak var lblDetail: ThemeLabel!
    @IBOutlet weak var vwBg: UIView!
    @IBOutlet weak var lblTitle: ThemeLabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblTitle?.setFont(name: FontName.Bold, size: FontSize.header)
        self.lblDetail?.setFont(name: FontName.SemiBold, size: FontSize.subHeader)
        self.vwBg?.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
    }

    func setData(data: BookingDetail ) {
        self.lblTitle.setText(data.title)
        self.lblDetail.setText(data.detail)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
