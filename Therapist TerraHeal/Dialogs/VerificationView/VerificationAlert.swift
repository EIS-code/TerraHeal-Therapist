//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Jaydeep. All rights reserved.
//

import UIKit

class VerificationAlert: ThemeBottomDialogView {
    
    @IBOutlet weak var lblMessage: ThemeLabel!
    @IBOutlet weak var lblMessageDetail: ThemeLabel!
    @IBOutlet weak var btnVerify: DialogFilledRoundedButton!
    
    @IBOutlet var otpTextFieldView: OTPFieldView!
    @IBOutlet weak var btnResend: DialogCancelButton!
    
    var currentTab = 0
    
    var verificationData: String = ""
    
    var onBtnResendTapped: (() -> Void)? = nil
    var onBtnDoneTapped: ((_ code:String) -> Void)? = nil
    
    var strEnteredOtp:String = ""
    
    @IBOutlet weak var vwSwitch: JDSegmentedControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func initialize(message:String, data:String) {
        
        self.lblTitle.text = "VERIFICATION_LBL_TITLE".localized()
        self.lblMessage.text = message
        self.lblMessageDetail.text = "VERIFICATION_MSG_DETAIL".localized() + " " + data
        self.verificationData = data
        self.btnVerify.setTitle("VERIFICATION_BTN_VERIFY".localized(), for: .normal)
        self.btnResend.setTitle("VERIFICATION_BTN_RESEND".localized(), for: .normal)
        self.initialSetup()
    }
    
    func setVerificationFor(type:TextFieldContentType) {
        if type == .Email {
            self.vwSwitch.selectItemAt(index: 1)
            self.emailTapped()
        } else {
            self.vwSwitch.selectItemAt(index: 0)
            self.mobileTapped()
        }
    }
    
    override func initialSetup() {
        super.initialSetup()
        self.lblTitle.setFont(name: FontName.SemiBold, size: FontSize.header)
        self.lblMessage.setFont(name: FontName.SemiBold, size: FontSize.subHeader)
        self.lblMessageDetail.setFont(name: FontName.Regular, size: FontSize.detail)
        self.setupOtpView()
        self.vwSwitch.allowChangeThumbWidth = false
        self.vwSwitch.itemTitles = ["VERIFICATION_BTN_MOBILE".localized(),"VERIFICATION_BTN_EMAIL".localized()]
        self.vwSwitch.changeBackgroundColor(UIColor.themeLightTextColor)
        self.vwSwitch.didSelectItemWith = { [weak self] (index,title) in
            guard let self = self else {return}; print(self)
            if index == 0 {
                self.mobileTapped()
            } else {
                self.emailTapped()
            }
        }
    }
    
    func mobileTapped(){
        self.currentTab = 0
        self.wsVerifyPhone()
        self.lblMessageDetail.text = "VERIFICATION_MSG_DETAIL".localized() + " " + Singleton.shared.user.telNumber
        self.lblMessage.text = "verify your mobile number".localized()
        
    }
    func emailTapped(){
        self.currentTab = 1
        self.wsVerifyEmail()
        self.lblMessageDetail.text = "VERIFICATION_MSG_DETAIL".localized() + " " + Singleton.shared.user.email
        self.lblMessage.text = "verify your email address".localized()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.vwSwitch.center = CGPoint.init(x: self.center.x, y: self.vwSwitch.center.y)
    }
    
    
    @IBAction func btnResendTapped(_ sender: Any) {
        if self.onBtnResendTapped != nil {
            self.onBtnResendTapped!();
            if currentTab == 1 {
                self.wsVerifyEmail(isResend: true)
            } else {
                self.wsVerifyPhone(isResend: true)
            }
        }
    }
    
