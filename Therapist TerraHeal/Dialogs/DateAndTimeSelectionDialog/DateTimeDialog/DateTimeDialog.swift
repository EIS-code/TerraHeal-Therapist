//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Jaydeep. All rights reserved.
//

import UIKit


class DateTimeDialog: ThemeBottomDialogView {
    
    var onBtnDoneTapped : ((_ millis:Double) -> Void)? = nil
    @IBOutlet weak var vwForDateSelection: UIView!
    @IBOutlet weak var lblSelectDate: ThemeLabel!
    @IBOutlet weak var lblDateValue: ThemeLabel!
    @IBOutlet weak var btnSelectDate: ThemeButton!
    @IBOutlet weak var vwForTimeSelection: UIView!
    @IBOutlet weak var lblSelectTime: ThemeLabel!
    @IBOutlet weak var lblTimeValue: ThemeLabel!
    @IBOutlet weak var btnSelectTime: ThemeButton!
    
    let radius = JDDeviceHelper.offseter(offset: 10)
    var dateMilli: Double = 0
    var timeMilli: Double = 0
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func initialize(title:String,buttonTitle:String,cancelButtonTitle:String) {
        self.initialSetup()
        self.lblTitle.setText(title)
        self.btnNext.setText(buttonTitle, for: .normal)
        if cancelButtonTitle.isEmpty() {
            self.btnCancel.isHidden = true
        } else {
            self.btnCancel.setText(cancelButtonTitle, for: .normal)
            self.btnCancel.isHidden = false
        }
        if buttonTitle.isEmpty() {
            self.btnNext.isHidden = true
        } else {
            self.lblTitle.setFont(name: FontName.Bold, size: FontSize.header)
            self.btnNext.setText(buttonTitle, for: .normal)
            self.btnNext.isHidden = false
        }
    }
    
    override func initialSetup() {
        super.initialSetup()
        self.lblTitle.setFont(name: FontName.Bold, size: FontSize.header)
        self.lblSelectDate.setText("DATE_DIALOG_LBL_SELECT_DATE".localized())
        self.lblSelectTime.setText("DATE_DIALOG_LBL_SELECT_TIME".localized())
        self.lblSelectDate.setFont(name: FontName.Bold, size: FontSize.subHeader)
        self.lblSelectTime.setFont(name: FontName.Bold, size: FontSize.subHeader)
        self.lblDateValue.setFont(name: FontName.Regular, size: FontSize.regular)
        self.lblTimeValue.setFont(name: FontName.Regular, size: FontSize.regular)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.vwForDateSelection?.setRound(withBorderColor: .clear, andCornerRadious: radius, borderWidth: 1.0)
        self.vwForTimeSelection?.setRound(withBorderColor: .clear, andCornerRadious: radius, borderWidth: 1.0)
    }
    
    @IBAction func onClickBtnDone(_ sender: Any) {
        if dateMilli == 0 {
            Common.showAlert(message: "VALIDATION_MSG_DATE_SELECTION".localized())
        }
        else if  timeMilli == 0 {
            Common.showAlert(message: "VALIDATION_MSG_TIME_SELECTION".localized())
        } else {
            let mill = dateMilli.advanced(by: timeMilli)
            if self.onBtnDoneTapped != nil {
                self.onBtnDoneTapped!(mill);
            }
        }
    }
    
    @IBAction func btnDateTapped(_ sender: Any) {
        self.openDatePicker()
    }
    
    @IBAction func btnTimeTapped(_ sender: Any) {
        self.openTimePicker()
    }
    
    func openDatePicker() {
        let datePickerAlert: CustomDatePicker = CustomDatePicker.fromNib()
        
        
        datePickerAlert.initialize(title: "DATE_DIALOG_LBL_SELECT_DATE".localized(), buttonTitle: "BTN_PROCEED".localized(),cancelButtonTitle: "BTN_BACK".localized())
        datePickerAlert.setDate(minDate: Date(), maxDate: Date().addingTimeInterval(Date.millisecondsOfDay(day: 3)))
        datePickerAlert.show(animated: true)
        datePickerAlert.onBtnCancelTapped = {
            [weak datePickerAlert, weak self] in
            guard let self = self else { return } ; print(self)
            datePickerAlert?.dismiss()
        }
        datePickerAlert.onBtnDoneTapped = {
            [weak datePickerAlert, weak self] (date) in
            guard let self = self else { return } ; print(self)
            datePickerAlert?.dismiss()
            print(date)
            self.dateMilli = date
            self.lblDateValue.setText(Date.milliSecToDate(milliseconds: date, format: DateFormat.BookingDateSelection))
        }
    }
    
    func openTimePicker() {
        let timePickerAlert: TimeDialog = TimeDialog.fromNib()
        timePickerAlert.initialize(title: "DATE_DIALOG_LBL_SELECT_TIME".localized(), buttonTitle: "BTN_PROCEED".localized(),cancelButtonTitle: "BTN_BACK".localized())
        timePickerAlert.show(animated: true)
        timePickerAlert.onBtnCancelTapped = {
            [weak timePickerAlert, weak self] in
            guard let self = self else { return } ; print(self)
            timePickerAlert?.dismiss()
        }
        timePickerAlert.onBtnDoneTapped = {
            [weak timePickerAlert, weak self] (date) in
            guard let self = self else { return } ; print(self)
            print(date)
            timePickerAlert?.dismiss()
            self.timeMilli = date
            let dateToConvert = Date.milliSecToDate(milliseconds: date - Double((TimeZone.current.secondsFromGMT() * 1000)), format: DateFormat.BookingTimeSelection)
            self.lblTimeValue.setText(dateToConvert)
        }
    }
    
    
}


