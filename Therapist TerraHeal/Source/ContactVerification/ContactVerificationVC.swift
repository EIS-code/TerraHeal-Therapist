//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit



class ContactVerificationVC: MainVC {

    @IBOutlet weak var scrVw: UIScrollView!
    @IBOutlet weak var vwContent: UIView!
    @IBOutlet weak var hVwContent: NSLayoutConstraint!

    @IBOutlet weak var lblHeader: ThemeLabel!
    @IBOutlet weak var lblMessage: ThemeLabel!
    @IBOutlet weak var txtEmail: ACFloatingTextfield!

    @IBOutlet weak var btnVerifyEmail: ThemeButton!
    @IBOutlet weak var btnVerifyEmailDone: ThemeButton!


    @IBOutlet weak var btnVerifyMobile: ThemeButton!
    @IBOutlet weak var btnVerifyMobileDone: ThemeButton!

    @IBOutlet weak var btnVerifiedMobile: ThemeButton!
    @IBOutlet weak var lblVerified: ThemeLabel!
    @IBOutlet weak var vwMobileVerified: UIView!

    @IBOutlet weak var lblCountryCode: ThemeLabel!
    @IBOutlet weak var lblMobileNumber: ThemeLabel!
    @IBOutlet weak var txtCountryCode: ACFloatingTextfield!
    @IBOutlet weak var txtMobile: ACFloatingTextfield!

    @IBOutlet weak var btnVerifiedEmail: ThemeButton!
    @IBOutlet weak var vwEmailVerified: UIView!
    @IBOutlet weak var lblEmailVerified: ThemeLabel!
    // MARK: Object lifecycle
    var isEmailVerified: Bool = false
    var isMobileVerified: Bool = false

    @IBOutlet weak var stkProceed: UIStackView!
    @IBOutlet weak var btnProceed: ThemeButton!
    @IBOutlet weak var btnDone: ThemeButton!

    var alertForEmailVerification: VerificationAlert!
    var alertForMobileVerification: VerificationAlert!

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Setup

    private func setup() {

    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialViewSetup()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        btnVerifyEmailDone?.setUpRoundedButton()
        btnVerifyMobileDone?.setUpRoundedButton()
        btnDone?.setUpRoundedButton()
        btnVerifiedEmail?.setRound()
        btnVerifiedMobile?.setRound()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        stkProceed.isHidden = true
        vwEmailVerified.isHidden = true
        vwMobileVerified.isHidden = true
    }

    private func initialViewSetup() {
        self.vwBar?.backgroundColor = UIColor.clear
        self.lblHeader?.text = "CONTACT_VERIFICATION_LBL_TITLE".localized()
        self.lblHeader?.setFont(name: FontName.GradDuke, size: FontSize.label_26)
        self.lblMessage?.text = "CONTACT_VERIFICATION_LBL_MESSAGE".localized()
        self.lblMessage?.setFont(name: FontName.Ovo, size: FontSize.label_18)

        self.lblVerified?.text = "CONTACT_VERIFICATION_BTN_VERIFIED".localized()
        self.lblVerified?.setFont(name: FontName.Ovo, size: FontSize.label_18)

        self.lblEmailVerified?.text = "CONTACT_VERIFICATION_BTN_VERIFIED".localized()
        self.lblEmailVerified?.setFont(name: FontName.Ovo, size: FontSize.label_18)

        self.lblCountryCode?.text = "CONTACT_VERIFICATION_LBL_COUNTRY_CODE".localized()
        self.lblCountryCode?.setFont(name: FontName.Ovo, size: FontSize.label_18)

        self.lblMobileNumber?.text = "CONTACT_VERIFICATION_TXT_MOBILE_NUMBER".localized()
        self.lblMobileNumber?.setFont(name: FontName.Ovo, size: FontSize.label_18)

        self.txtMobile?.placeholder = "CONTACT_VERIFICATION_TXT_MOBILE_NUMBER".localized()
        self.txtCountryCode?.placeholder = "CONTACT_VERIFICATION_LBL_COUNTRY_CODE".localized()
        self.txtEmail?.placeholder = "CONTACT_VERIFICATION_TXT_EMAIL".localized()
        self.txtCountryCode.text = "IN(+91) "
        self.btnVerifyEmail?.setFont(name: FontName.GradDuke, size: FontSize.button_20)
        self.btnVerifyEmail?.setTitle("CONTACT_VERIFICATION_BTN_VERIFY".localized(), for: .normal)

        self.btnVerifyMobile?.setFont(name: FontName.GradDuke, size: FontSize.button_20)
        self.btnVerifyMobile?.setTitle("CONTACT_VERIFICATION_BTN_VERIFY".localized(), for: .normal)

        self.btnProceed?.setFont(name: FontName.GradDuke, size: FontSize.button_20)
        self.btnProceed?.setTitle("CONTACT_VERIFICATION_BTN_PROCEED".localized(), for: .normal)
    }


