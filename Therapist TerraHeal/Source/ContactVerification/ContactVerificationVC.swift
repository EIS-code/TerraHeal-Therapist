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
        if checkEmailValidation() {
            sender.isEnabled = false
            let alert: VerificationAlert = VerificationAlert.fromNib()
            alert.initialize(message: "VERIFICATION_EMAIL_TITLE".localized(), data: txtEmail.text!)
            alert.show(animated: true)
            alert.onBtnDoneTapped = { [weak alert, weak self] (code:String) in
                alert?.dismiss()
                self?.verifedEmail()
                sender.isEnabled = true
            }
            alert.onBtnResendTapped = { [weak alert] in
                alert?.dismiss()
                sender.isEnabled = true
            }
            alert.onBtnCancelTapped = { [weak alert, weak self] in
                alert?.dismiss()
                sender.isEnabled = true
            }
        }
    }

    @IBAction func btnVerifyMobileTapped(_ sender: UIButton) {
        if checkMobileValidation() {
            sender.isEnabled = false
            let alert: VerificationAlert = VerificationAlert.fromNib()
            alert.initialize(message: "VERIFICATION_MOBILE_TITLE".localized(), data: txtMobile.text!)
            alert.show(animated: true)
            alert.onBtnDoneTapped = { [weak alert, weak self] (code:String) in
                alert?.dismiss()
                self?.verifedMobile()
                sender.isEnabled = true
            }

            alert.onBtnResendTapped = { [weak alert] in
                alert?.dismiss()
                sender.isEnabled = true
            }
            alert.onBtnCancelTapped = { [weak alert, weak self] in
                alert?.dismiss()
                sender.isEnabled = true
            }
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
    @IBAction func btnNextTapped(_ sender: Any) {
        self.wsLogin()
    }

}

// MARK: - Web API Methods
extension ContactVerificationVC {

    private func wsLogin() {
        Common.appDelegate.loadTherapistKycVC()
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
            }
            return false
        }
        return true
    }
}
