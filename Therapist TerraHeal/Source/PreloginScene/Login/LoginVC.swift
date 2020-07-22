//
//  Created by Jaydeep VyasUnderlineTextButton
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit
import LocalAuthentication


class LoginVC: MainVC {

    @IBOutlet weak var scrVw: UIScrollView!
    @IBOutlet weak var vwContent: UIView!
    @IBOutlet weak var lblLoginTitle: ThemeLabel!
    @IBOutlet weak var lblMessage: ThemeLabel!
    @IBOutlet weak var txtEmail: ACFloatingTextfield!
    @IBOutlet weak var txtPassword: ACFloatingTextfield!
    @IBOutlet weak var btnForgotPassword: ThemeButton!
    @IBOutlet weak var btnLogin: ThemeButton!
    @IBOutlet weak var imgChecked: UIImageView!
  
    // MARK: Object lifecycle

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
        if self.isViewAvailable() {
            self.btnLogin.layoutIfNeeded()
            self.btnLogin.setHighlighted(isHighlighted: true)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        _ = self.txtEmail?.becomeFirstResponder()
    }

    private func initialViewSetup() {
        
        self.lblLoginTitle?.text = "LOGIN_LBL_TITLE".localized()
        self.lblLoginTitle?.setFont(name: FontName.Bold, size: FontSize.label_36)
        self.lblMessage?.text = "LOGIN_LBL_MESSAGE".localized()
        self.lblMessage?.setFont(name: FontName.Regular, size: FontSize.label_18)
        self.txtEmail?.placeholder = "LOGIN_TXT_EMAIL".localized()
        self.txtEmail?.delegate = self
        self.txtEmail?.configureTextField(InputTextFieldDetail.getEmailConfiguration())
        self.txtPassword?.placeholder = "LOGIN_TXT_PASSWORD".localized()
        self.txtPassword?.delegate = self
        self.txtPassword.setupPasswordTextFielad()
        self.txtPassword.configureTextField(InputTextFieldDetail.getPassowordConfiguration())
        self.btnForgotPassword?.setFont(name: FontName.SemiBold, size: FontSize.button_14)
        self.btnForgotPassword?.setTitle("LOGIN_BTN_FORGOT_PASSWORD".localized(), for: .normal)
        self.btnLogin?.setFont(name: FontName.SemiBold, size: FontSize.button_14)
        self.btnLogin?.setTitle("LOGIN_BTN_SIGN_IN".localized(), for: .normal)
        self.btnLogin.setHighlighted(isHighlighted: true)
        self.imgChecked?.isHidden = true
    }


    // MARK: - Action Methods
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        _ = _ = (self.navigationController as? NC)?.popVC()
    }

    @IBAction func btnLoginTapped(_ sender: UIButton) {
        Common.appDelegate.loadHomeVC()
        /*
        if checkValidation() {
            self.wsLogin()
        }*/
    }
    
    @IBAction func btnForgotPasswordTapped(_ sender: UIButton) {
        
    }

    @IBAction func btnFingerPrintTapped(_ sender: UIButton) {
        self.openRegisterFingerPrintDialog()
    }
    
    
    
    
    
    func openRegisterFingerPrintDialog() {
        let alertFingerPrint: FingerPrintDialog = FingerPrintDialog.fromNib()
        alertFingerPrint.initialize(title: "FINGER_PRINT_DIALOG_REGISTER_TITLE".localized(), buttonTitle: "BTN_YES_PROCEED".localized(), cancelButtonTitle: "BTN_BACK".localized())
        alertFingerPrint.show(animated: true)
        alertFingerPrint.onBtnCancelTapped = {
            [weak alertFingerPrint, weak self] in
            guard let self = self else {return}; print(self)
            alertFingerPrint?.dismiss();
        }
        alertFingerPrint.onBtnDoneTapped = {
            [weak alertFingerPrint, weak self] in
            guard let self = self else {return}; print(self)
            alertFingerPrint?.dismiss();
            self.openLoginFingerPrintDialog()
        }
    }
    
    func openLoginFingerPrintDialog() {
        let alertFingerPrint: FingerPrintDialog = FingerPrintDialog.fromNib()
        alertFingerPrint.initialize(title: "FINGER_PRINT_DIALOG_LOGIN_TITLE".localized(), buttonTitle: "BTN_YES_PROCEED".localized(), cancelButtonTitle: "FINGER_PRINT_DIALOG_BTN_PASSWORD".localized())
        alertFingerPrint.show(animated: true)
        alertFingerPrint.onBtnCancelTapped = {
            [weak alertFingerPrint, weak self] in
            guard let self = self else {return}; print(self)
            alertFingerPrint?.dismiss();
            self.openPasswordDialog()
        }
        alertFingerPrint.onBtnDoneTapped = {
            [weak alertFingerPrint, weak self] in
            guard let self = self else {return}; print(self)
            alertFingerPrint?.dismiss();
            
        }
    }
    
    func openPasswordDialog() {
            let alert: CustomTextFieldDialog = CustomTextFieldDialog.fromNib()
            alert.initialize(title: "FINGER_PRINT_DIALOG_BTN_PASSWORD", data: "", buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_BACK".localized())
            alert.show(animated: true)
            alert.configTextField(data: InputTextFieldDetail.getPassowordConfiguration())
            alert.onBtnCancelTapped = {
                [weak alert, weak self] in
                guard let self = self else { return } ; print(self)
                alert?.dismiss()
            }
            alert.onBtnDoneTapped = {
                [weak alert, weak self] (description) in
                guard let self = self else { return } ; print(self)
                alert?.dismiss()
            }
    }
}

extension LoginVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtEmail {
            _ = txtPassword?.becomeFirstResponder()
        } else if textField == txtPassword {
            _ = txtPassword?.resignFirstResponder()
        }
        return true
    }
}
// MARK: - Web API Methods
extension LoginVC {

    func wsLogin() {
        Loader.showLoading()
        var request: User.RequestLogin = User.RequestLogin()
        request.email = txtEmail.text?.trim() ?? ""
        request.password = txtPassword.text!
        AppWebApi.login(params: request) { (response) in
            let model: ResponseModel = ResponseModel.init(fromDictionary: response.toDictionary())
            Loader.hideLoading()
            self.btnLogin?.isEnabled = true
            if ResponseModel.isSuccess(response: model, withSuccessToast: false, andErrorToast: true) {
                let user = response.data
                PreferenceHelper.shared.setUserId(user.id)
                //PreferenceHelper.shared.setSessionToken(user.token)
                appSingleton.user = user
                Singleton.saveInDb()
                Common.appDelegate.loadHomeVC()
            }
        }
    }

    func checkValidation() -> Bool {

        if !txtEmail.validate().isValid {
            let alert: CustomAlert = CustomAlert.fromNib()
            alert.initialize(message: txtEmail.validate().message)
            alert.show(animated: true)
            alert.onBtnCancelTapped = {
                [weak alert, weak self] in
                alert?.dismiss();
                _ = self?.txtEmail.becomeFirstResponder()
            }
            return false
        }
        else if !txtPassword.validate().isValid {
            let alert: CustomAlert = CustomAlert.fromNib()
            alert.initialize(message: txtPassword.validate().message)
            alert.show(animated: true)
            alert.onBtnCancelTapped = {
                [weak alert, weak self] in
                alert?.dismiss()
                _ = self?.txtPassword.becomeFirstResponder()
            }
            return false
        }
        return true
    }

}


