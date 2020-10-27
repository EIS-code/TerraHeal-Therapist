//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Jaydeep. All rights reserved.
//

import UIKit

class CustomGenderPicker: ThemeBottomDialogView {

    @IBOutlet weak var vwMainGender: UIView!
    @IBOutlet weak var vwMale: UIView!
    @IBOutlet weak var btnMale: UIButton!
    @IBOutlet weak var lblMale: ThemeLabel!
    @IBOutlet weak var ivMaleSelected: UIImageView!

    @IBOutlet weak var vwFemale: UIView!
    @IBOutlet weak var btnFemale: UIButton!
    @IBOutlet weak var lblFemale: ThemeLabel!
    @IBOutlet weak var ivFemaleSelected: UIImageView!


    var onBtnDoneTapped: ((_ gender:Gender) -> Void)? = nil
    var selectedGender:Gender = Gender.Male

    override func awakeFromNib() {
        super.awakeFromNib()
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
            self.btnDone.isHidden = true
        } else {
            self.btnDone.setTitle(buttonTitle, for: .normal)
            self.btnDone.isHidden = false
        }


        self.select(gender: self.selectedGender)
    }

    func select(gender:Gender) {
        self.selectedGender = gender

        btnMale.setRound(withBorderColor: (gender == Gender.Male) ? UIColor.themePrimary : UIColor.clear, andCornerRadious: 10.0, borderWidth: 1.5)
        ivMaleSelected.isHidden = (gender == Gender.Male) ? false : true
        ivFemaleSelected.isHidden = (gender == Gender.Male) ? true : false
        btnFemale.setRound(withBorderColor: (gender == Gender.Male) ? UIColor.clear : UIColor.themePrimary, andCornerRadious: 10.0, borderWidth: 1.5)
        ivMaleSelected?.setRound()
        ivFemaleSelected?.setRound()
    }

    override func initialSetup() {
        super.initialSetup()
        self.lblMale.text = "GENDER_MALE".localized()
        self.lblMale.setFont(name: FontName.Bold, size: FontSize.subHeader)
        self.lblFemale.text = "GENDER_FEMALE".localized()
        self.lblFemale.setFont(name: FontName.Bold, size: FontSize.subHeader)
        self.lblTitle.setFont(name: FontName.Bold, size: FontSize.header)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
       
        ivMaleSelected?.setRound()
        ivFemaleSelected?.setRound()
    }

    @IBAction func btnMaleTapped(_ sender: Any) {
        self.select(gender: Gender.Male)
    }
    @IBAction func btnFemaleTapped(_ sender: Any) {
        self.select(gender: Gender.Female)
    }

    @IBAction func btnDoneTapped(_ sender: Any) {
        if selectedGender == Gender.Other {
            Common.showAlert(message: "VALIDATION_MSG_PLEASE_SELECT_DATA".localized())
        } else {
            if self.onBtnDoneTapped != nil {
                self.onBtnDoneTapped!(selectedGender);
            }
        }

    }
}



