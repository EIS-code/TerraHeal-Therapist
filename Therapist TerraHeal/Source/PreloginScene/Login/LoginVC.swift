//
//  Created by Jaydeep VyasUnderlineTextButton
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit
import LocalAuthentication

class LoginVC: BaseVC {

    @IBOutlet weak var btnFigerPrint: UIButton!
    @IBOutlet weak var scrVw: UIScrollView!
    @IBOutlet weak var vwContent: UIView!
    @IBOutlet weak var lblLoginTitle: ThemeLabel!
    @IBOutlet weak var lblMessage: ThemeLabel!
    @IBOutlet weak var txtEmail: ACFloatingTextfield!
    @IBOutlet weak var txtPassword: ACFloatingTextfield!
    @IBOutlet weak var btnForgotPassword: ThemeButton!
    @IBOutlet weak var btnLogin: FilledRoundedButton!
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
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
      //  _ = self.txtEmail?.becomeFirstResponder()
    }

    private func initialViewSetup() {
        self.setBackground(color: UIColor.themeBackground)
        self.lblLoginTitle?.text = "LOGIN_LBL_TITLE".localized()
        self.lblLoginTitle?.setFont(name: FontName.Bold, size: FontSize.exLarge)
        self.lblMessage?.text = "LOGIN_LBL_MESSAGE".localized()
        self.lblMessage?.setFont(name: FontName.SemiBold, size: FontSize.subHeader)
        self.txtEmail?.placeholder = "LOGIN_TXT_EMAIL".localized()
        self.txtEmail?.delegate = self
        self.txtEmail?.configureTextField(InputTextFieldDetail.getEmailConfiguration())
        self.txtPassword?.placeholder = "LOGIN_TXT_PASSWORD".localized()
        self.txtPassword?.delegate = self
        self.txtPassword.setupPasswordTextFielad()
        self.txtPassword.configureTextField(InputTextFieldDetail.getPassowordConfiguration())
        self.btnForgotPassword?.setFont(name: FontName.Regular, size: FontSize.button_13)
        self.btnForgotPassword?.setTitle("LOGIN_BTN_FORGOT_PASSWORD".localized(), for: .normal)
        self.btnLogin?.setTitle("LOGIN_BTN_SIGN_IN".localized(), for: .normal)
        self.imgChecked?.isHidden = true
    }

    // MARK: - Action Methods
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {

    }

    @IBAction func btnLoginTapped(_ sender: UIButton) {
        self.btnLogin.isEnabled = false
        if checkValidation() {
            self.wsLogin(username: txtEmail.text!.trim(), password: txtPassword.text!)
        }
    }

    @IBAction func btnFingerPrintTapped(_ sender: UIButton) {
        self.btnFigerPrint.isEnabled = false
        self.checkFignerPrintData()
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

    func wsLogin(username:String, password:String) {
        Loader.showLoading()
        var request: User.RequestLogin = User.RequestLogin()
        request.email = username
        request.password = password
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
                if let person = CoreDataManager.sharedManager.retrive(username: request.email) {
                    print(person.username ?? "")
                    CoreDataManager.sharedManager.update(username: request.email, password: request.password)
                    Common.appDelegate.loadMainVC()
                } else {
                   
                   self.openRegisterFingerPrintDialog()
                }
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
                 guard let self = self else { return } ; print(self)
                alert?.dismiss();
                _ = self.txtEmail.becomeFirstResponder()
                self.btnLogin.isEnabled = true
            }
            
            return false
        }
        else if !txtPassword.validate().isValid {
            let alert: CustomAlert = CustomAlert.fromNib()
            alert.initialize(message: txtPassword.validate().message)
            alert.show(animated: true)
            alert.onBtnCancelTapped = {
                [weak alert, weak self] in
                 guard let self = self else { return } ; print(self)
                alert?.dismiss()
                self.btnLogin.isEnabled = true
                _ = self.txtPassword.becomeFirstResponder()
            }
            return false
        }
        return true
    }

}
//MARK: - FingerPrintAuthentication

extension LoginVC {
    