    // MARK: - Action Methods
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        self.navigationController?.popViewController(animated: true)
    }



    @IBAction func btnVerifyEmailTapped(_ sender: UIButton) {
        self.btnVerifyEmail.isEnabled = false
        self.btnVerifyEmailDone.isEnabled = false
        if checkEmailValidation() {
            self.wsVerifyEmail()
        }
    }

    @IBAction func btnVerifyMobileTapped(_ sender: UIButton) {
        if checkMobileValidation() {
            self.wsVerifyPhone()
        }
    }

    @IBAction func btnNextTapped(_ sender: Any) {
        Common.appDelegate.loadTherapistKycInfoVC(navigaionVC: self.navigationController)
    }

    //MARK: Other Function
    func openEmailVerification() {
        alertForEmailVerification = VerificationAlert.fromNib()
        alertForEmailVerification.initialize(message: "VERIFICATION_EMAIL_TITLE".localized(), data: txtEmail.text!)
        alertForEmailVerification.show(animated: true)
        alertForEmailVerification.onBtnDoneTapped = { [weak alertForEmailVerification, weak self] (code:String) in
            self?.wsVerifyEmailOtp(code: code)
        }

        alertForEmailVerification.onBtnResendTapped = { [weak self] in
            self?.wsVerifyEmail(isResend: true)
        }
        alertForEmailVerification.onBtnCancelTapped = { [weak alertForEmailVerification,  weak self] in
            alertForEmailVerification?.dismiss()
            self?.btnVerifyEmail.isEnabled = true
            self?.btnVerifyEmailDone.isEnabled = true
        }
    }

    func openPhoneVerification() {

        alertForMobileVerification = VerificationAlert.fromNib()
        alertForMobileVerification.initialize(message: "VERIFICATION_MOBILE_TITLE".localized(), data: txtMobile.text!)
        alertForMobileVerification.show(animated: true)
        alertForMobileVerification.onBtnDoneTapped = { [weak alertForMobileVerification, weak self] (code:String) in
            self?.wsVerifyPhoneOtp(code: code)
        }

        alertForMobileVerification.onBtnResendTapped = { [weak self] in
            self?.wsVerifyPhone()
        }
        alertForMobileVerification.onBtnCancelTapped = { [weak alertForMobileVerification,  weak self] in
            alertForMobileVerification?.dismiss()
            self?.btnVerifyMobile.isEnabled = true
            self?.btnVerifyMobileDone.isEnabled = true
        }
    }

    func verifedEmail() {
        self.btnVerifyEmail.isHidden = true
        self.btnVerifyEmailDone.isHidden = true
        self.vwEmailVerified.visible()
        self.isEmailVerified = true
        self.updateProceedUI()
    }

    func verifedMobile() {
        self.btnVerifyMobile.isHidden = true
        self.btnVerifyMobileDone.isHidden = true
        self.vwMobileVerified.visible()
        self.isMobileVerified = true
        self.updateProceedUI()
    }

    func updateProceedUI() {
        if isMobileVerified && isEmailVerified {
            stkProceed.visible()
        }
    }



}

// MARK: - Web API Methods
extension ContactVerificationVC {

