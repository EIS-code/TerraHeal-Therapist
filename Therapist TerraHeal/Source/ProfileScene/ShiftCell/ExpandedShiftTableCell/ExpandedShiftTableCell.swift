//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

struct ShiftContainerCellDetail {
    var name:String = ""
    var image:String = ""
    var id:String = ""
    var shifts:[ShiftCellDetail] = []
    var date: String = ""
    var isSelected: Bool = false

    init(data:TherapistShiftData) {
        self.date = data.date
        self.name = data.name + " " + data.surname
        self.image = data.profilePhoto
        self.id = data.therapistId
        self.shifts = [ShiftCellDetail]()
        for dic in data.shifts {
            let value = ShiftCellDetail(shift: dic)
            self.shifts.append(value)
        }
    }

    init(data:AvailabilityData) {
        self.date = data.shiftDate
        self.name = data.shopName
        self.image = data.featuredImage
        self.id = data.shopId
        self.shifts = [ShiftCellDetail]()
        for dic in data.shifts {
            let value = ShiftCellDetail(shift: dic)
            self.shifts.append(value)
        }
    }
}

class ExpandedShiftTableCell: TableCell {

    @IBOutlet weak var imgCell: UIImageView!
    @IBOutlet weak var lblName: ThemeLabel!
    @IBOutlet weak var btnSelect: JDRadioButton!
    @IBOutlet weak var vwCellBg: UIView!
    @IBOutlet weak var tblForAvailability: UITableView!
    @IBOutlet weak var hTblView: NSLayoutConstraint!
    var shiftContainerData: ShiftContainerCellDetail? = nil
    weak var delegate: ShiftSelected?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblName?.setFont(name: FontName.Regular, size: FontSize.regular)
        self.setupTableView(tableView: self.tblForAvailability)
        self.imgCell.setRound()
        self.btnSelect.innerCircleCircleColor = UIColor.themeSecondary
        self.btnSelect.isUserInteractionEnabled = false
    }

    func setData(data:ShiftContainerCellDetail) {
        self.shiftContainerData = data
        self.lblName?.setText(data.name)
        self.imgCell.downloadedFrom(link: data.image)
        self.btnSelect.isSelected = true
        self.tblForAvailability.isHidden = false
        self.tblForAvailability.reloadData(heightToFit: self.hTblView) {
                self.tblForAvailability.reloadData()
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
