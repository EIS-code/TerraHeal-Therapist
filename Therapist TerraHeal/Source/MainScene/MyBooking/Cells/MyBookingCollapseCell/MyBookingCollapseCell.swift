//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

class MyBookingCollapseCell: TableCell {

    @IBOutlet weak var lblName: ThemeLabel!
    @IBOutlet weak var vwCollapse: UIView!
    @IBOutlet weak var btnAction: ThemeButton!
    @IBOutlet weak var ivForplace: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        self.lblName?.setFont(name: FontName.Bold, size: FontSize.subHeader)
        self.vwCollapse?.setRound(withBorderColor: .clear, andCornerRadious: 15.0, borderWidth: 1.0)
        self.btnAction?.setFont(name: FontName.SemiBold, size: FontSize.header)
        
    }

    func setData(data: BookingDetail ) {
        self.lblName.setText(Date.init(milliseconds: data.massageDateTime.toDouble).toString(format: "dd MMM yyyy hh:mm"))
        self.ivForplace.downloadedFrom(link: data.qrCodePath)
    }

    func setData(data: BookingData ) {
        self.lblName.setText(Date.init(milliseconds: data.massageDateTime.toDouble).toString(format: "dd MMM yyyy hh:mm"))
       // self.ivForplace.downloadedFrom(link: data.qrCodePath)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.vwCollapse?.setRound(withBorderColor: .clear, andCornerRadious: 15.0, borderWidth: 1.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}

