//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Jaydeep. All rights reserved.
//

import UIKit

struct SlotDetail {
    var id:String = ""
    var minute: String = ""
    var milliseconds: Double = 0
    var isSelected:Bool = false
}



class TimeBreakDialog: ThemeBottomDialogView {
    @IBOutlet weak var vwForShift: UIView!
    @IBOutlet weak var tblForData: UITableView!
    @IBOutlet weak var hTblVw: NSLayoutConstraint!
    var startTime: Double = 0.0
    var endTime: Double = 0.0
    var onBtnDoneTapped: ((_ data:MenuWebService.RequestTakeBreak) -> Void)? = nil
    var arrForData: [ShiftCellDetail] = []
    var request: MenuWebService.RequestTakeBreak = MenuWebService.RequestTakeBreak.init()
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func initialize(title:String,buttonTitle:String,cancelButtonTitle:String) {
        self.initialSetup()
        self.lblTitle.setText(title)
        if cancelButtonTitle.isEmpty() {
            self.btnCancel.isHidden = true
        } else {
            self.btnCancel.setText(cancelButtonTitle, for: .normal)
            self.btnCancel.isHidden = false
        }
        if buttonTitle.isEmpty() {
            self.btnDone.isHidden = true
        } else {
            self.btnDone.setText(buttonTitle, for: .normal)
            self.btnDone.isHidden = false
        }
        vwForShift.setRound(withBorderColor: UIColor.themePrimary, andCornerRadious: 1.0, borderWidth: 1.0)
        self.wsAvailability()
        self.setupTableView(tableView: self.tblForData)
    }


    override func initialSetup() {
        super.initialSetup()
        self.lblTitle.setFont(name: FontName.Bold, size: FontSize.header)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    @IBAction func btnDoneTapped(_ sender: Any) {
        for data in arrForData {
            if data.isSelected {
                self.request = MenuWebService.RequestTakeBreak.init( shift_id: data.shiftID, from: startTime.toString(), to: endTime.toString())
                break;
            }
        }
        if self.request.shift_id.isEmpty(){
            Common.showAlert(message: "VALIDATION_MSG_PLEASE_SELECT_DATA".localized())
        } else if self.request.from.toDouble > self.request.to.toDouble {
            Common.showAlert(message: "VALIDATION_MSG_FROM_TIME_MUST_BE_LESS_THAN_END_TIME".localized())
        } else {

            if self.onBtnDoneTapped != nil {
                self.onBtnDoneTapped!(self.request);
            }
        }
    }

   @objc @IBAction func openStartTimePicker() {
        let timePickerAlert: TimeDialog = TimeDialog.fromNib()
        timePickerAlert.initialize(title: "DATE_DIALOG_LBL_SELECT_START_TIME".localized(), buttonTitle: "BTN_PROCEED".localized(),cancelButtonTitle: "BTN_BACK".localized())
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
            self.startTime = date
            self.tblForData.reloadData()
        }
    }
    @objc @IBAction func openEndTimePicker() {
        let timePickerAlert: TimeDialog = TimeDialog.fromNib()
        timePickerAlert.initialize(title: "DATE_DIALOG_LBL_SELECT_END_TIME".localized(), buttonTitle: "BTN_PROCEED".localized(),cancelButtonTitle: "BTN_BACK".localized())
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
            self.endTime = date
            self.tblForData.reloadData()
        }
    }
}



extension TimeBreakDialog {

    func resetArray() {
        for i in 0..<self.arrForData.count {
            self.arrForData[i].isSelected = false
        }
    }


    func wsAvailability() {
        Loader.showLoading()
        AvailabilityWebService.getAvailabilities(params: AvailabilityWebService.RequestGetAvailability.init()) { (response) in
            Loader.hideLoading()
            if ResponseModel.isSuccess(response: response) {
                for data in response.availabilityData.shifts {
                    self.arrForData.append(ShiftCellDetail.init(shift: data))
                }
            }
            self.tblForData.reloadData()
        }
    }
}

