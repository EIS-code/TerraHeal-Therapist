//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Jaydeep. All rights reserved.
//

import UIKit

class CustomTextFieldDialog: ThemeBottomDialogView {
    
    @IBOutlet weak var txtData: ACFloatingTextfield!
    
    var isMandatory: Bool = true
    var onBtnDoneTapped: ((_ data: String) -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func initialize(title:String, placeholder:String = "", data:String, buttonTitle:String,cancelButtonTitle:String,isMandatory:Bool = true) {
        
        self.initialSetup()
        self.isMandatory = isMandatory
        self.lblTitle.text = title
        self.txtData.placeholder = placeholder
        self.txtData.text = data
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
        self.txtData?.placeholder = "".localized()
        self.txtData?.delegate = self
        self.lblTitle.setFont(name: FontName.Bold, size: FontSize.header)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    func checkValidation() -> Bool {
        
        if !txtData.validate().0 {
            let alert: CustomAlert = CustomAlert.fromNib()
            alert.initialize(message: txtData.validate().1)
            alert.show(animated: true)
            alert.onBtnCancelTapped = {
                [weak alert, weak self] in
                alert?.dismiss()
                _ = self?.txtData.becomeFirstResponder()
            }
            return false
        }
        
        return true
    }
    
    @IBAction func btnDoneTapped(_ sender: Any) {
            if self.isMandatory {
            if self.checkValidation() {
                if self.onBtnDoneTapped != nil {
                    self.onBtnDoneTapped!(txtData!.text!);
                }
            }
        } else {
            if self.onBtnDoneTapped != nil {
                self.onBtnDoneTapped!(txtData!.text!);
            }
            
        }
        
    }
    func configTextField(data:InputTextFieldDetail) {
        self.txtData.configureTextField(data)
        
    }
    
}

extension CustomTextFieldDialog: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        _ = textField.resignFirstResponder()
        return true
    }
}
