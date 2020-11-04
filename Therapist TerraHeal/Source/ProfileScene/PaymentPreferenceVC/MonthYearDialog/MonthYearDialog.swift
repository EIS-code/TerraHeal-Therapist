//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Jaydeep. All rights reserved.
//

import UIKit


class MonthYearDialog: ThemeBottomDialogView {
    
    var onBtnDoneTapped : ((_ month: Int,_ year: Int) -> Void)? = nil
    
    @IBOutlet weak var monthPicker: MonthYearPickerView!
    var month:Int = 0
    var year:Int = 0
    
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
        self.monthPicker.backgroundColor = UIColor.clear
        self.monthPicker.setValue(UIColor.themePrimary, forKeyPath: "textColor")
        monthPicker.onDateSelected = { (month: Int, year: Int) in
            self.month = month
            self.year = year
        }
    }
  
    @IBAction func onClickBtnDone(_ sender: Any) {
        if self.onBtnDoneTapped != nil {
            self.onBtnDoneTapped!(self.month,self.year);
        }
    }

}