    @IBAction func btnDoneTapped(_ sender: Any) {
        if strEnteredOtp.isEmpty() {
            Common.showAlert(message: "VALIDATION_MSG_PLEASE_ENTER_OTP".localized())
        } else {
            if currentTab == 1 {
                self.wsVerifyEmailOtp(code: strEnteredOtp)
            } else {
                self.wsVerifyPhoneOtp(code: strEnteredOtp)
            }
        }
    }
    
}
//OTP  Setup
extension VerificationAlert:  OTPFieldViewDelegate {
    
    func setupOtpView(){
        self.otpTextFieldView.fieldsCount = 4
        self.otpTextFieldView.fieldBorderWidth = 0
        self.otpTextFieldView.defaultBorderColor = UIColor.clear
        self.otpTextFieldView.filledBorderColor = UIColor.clear
        self.otpTextFieldView.cursorColor = UIColor.themePrimary
        self.otpTextFieldView.displayType = .square
        self.otpTextFieldView.fieldSize = 60
        self.otpTextFieldView.separatorSpace = 0
        self.otpTextFieldView.shouldAllowIntermediateEditing = false
        self.otpTextFieldView.delegate = self
        self.otpTextFieldView.initializeUI()
    }
    func hasEnteredAllOTP(hasEnteredAll hasEntered: Bool) -> Bool {
        return false
    }
    
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
    }
    
    func enteredOTP(otp otpString: String) {
        self.strEnteredOtp = otpString
    }
    func updateVerificationView() {
        Singleton.saveInDb()
        if self.onBtnDoneTapped != nil {
            self.onBtnDoneTapped!(strEnteredOtp);
        }
    }
}




//MARK:   - WS Web API
extension VerificationAlert {
    
    private func wsVerifyEmail(isResend:Bool = false) {
        if appSingleton.user.isEmailVerified.toBool {
            return;
        }
        Loader.showLoading()
        var request: User.RequestEmailOTP = User.RequestEmailOTP()
        request.email = Singleton.shared.user.email
        AppWebApi.getEmailOtp(params: request) { (response) in
            Loader.hideLoading()
            if ResponseModel.isSuccess(response: response, withSuccessToast: false, andErrorToast: true) {
                self.otpTextFieldView.clearTextField()
            } else {
                
            }
        }
    }
    
    private func wsVerifyEmailOtp(code:String) {
        Loader.showLoading()
        var request: User.RequestVerifyEmailOTP = User.RequestVerifyEmailOTP()
        request.otp = code
        AppWebApi.verifyEmailOtp(params: request) { (response) in
            Loader.hideLoading()
            self.otpTextFieldView.clearTextField()
            if ResponseModel.isSuccess(response: response, withSuccessToast: true, andErrorToast: true) {
                Singleton.shared.user.isEmailVerified = Constant.True
                self.updateVerificationView()
            } else {
                
            }
        }
    }
    
    
    private func wsVerifyPhone(isResend:Bool = false) {
        if appSingleton.user.isMobileVerified.toBool {
            return;
        }
        Loader.showLoading()
        var request: User.RequestPhoneOTP = User.RequestPhoneOTP()
        request.mobile = Singleton.shared.user.telNumber
        AppWebApi.getPhoneOtp(params: request) { (response) in
            Loader.hideLoading()
            if ResponseModel.isSuccess(response: response, withSuccessToast: false, andErrorToast: true) {
                self.otpTextFieldView.clearTextField()
            } else {
                
            }
        }
    }
    
    private func wsVerifyPhoneOtp(code:String) {
        Loader.showLoading()
        var request: User.RequestVerifyPhoneOTP = User.RequestVerifyPhoneOTP()
        request.otp = code
        AppWebApi.verifyPhoneOtp(params: request) { (response) in
            Loader.hideLoading()
            self.otpTextFieldView.clearTextField()
            if ResponseModel.isSuccess(response: response, withSuccessToast: true, andErrorToast: true) {
                Singleton.shared.user.isMobileVerified = Constant.True
                self.updateVerificationView()
            } else {
            }
        }
    }
    
    
}
