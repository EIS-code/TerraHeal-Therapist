//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Jaydeep. All rights reserved.
//

import UIKit

class CustomInformationDialog: ThemeBottomDialogView {

    @IBOutlet weak var lblMessage: ThemeLabel!
    var onBtnDoneTapped: (() -> Void)? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    

    func initialize(title:String,data: String , buttonTitle:String,cancelButtonTitle:String) {
        self.lblTitle.text = title
        self.lblMessage.attributedText = data.htmlAttributedString()
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
        self.lblTitle.setFont(name: FontName.SemiBold, size: FontSize.header)
        self.lblMessage.setFont(name: FontName.Regular, size: FontSize.detail)
        self.setDataForStepUpAnimation(data: [0.5,0.75,0.95])
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    @IBAction func btnDoneTapped(_ sender: Any) {
            if self.onBtnDoneTapped != nil {
                self.onBtnDoneTapped!();
            }
     }

}


