//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

class MyBookingExpandTblCell: TableCell {

    @IBOutlet weak var vwExpanded: UIView!
    @IBOutlet weak var vwDate: UIView!
    @IBOutlet weak var lblDate: ThemeLabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var htblVw: NSLayoutConstraint!
    @IBOutlet weak var lblBookingTime: ThemeLabel!
    @IBOutlet weak var lblDelayTime: ThemeLabel!
    @IBOutlet weak var lblBookingDetail: ThemeLabel!
    @IBOutlet weak var lblBookingTypeValue: ThemeLabel!
    @IBOutlet weak var lblCenterName: ThemeLabel!
    @IBOutlet weak var lblCenterAddress: ThemeLabel!
    @IBOutlet weak var lblBookDateAndTime: ThemeLabel!
    @IBOutlet weak var ivForQr: UIImageView!
    @IBOutlet weak var lblbSessionDetail: ThemeLabel!
    @IBOutlet weak var lblSessionValue: ThemeLabel!
    var arrForData: [MyBookingUserPeople] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblDate?.setFont(name: FontName.Bold, size: FontSize.subHeader)
        self.vwExpanded?.setRound(withBorderColor: .clear, andCornerRadious: 15.0, borderWidth: 1.0)
        self.vwDate?.setRound(withBorderColor: .clear, andCornerRadious: 15, borderWidth: 1.0)
        self.lblBookingTime.setFont(name: FontName.Regular, size: FontSize.detail)
        self.lblDelayTime.setFont(name: FontName.Regular, size: FontSize.detail)
        self.lblBookingDetail.setFont(name: FontName.SemiBold, size: FontSize.subHeader)
        self.lblBookingTypeValue.setFont(name: FontName.Regular, size: FontSize.detail)
        self.lblCenterName.setFont(name: FontName.Regular, size: FontSize.detail)
        self.lblCenterAddress.setFont(name: FontName.Regular, size: FontSize.detail)
        self.lblBookDateAndTime.setFont(name: FontName.Regular, size: FontSize.detail)
        self.lblbSessionDetail.setFont(name: FontName.SemiBold, size: FontSize.subHeader)
        self.lblSessionValue.setFont(name: FontName.Regular, size: FontSize.detail)
        self.setupTableView(tableView: self.tableView)
    }

    func setData(data:BookingDetail) {

        let bookingDate = Date.init(milliseconds: data.massageDate.toDouble).toString(format: "dd MMM yyyy")
        let bookingTime = Date.init(milliseconds: data.massageStartTime.toDouble).toString(format: "hh:mm")

        let bookingDateTime = Date.init(milliseconds:  data.massageDate.toDouble).toString(format: "hh:mm | EEE, dd MMM yyyy")

        let people = MyBookingUserPeople.init(fromDictionary: [:])
        people.age = data.clientAge
        people.name = data.clientName
        people.gender = data.clientGender
        let bookingMassage = MyBookingMassage.init(fromDictionary: [:])
        bookingMassage.name = data.serviceName
        bookingMassage.time = data.massageDuration
        people.bookingMassages = [bookingMassage]
        self.arrForData = [people]

        self.lblDate?.setText(bookingDate)
        self.lblBookingTime.setText("booked: \(bookingTime)")
        self.lblDelayTime.setText("")
        self.lblBookingDetail.setText("Booking Details")

        self.lblBookingTypeValue.setText(BookingType.init(rawValue: data.bookingType)?.name())
        self.lblCenterName.setText(data.shopName)
        self.lblCenterAddress.setText(data.shopAddress)
        self.lblBookDateAndTime.setText(bookingDateTime)
        self.lblSessionValue.setText(data.sessionType)

        self.tableView.reloadData(heightToFit: self.htblVw) {
            self.layoutIfNeeded()
            self.vwExpanded?.setRound(withBorderColor: .clear, andCornerRadious: 15.0, borderWidth: 1.0)
            self.vwDate?.setRound(withBorderColor: .clear, andCornerRadious: 15, borderWidth: 1.0)
            print(#function)
        }
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.tableView.reloadData(heightToFit: self.htblVw) {
            self.layoutIfNeeded()
            self.vwExpanded?.setRound(withBorderColor: .clear, andCornerRadious: 15.0, borderWidth: 1.0)
            self.vwDate?.setRound(withBorderColor: .clear, andCornerRadious: 15, borderWidth: 1.0)
            print(#function)
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
