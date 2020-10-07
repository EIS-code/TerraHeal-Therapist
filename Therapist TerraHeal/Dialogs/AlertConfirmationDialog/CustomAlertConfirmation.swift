//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Jaydeep. All rights reserved.
//

import UIKit

class CustomAlertConfirmation: ThemeBottomDialogView {

    @IBOutlet weak var lblMessage: ThemeLabel!
    
    var onBtnDoneTapped : (() -> Void)? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    func initialize(title:String, message:String, buttonTitle:String,cancelButtonTitle:String) {
        self.initialSetup()
        self.lblTitle.setText(title)
        lblMessage.setText(message)
        if cancelButtonTitle.isEmpty() {
            self.btnCancel.isHidden = true
        } else {
            self.btnCancel.setText(cancelButtonTitle, for: .normal)
            self.btnCancel.isHidden = false
        }
        if buttonTitle.isEmpty() {
            self.btnNext.isHidden = true
        } else {
            self.btnNext.setText(buttonTitle, for: .normal)
            self.btnNext.isHidden = false
        }
    }

    override func initialSetup() {
        super.initialSetup()
        self.lblTitle.setFont(name: FontName.Bold, size: FontSize.large)
        self.lblMessage.setFont(name: FontName.SemiBold, size: FontSize.regular)
    }
    
    @IBAction func onClickBtnDone(_ sender: Any) {
        if self.onBtnDoneTapped != nil {
            self.onBtnDoneTapped!();
        }
    }
}


