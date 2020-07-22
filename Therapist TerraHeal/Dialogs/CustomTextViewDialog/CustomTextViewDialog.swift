//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Aatish. All rights reserved.
//

import UIKit

class CustomTextViewDialog: ThemeBottomDialogView {

    @IBOutlet weak var lblTitle: ThemeLabel!
    @IBOutlet weak var txtDescription: ThemeTextView!
    var strEnteredData: String = ""
    var onBtnDoneTapped: ((_ data:String) -> Void)? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func initialize(title:String,data: String , buttonTitle:String,cancelButtonTitle:String) {
        self.lblTitle.text = title
        self.txtDescription.text = data
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
        self.initialSetup()
    }

    override func initialSetup() {
        super.initialSetup()
        self.txtDescription.setFont(name: FontName.Regular, size: FontSize.label_18)
        self.txtDescription.setPlaceholderFont(name: FontName.Regular, size: FontSize.label_18)
        self.txtDescription.placeholder = "Lorem ipsum dolor"
        self.lblTitle.setFont(name: FontName.Bold, size: FontSize.label_26)
        self.txtDescription?.delegate = self
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

