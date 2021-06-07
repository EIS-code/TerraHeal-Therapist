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
    @IBOutlet weak var btnSelect: JDRadioButton!
    @IBOutlet weak var vwCellBg: UIView!
    @IBOutlet weak var tblForAvailability: UITableView!
    @IBOutlet weak var hTblView: NSLayoutConstraint!
    var parentDialog: UIView? = nil
    var arrForData:[AvailabilityCellDetail] = [
        AvailabilityCellDetail.init(shiftName: "shift - 1", shiftTime: "10 - 12", availabilityStatus: .Available, isSelected: false),
        AvailabilityCellDetail.init(shiftName: "shift - 2", shiftTime: "12 - 14", availabilityStatus: .Available, isSelected: true),
        AvailabilityCellDetail.init(shiftName: "shift - 3", shiftTime: "12 - 16", availabilityStatus: .Available, isSelected: true),
        AvailabilityCellDetail.init(shiftName: "shift - 4", shiftTime: "16 - 18", availabilityStatus: .Available, isSelected: false),
        AvailabilityCellDetail.init(shiftName: "shift - 5", shiftTime: "16 - 20", availabilityStatus: .Available, isSelected: false),
        AvailabilityCellDetail.init(shiftName: "shift - 6", shiftTime: "20 - 24", availabilityStatus: .Available, isSelected: true),
        AvailabilityCellDetail.init(shiftName: "shift - 7", shiftTime: "00 - 08", availabilityStatus: .Available, isSelected: false),
        AvailabilityCellDetail.init(shiftName: "shift - 8", shiftTime: "08 - 04", availabilityStatus: .Available, isSelected: true),
    ]

    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblName?.setFont(name: FontName.Regular, size: FontSize.regular)
        self.setupAvailabilityView(tableView: self.tblForAvailability)
        self.imgCell.setRound()
        self.btnSelect.innerCircleCircleColor = UIColor.themeSecondary
    }

    func setData(data:AvailabilityCellDetail) {
        self.lblName?.setText("Therapist name")
        self.btnSelect.isSelected = true
        self.tblForAvailability.isHidden = false
        self.tblForAvailability.reloadData(heightToFit: self.hTblView) {
                //self.tblForAvailability.reloadData()
                //(self.parentDialog as! ExchangeOfferDialog).tblForAvailability.reloadData()
        }

    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.imgCell.setRound()
        self.vwCellBg.setRound(withBorderColor: .themePrimary, andCornerRadious: 9.0, borderWidth: 1.0)
        self.tblForAvailability.reloadData()

    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
