//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Aatish. All rights reserved.
//

import UIKit

class ScanQRDialog: ThemeBottomDialogView {

    @IBOutlet weak var lblTitle: ThemeLabel!
    @IBOutlet weak var lblScan: ThemeLabel!
    var onBtnDoneTapped : (() -> Void)? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    func initialize(title:String, buttonTitle:String,cancelButtonTitle:String) {
        self.initialSetup()
        self.lblTitle.text = title
        if cancelButtonTitle.isEmpty() {
            self.btnCancel.isHidden = true
        } else {
            self.btnCancel.setTitle(cancelButtonTitle, for: .normal)
            self.btnCancel.isHidden = false
        }
    }

    override func initialSetup() {
        super.initialSetup()
        self.lblTitle.setFont(name: FontName.Bold, size: FontSize.label_26)
        self.lblScan.setFont(name: FontName.SemiBold, size: FontSize.label_22)
    }
  
    @IBAction func btnScanTapped(_ sender: UIButton) {
          if self.onBtnDoneTapped != nil {
              self.onBtnDoneTapped!();
          }
    }
   
}
