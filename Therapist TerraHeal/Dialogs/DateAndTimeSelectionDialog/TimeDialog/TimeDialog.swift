//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Jaydeep. All rights reserved.
//

import UIKit


class TimeDialog: ThemeBottomDialogView {
    
    @IBOutlet weak var timePicker: UIDatePicker!
    var onBtnDoneTapped : ((_ time: Double) -> Void)? = nil
      
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func initialize(title:String,buttonTitle:String,cancelButtonTitle:String) {
        self.initialSetup()
        self.lblTitle.text = title
        if cancelButtonTitle.isEmpty() {
            self.btnCancel.isHidden = true
        } else {
            self.btnCancel.setTitle(cancelButtonTitle, for: .normal)
            self.btnCancel.isHidden = false
        }
        if buttonTitle.isEmpty() {
            self.btnNext.isHidden = true
        } else {
            self.lblTitle.setFont(name: FontName.Bold, size: FontSize.header)
            self.btnNext.setTitle(buttonTitle, for: .normal)
            self.btnNext.isHidden = false
        }
    }
    
    override func initialSetup() {
        super.initialSetup()
        self.lblTitle.setFont(name: FontName.Bold, size: FontSize.header)
        self.timePicker.backgroundColor = UIColor.clear
        self.timePicker.setValue(UIColor.themePrimary, forKeyPath: "textColor")
    }
    
    
    
    @IBAction func onClickBtnDone(_ sender: Any) {
        if self.onBtnDoneTapped != nil {
            self.onBtnDoneTapped!(self.timePicker.date.millisecondsSince1970 - Calendar.current.startOfDay(for: timePicker.date).millisecondsSince1970);
        }
    }

}


