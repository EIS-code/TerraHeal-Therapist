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

    var onBtnDoneTapped: ((_ data:SlotDetail) -> Void)? = nil
    var selectedData:SlotDetail? = nil

    var arrForData: [ShiftCellDetail] = []

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
        if selectedData == nil {
            Common.showAlert(message: "VALIDATION_MSG_PLEASE_SELECT_DATA".localized())
        } else {
            self.wsGetBreak()

        }
    }
}



extension TimeBreakDialog {

    func resetArray() {
        for i in 0..<self.arrForData.count {
            self.arrForData[i].isSelected = false
        }
    }

    func wsGetBreak() {
       /* Loader.showLoading()
        var request: MenuWebService.RequestTakeBreak = MenuWebService.RequestTakeBreak.init()
        request.minutes = self.minutes.toString()
        request.date = Date().millisecondsSince1970.toString()
        MenuWebService.requestTakeBreak(params: request) { (response) in
            Loader.hideLoading()
            if ResponseModel.isSuccess(response: response) {
                if self.onBtnDoneTapped != nil {
                    self.onBtnDoneTapped!(self.selectedData!);
                }
            }
        }*/


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