    private func wsVerifyEmail(isResend:Bool = false) {
        Loader.showLoading()
        var request: User.RequestEmailOTP = User.RequestEmailOTP()
        request.email = txtEmail.text?.trim() ?? ""
        AppWebApi.getEmailOtp(params: request) { (response) in
            Loader.hideLoading()
            if ResponseModel.isSuccess(response: response, withSuccessToast: false, andErrorToast: true) {
                if isResend {
                    self.alertForEmailVerification.otpTextFieldView.clearTextField()
                } else {
                    self.openEmailVerification()
                }
            } else {
                self.btnVerifyEmail.isEnabled = true
                self.btnVerifyEmailDone.isEnabled = true
            }
        }
    }

    private func wsVerifyEmailOtp(code:String) {
        Loader.showLoading()
        var request: User.RequestVerifyEmailOTP = User.RequestVerifyEmailOTP()
        request.otp = code
        AppWebApi.verifyEmailOtp(params: request) { (response) in
            Loader.hideLoading()
            if ResponseModel.isSuccess(response: response, withSuccessToast: false, andErrorToast: true) {
                self.alertForEmailVerification.dismiss()
                self.verifedEmail()
                self.btnVerifyEmail.isEnabled = true
                self.btnVerifyEmailDone.isEnabled = true
            } else {

                self.btnVerifyEmail.isEnabled = true
                self.btnVerifyEmailDone.isEnabled = true
            }
        }
    }


    private func wsVerifyPhone(isResend:Bool = false) {
        Loader.showLoading()
        var request: User.RequestPhoneOTP = User.RequestPhoneOTP()
        request.mobile = txtMobile.text?.trim() ?? ""
        AppWebApi.getPhoneOtp(params: request) { (response) in
            Loader.hideLoading()
            if ResponseModel.isSuccess(response: response, withSuccessToast: false, andErrorToast: true) {
                if isResend {
                    self.alertForEmailVerification.otpTextFieldView.clearTextField()
                } else {
                    self.openPhoneVerification()
                }
            } else {
                self.btnVerifyMobile.isEnabled = true
                self.btnVerifyMobileDone.isEnabled = true

            }
        }
    }

    private func wsVerifyPhoneOtp(code:String) {
        Loader.showLoading()
        var request: User.RequestVerifyPhoneOTP = User.RequestVerifyPhoneOTP()
        request.otp = code
        AppWebApi.verifyPhoneOtp(params: request) { (response) in
            Loader.hideLoading()
            if ResponseModel.isSuccess(response: response, withSuccessToast: false, andErrorToast: true) {
                self.alertForMobileVerification.dismiss()
                self.verifedMobile()
                self.btnVerifyMobile.isEnabled = true
                self.btnVerifyMobileDone.isEnabled = true
            } else {

                self.btnVerifyMobile.isEnabled = true
                self.btnVerifyMobileDone.isEnabled = true
            }
        }
    }

    func checkEmailValidation() -> Bool {
        if !txtEmail.text!.isValidEmail() {
            let alert: CustomAlert = CustomAlert.fromNib()
            alert.initialize(message: "VALIDATION_MSG_INVALID_EMAIL".localized())
            alert.show(animated: true)
            alert.onBtnCancelTapped = {
                [weak alert, weak self] in
                alert?.dismiss()
                _ = self?.txtEmail.becomeFirstResponder()
                self?.btnVerifyEmail.isEnabled = true
                self?.btnVerifyEmailDone.isEnabled = true
            }
            return false
        }
        return true
    }
    func checkMobileValidation() -> Bool {
        if txtMobile.text!.isEmpty() {
            let alert: CustomAlert = CustomAlert.fromNib()
            alert.initialize(message: "VALIDATION_MSG_INVALID_MOBILE".localized())
            alert.show(animated: true)
            alert.onBtnCancelTapped = {
                [weak alert, weak self] in
                alert?.dismiss()
                _ = self?.txtMobile.becomeFirstResponder()
                self?.btnVerifyMobile.isEnabled = false
                self?.btnVerifyMobileDone.isEnabled = false
            }
            return false
        }
        return true
    }
}
