//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Jaydeep. All rights reserved.
//

import UIKit

class CustomMobileNumberDialog: ThemeBottomDialogView {

    
    @IBOutlet weak var txtMobileNumber: ACFloatingTextfield!
    @IBOutlet weak var txtCountryPhoneCode: ACFloatingTextfield!

    var onBtnDoneTapped: ((_ countryPhoneCode: String,_ phoneNumber: String) -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func initialize(title:String, countryPhoneCode:String = "", phoneNumber:String = "", buttonTitle:String,cancelButtonTitle:String) {

        self.initialSetup()
        self.lblTitle.text = title
        self.txtCountryPhoneCode.text = countryPhoneCode
        self.txtMobileNumber.text = phoneNumber
        if cancelButtonTitle.isEmpty() {
            self.btnCancel.isHidden = true
        } else {
            self.btnCancel.setTitle(cancelButtonTitle, for: .normal)
            self.btnCancel.isHidden = false
        }
        if buttonTitle.isEmpty() {
            self.btnDone.isHidden = true
        } else {
            self.btnDone.setTitle(buttonTitle, for: .normal)
            self.btnDone.isHidden = false
        }

    }

    override func initialSetup() {
        super.initialSetup()
        self.txtMobileNumber?.placeholder = "".localized()
        self.txtMobileNumber?.delegate = self
        self.txtCountryPhoneCode?.placeholder = "".localized()
        self.txtCountryPhoneCode?.delegate = self
        self.lblTitle.setFont(name: FontName.Bold, size: FontSize.header)
        self.txtMobileNumber.configureTextField(InputTextFieldDetail.getMobileConfiguration())
    }
      

    override func layoutSubviews() {
        super.layoutSubviews()
    }


    func checkValidation() -> Bool {
        if txtCountryPhoneCode.text!.isEmpty {
            let alert: CustomAlert = CustomAlert.fromNib()
            alert.initialize(message: "VALIDATION_MSG_INVALID_DATA".localized())
            alert.show(animated: true)
            alert.onBtnCancelTapped = {
                [weak alert, weak self] in
                alert?.dismiss()
                _ = self?.txtCountryPhoneCode.becomeFirstResponder()
            }
            return false
        }
        else if txtMobileNumber.text!.isEmpty {
            let alert: CustomAlert = CustomAlert.fromNib()
            alert.initialize(message: "VALIDATION_MSG_INVALID_DATA".localized())
            alert.show(animated: true)
            alert.onBtnCancelTapped = {
                [weak alert, weak self] in
                alert?.dismiss()
                _ = self?.txtMobileNumber.becomeFirstResponder()
            }
            return false
        }
        return true
    }

    @IBAction func btnDoneTapped(_ sender: Any) {
        if self.checkValidation() {
            if self.onBtnDoneTapped != nil {
                self.onBtnDoneTapped!(txtCountryPhoneCode.text!, txtMobileNumber!.text!);
            }
        }
    }

    func openCountryCodePicker() {
        let alert: CustomCountryPhoneCodePicker = CustomCountryPhoneCodePicker.fromNib()
        alert.initialize(title: "COUNTRY_PHONE_CODE_TITLE".localized(),buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_SKIP".localized())
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
             guard let self = self else {return}; print(self)
            alert?.dismiss()
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self] (countryPhoneCode:  CountryPhone) in
            guard let self = self else { return } ; print(self)
            alert?.dismiss()
            self.txtCountryPhoneCode.text = countryPhoneCode.countryPhoneCode
        }
    }
}

extension CustomMobileNumberDialog: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        _ = textField.resignFirstResponder()
        return true
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtCountryPhoneCode {
            self.openCountryCodePicker()
            return false
        }
        return true
    }
}
