//
//  KycInfoTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

class MyBookingTblSection: UITableViewHeaderFooterView {
    
    @IBOutlet weak var lblSelectDate: ThemeLabel!
    @IBOutlet weak var imgSelectDate: UIImageView!
    @IBOutlet weak var btnSelectDate: UIButton!
    @IBOutlet weak var imgFilterType: UIImageView!
    @IBOutlet weak var lblFilterType: ThemeLabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblSelectDate.setFont(name: FontName.Regular, size: FontSize.regular)
        self.lblFilterType.setFont(name: FontName.SemiBold, size: FontSize.subHeader)
        self.lblSelectDate.text = "HOME_SECTION_BTN_SELECT_DATE".localized()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
    @IBAction func btnSelectDateTapped(_ sender: Any) {
        self.openDatePicker()
    }

    @objc func openDatePicker() {
        let alert: DateDialog = DateDialog.fromNib()
        alert.initialize(title: "Date")
        print(self.btnSelectDate.frame)
        let initialFrame: CGRect =  self.btnSelectDate.convert(self.btnSelectDate.bounds, to: Common.appDelegate.window!)
        print("Frame: \(initialFrame)")
        alert.initialFrame = initialFrame
        alert.show(animated: true)

        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            guard let self = self else { return } ; print(self)
            alert?.dismiss()
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self] (person) in
            guard let self = self else { return } ; print(self)
            alert?.dismiss()
        }
    }
}

