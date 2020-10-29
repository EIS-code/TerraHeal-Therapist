//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Jaydeep. All rights reserved.
//

import UIKit

class CustomTextViewDialog: ThemeBottomDialogView {

    @IBOutlet weak var txtDescription: ThemeTextView!
    var strEnteredData: String = ""
    var onBtnDoneTapped: ((_ data:String) -> Void)? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func initialize(title:String,placeholder:String = "",  data: String = "" , buttonTitle:String,cancelButtonTitle:String) {
         self.initialSetup()
        self.lblTitle.setText(title)
        
        self.txtDescription.setText(data)
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
        self.txtDescription.placeholder = placeholder
    }

    override func initialSetup() {
        super.initialSetup()
        self.txtDescription.setFont(name: FontName.Regular, size: FontSize.subHeader)
        self.txtDescription.setPlaceholderFont(name: FontName.Regular, size: FontSize.subHeader)
        self.txtDescription.placeholder = "Lorem ipsum dolor"
        self.lblTitle.setFont(name: FontName.Bold, size: FontSize.header)
        self.txtDescription?.delegate = self
        self.txtDescription.borderLineColor = .themePrimary
        self.txtDescription.bgColor = .themeWhite
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    @IBAction func btnDoneTapped(_ sender: Any) {
        strEnteredData = txtDescription.text?.trim() ?? ""
        if strEnteredData.isEmpty() {
            Common.showAlert(message: "VALIDATION_MSG_INVALID_DATA".localized())
        } else {
            if self.onBtnDoneTapped != nil {
                self.onBtnDoneTapped!(strEnteredData);
            }
        }
    }

}

extension CustomTextViewDialog: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {

    }
}

