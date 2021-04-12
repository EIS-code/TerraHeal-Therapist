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

    @IBOutlet weak var cltForTimeSlot: UICollectionView!
    @IBOutlet weak var txtBreakTime: UITextField!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var lblAvailableTime: ThemeLabel!
    @IBOutlet weak var vwForSelectedTime: UIView!
    @IBOutlet weak var hcltVw: NSLayoutConstraint!

    var onBtnDoneTapped: ((_ data:SlotDetail) -> Void)? = nil
    var selectedData:SlotDetail? = nil
    var minutes: Int = 0
    var arrForData: [SlotDetail] = [
        SlotDetail.init(id: "1", minute: "05", milliseconds: 0.0, isSelected: false),
        SlotDetail.init(id: "2", minute: "10", milliseconds: 0.0, isSelected: false),
        SlotDetail.init(id: "3", minute: "15", milliseconds: 0.0, isSelected: false),
        SlotDetail.init(id: "4", minute: "20", milliseconds: 0.0, isSelected: false),
        SlotDetail.init(id: "5", minute: "25", milliseconds: 0.0, isSelected: false),
        SlotDetail.init(id: "6", minute: "30", milliseconds: 0.0, isSelected: false),
        SlotDetail.init(id: "7", minute: "35", milliseconds: 0.0, isSelected: false),
        SlotDetail.init(id: "8", minute: "40", milliseconds: 0.0, isSelected: false),
        SlotDetail.init(id: "9", minute: "45", milliseconds: 0.0, isSelected: false),
        SlotDetail.init(id: "10", minute: "50", milliseconds: 0.0, isSelected: false),
        SlotDetail.init(id: "11", minute: "55", milliseconds: 0.0, isSelected: false),
        SlotDetail.init(id: "12", minute: "60", milliseconds: 0.0, isSelected: false),]

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
        vwForSelectedTime.setRound(withBorderColor: UIColor.themePrimary, andCornerRadious: 1.0, borderWidth: 1.0)
        self.cltForTimeSlot.reloadData(heightToFit: self.hcltVw) {
            print(self.cltForTimeSlot)
        }
    }

    func select(data:SlotDetail) {
        self.selectedData = data
        for i in 0..<arrForData.count {
            arrForData[i].isSelected = false
            if arrForData[i].id == data.id {
                arrForData[i].isSelected = true
            }
        }
        self.cltForTimeSlot.reloadData()
    }

    func setDataSource(dataList:  [SlotDetail]) {
        self.arrForData.removeAll()
        for item in dataList {
            self.arrForData.append(item)
            if item.isSelected {
                self.selectedData = item
            }
        }
        if selectedData != nil {
            self.select(data: self.selectedData!)
        }
        self.cltForTimeSlot.reloadData()

    }
    override func initialSetup() {
        super.initialSetup()
        self.lblTitle.setFont(name: FontName.Bold, size: FontSize.header)
        self.lblAvailableTime.setText("TIME_BREAK_AVAILABLE".localized())
        self.txtBreakTime.setPlaceholder("TIME_BREAK_PLACEHOLDER".localized())
        self.txtBreakTime.setRound(withBorderColor: .themeHintText, andCornerRadious: 5.0, borderWidth: 1.0)
        self.txtBreakTime.delegate = self
        self.txtBreakTime.keyboardType = .numberPad
        self.lblAvailableTime.setFont(name: FontName.SemiBold, size: FontSize.header)
        self.timePicker.backgroundColor = UIColor.clear
        self.timePicker.setValue(UIColor.themeSecondary, forKeyPath: "textColor")
        self.timePicker.isUserInteractionEnabled = false
        self.setupCollectionView(collectionView: self.cltForTimeSlot)
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



extension TimeBreakDialog: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text!.isNotEmpty() {
            self.resetArray()
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let numberOnly = NSCharacterSet.init(charactersIn: "0123456789")
        let stringFromTextField = NSCharacterSet.init(charactersIn: string)
        let strValid = numberOnly.isSuperset(of: stringFromTextField as CharacterSet)
        return strValid
    }
    func resetArray() {
        for i in 0..<self.arrForData.count {
            self.arrForData[i].isSelected = false
        }
        self.cltForTimeSlot.reloadData()
        self.timePicker.setDate(Date().add(component: .minute, value: self.txtBreakTime.text!.toInt), animated: true)
        self.minutes = self.txtBreakTime.text!.toInt
    }

    func wsGetBreak() {
        Loader.showLoading()
        var request: MenuWebService.RequestTakeBreak = MenuWebService.RequestTakeBreak.init()
        request.break_for = ""
        request.break_reason = ""
        request.minutes = self.minutes.toString()
        request.date = Date().millisecondsSince1970.toString()
        MenuWebService.requestTakeBreak(params: request) { (response) in
            Loader.hideLoading()
            if ResponseModel.isSuccess(response: response) {
                if self.onBtnDoneTapped != nil {
                    self.onBtnDoneTapped!(self.selectedData!);
                }
            }
        }

    }
}