    func openPersonePickerDialog() {
        let alert: PersonPickerDialog = PersonPickerDialog.fromNib()
        alert.initialize(title: "Pick User To Login", buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_BACK".localized())
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            guard let self = self else { return } ; print(self)
            alert?.dismiss()
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self] (person) in
            guard let self = self else { return } ; print(self)
            alert?.dismiss()
            self.wsLogin(username: person.username , password: person.password)
        }
    }

    func openPasswordDialog() {
        let alert: CustomTextFieldDialog = CustomTextFieldDialog.fromNib()
        alert.initialize(title: "FINGER_PRINT_DIALOG_PASSWORD_TITLE".localized(), data: "", buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_BACK".localized())
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
    
    func openRegisterFingerPrintDialog() {
        let alertFingerPrint: FingerPrintDialog = FingerPrintDialog.fromNib()
        alertFingerPrint.initialize(title: "FINGER_PRINT_DIALOG_REGISTER_TITLE".localized(), buttonTitle: "BTN_YES_PROCEED".localized(), cancelButtonTitle: "BTN_CANCEL".localized())
        alertFingerPrint.show(animated: true)
        alertFingerPrint.onBtnCancelTapped = {
            [weak alertFingerPrint, weak self] in
            guard let self = self else {return}; print(self)
            alertFingerPrint?.dismiss();
            Common.appDelegate.loadMainVC()
        }
        alertFingerPrint.onBtnDoneTapped = {[weak alertFingerPrint, weak self] in
            guard let self = self else {return}; print(self)
            alertFingerPrint?.dismiss();
            CoreDataManager.sharedManager.create(username: self.txtEmail.text!, password: self.txtPassword.text!)
            Common.appDelegate.loadMainVC()
        }
    }
    
    func checkFignerPrintData() {
        let count = CoreDataManager.sharedManager.fetchPersons().count
        if count == 0  {
            Common.showAlert(message: "You need to do manual login first")
            self.btnFigerPrint.isEnabled = true
        } else {
            self.authenticateUser()
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
            self.btnFigerPrint.isEnabled = true
            self.openPasswordDialog()
        }
        alertFingerPrint.onBtnDoneTapped = {
            [weak alertFingerPrint, weak self] in
            guard let self = self else {return}; print(self)
            alertFingerPrint?.dismiss();
            self.btnFigerPrint.isEnabled = true
            if CoreDataManager.sharedManager.fetchPersons().count == 1 {
                if let person: Person = CoreDataManager.sharedManager.fetchPersons().first {
                    self.wsLogin(username: person.username ?? "", password: person.password ?? "")
                }
            } else {
                self.openPersonePickerDialog()
            }
        }
    }
}
// MARK: - Touch API Methods
extension LoginVC {


    func authenticateUser() {

        let context = LAContext()

        var error: NSError?

        if context.canEvaluatePolicy(
            LAPolicy.deviceOwnerAuthenticationWithBiometrics,
            error: &error) {

            // Device can use biometric authentication
            context.evaluatePolicy(
                LAPolicy.deviceOwnerAuthenticationWithBiometrics,
                localizedReason: "Access requires authentication",
                reply: {(success, error) in
                    DispatchQueue.main.async {

                        if let err = error {

                            switch err._code {

                            case LAError.Code.systemCancel.rawValue:
                                self.notifyUser("Session cancelled",
                                                err: err.localizedDescription)

                            case LAError.Code.userCancel.rawValue:
                                self.notifyUser("Please try again",
                                                err: err.localizedDescription)

                            case LAError.Code.userFallback.rawValue:
                                self.notifyUser("Authentication",
                                                err: "Password option selected")
                                // Custom code to obtain password here

                            default:
                                self.notifyUser("Authentication failed",
                                                err: err.localizedDescription)
                            }

                        } else {
                            self.imgChecked?.isHidden = false
                            if let person: Person = CoreDataManager.sharedManager.fetchPersons().first {
                                    self.wsLogin(username: person.username ?? "", password: person.password ?? "")
                            }
                            else {
                                self.openPersonePickerDialog()
                            }
                        }
                    }
            })

        } else {
            // Device cannot use biometric authentication
            if let err = error {
                switch err.code {

                case LAError.Code.biometryNotEnrolled.rawValue:
                    notifyUser("User is not enrolled",
                               err: err.localizedDescription)

                case LAError.Code.passcodeNotSet.rawValue:
                    notifyUser("A passcode has not been set",
                               err: err.localizedDescription)


                case LAError.Code.biometryNotAvailable.rawValue:
                    notifyUser("Biometric authentication not available",
                               err: err.localizedDescription)
                default:
                    notifyUser("Unknown error",
                               err: err.localizedDescription)
                }
            }
        }
        
    }


    func notifyUser(_ msg: String, err: String?) {

        let alert: CustomAlert = CustomAlert.fromNib()
        alert.initialize(message: msg.localized())
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            guard let self = self else { return } ; print(self)
            alert?.dismiss()
        }
        self.btnFigerPrint.isEnabled = true
    }
}
