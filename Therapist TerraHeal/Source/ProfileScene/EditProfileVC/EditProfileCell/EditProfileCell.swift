//  EvolutionDemo
//
//  Created by Jaydeep on 19/03/20.
//  Copyright © 2020 com.evolutiondemo. All rights reserved.
//
import UIKit
import Foundation




struct EditProfileTextFieldDetail {
    var value:String = ""
    var type:EditProfileContentType = .Name
    var rightImage: String = ""
}

class EditProfileCell: CollectionCell {
    
    @IBOutlet weak var vwEditText: UIView!
    @IBOutlet weak var btnVerify: UIButton!
    @IBOutlet weak var imgVerified: UIImageView!
    @IBOutlet weak var lblPlaceholder: ThemeLabel!
    @IBOutlet weak var lblValue: ThemeLabel!
    @IBOutlet weak var ivContent: UIImageView!
    @IBOutlet weak var imgArrow: UIImageView!
    var data: EditProfileTextFieldDetail!
    var parent: UIViewController? = nil


    override func awakeFromNib()  {
        super.awakeFromNib()
        self.lblPlaceholder.setFont(name: FontName.SemiBold, size: FontSize.placeHolder_14)
        self.lblValue.setFont(name: FontName.Regular, size: FontSize.detail)
    }
    
    func setData(data:EditProfileTextFieldDetail) {
        self.data = data
        self.lblPlaceholder.setText(data.type.getPlaceHolder())
        self.lblValue.setText(data.value)
        self.ivContent.image = UIImage.init(named: data.type.getImage())

        if data.type == .Email {
            self.btnVerify.isHidden = appSingleton.user.isEmailVerified.toBool
            self.imgVerified.isHidden = !appSingleton.user.isEmailVerified.toBool
        } else if data.type == .Phone {
            self.btnVerify.isHidden = appSingleton.user.isMobileVerified.toBool
            self.imgVerified.isHidden = !appSingleton.user.isMobileVerified.toBool
        } else {
            self.btnVerify.isHidden = true
            self.imgVerified.isHidden = true
        }
        imgArrow.isHidden =  data.rightImage.isEmpty()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    @IBAction func btnVerifyTapped(_ sender: Any) {
        if data.type == .Email  {
            self.openEmailVerification()
        } else if data.type == .Phone  {
            self.openMobileVerification()
        }
        
    }
}

extension EditProfileCell {

    func openEmailVerification() {
        /*let alertForVerification: VerificationAlert  = VerificationAlert.fromNib()
        alertForVerification.initialize(message: "VERIFICATION_EMAIL_TITLE".localized(), data: Singleton.shared.user.email)
        alertForVerification.show(animated: true)
        alertForVerification.setVerificationFor(type: .Email)
        alertForVerification.onBtnDoneTapped = { [weak alertForVerification, weak self] (code:String) in
            guard let self = self else { return } ; print(self)
            alertForVerification?.dismiss()
            (self.parent as? EditProfileVC)?.setUserData()
        }
        alertForVerification.onBtnResendTapped = { [weak self] in
            guard let self = self else { return } ; print(self)
        }
        alertForVerification.onBtnCancelTapped = { [weak alertForVerification,  weak self] in
            guard let self = self else { return } ; print(self)
            alertForVerification?.dismiss()
        }*/
    }
    func openMobileVerification() {
        let alertForVerification: VerificationAlert  = VerificationAlert.fromNib()
        alertForVerification.initialize(message: "VERIFICATION_MOBILE_TITLE".localized(), data: Singleton.shared.user.telNumber)
        alertForVerification.show(animated: true)
        alertForVerification.setVerificationFor(type: .Phone)
        alertForVerification.onBtnDoneTapped = { [weak alertForVerification, weak self] (code:String) in
            guard let self = self else { return } ; print(self)
            alertForVerification?.dismiss()
            (self.parent as? EditProfileVC)?.setUserData()
        }

        alertForVerification.onBtnResendTapped = { [weak self] in
            guard let self = self else { return } ; print(self)
        }
        alertForVerification.onBtnCancelTapped = { [weak alertForVerification,  weak self] in
            guard let self = self else { return } ; print(self)
            alertForVerification?.dismiss()
        }
    }
}

