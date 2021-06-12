//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

class ExchangeOfferRequestTblCell: TableCell {

    @IBOutlet weak var imgCell: UIImageView!
    @IBOutlet weak var lblName: ThemeLabel!
    @IBOutlet weak var vwCellBg: UIView!
    @IBOutlet weak var lblTime: ThemeLabel!
    @IBOutlet weak var vwMyShift: UIView!
    @IBOutlet weak var vwExchangeShift: UIView!
    @IBOutlet weak var lblMyShift: ThemeLabel!
    @IBOutlet weak var lblMyShiftTime: ThemeLabel!
    @IBOutlet weak var lblExchangeShift: ThemeLabel!
    @IBOutlet weak var lblExchangeShiftTime: ThemeLabel!
    @IBOutlet weak var btnAccept: FilledRoundedButton!
    @IBOutlet weak var btnReject: FilledRoundedButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblName?.setFont(name: FontName.SemiBold, size: FontSize.regular)
        self.lblTime?.setFont(name: FontName.Regular, size: FontSize.small)
        self.lblMyShift?.setFont(name: FontName.SemiBold, size: FontSize.regular)
        self.lblMyShiftTime?.setFont(name: FontName.SemiBold, size: FontSize.regular)
        self.lblExchangeShift?.setFont(name: FontName.SemiBold, size: FontSize.regular)
        self.lblExchangeShiftTime?.setFont(name: FontName.SemiBold, size: FontSize.regular)
        self.imgCell.setRound()
        self.btnAccept.setText("EXCHANGE_OFFER_REQUEST_BTN_ACCEPT".localized())
        self.btnReject.setText("EXCHANGE_OFFER_REQUEST_BTN_REJECT".localized())
        self.lblName.setText("EXCHANGE_OFFER_REQUEST_MESSAGE".localized())
        self.btnReject.fillButton(backgroundColor: .rejectColor)
        self.btnAccept.fillButton(backgroundColor: .acceptColor)
    }

    func setData(data:ExchangeShiftData) {
        self.lblName.setText("EXCHANGE_OFFER_REQUEST_MESSAGE".localized() + data.withShift.therapistName)
        let strTime = Date.init(milliseconds: data.date.toDouble).toString(format: "hh:mm")
        self.lblTime?.setText(strTime)
        self.lblMyShift?.setText("Your Shift - " + data.yourShift.shiftId)
        self.lblMyShiftTime?.setText(data.yourShift.shiftStartTime + " - " + data.yourShift.shiftEndTime)
        self.lblExchangeShift?.setText("Exchange With Shift")
        self.lblExchangeShiftTime?.setText(data.withShift.shiftStartTime + " - " + data.withShift.shiftEndTime)
        self.imgCell.setRound()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.imgCell.setRound()
        self.vwCellBg.setRound(withBorderColor: .clear, andCornerRadious: 9.0, borderWidth: 1.0)
        self.vwMyShift.setRound(withBorderColor: .clear, andCornerRadious: 9.0, borderWidth: 1.0)
        self.vwExchangeShift.setRound(withBorderColor: .clear, andCornerRadious: 9.0, borderWidth: 1.0)

    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
