//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit



class LoginVC: MainVC {

    @IBOutlet weak var scrVw: UIScrollView!
    @IBOutlet weak var vwContent: UIView!
    @IBOutlet weak var hVwContent: NSLayoutConstraint!


    @IBOutlet weak var lblLoginTitle: ThemeLabel!
    @IBOutlet weak var lblMessage: ThemeLabel!
    

    @IBOutlet weak var txtEmail: ACFloatingTextfield!
    @IBOutlet weak var txtPassword: ACFloatingTextfield!
    @IBOutlet weak var btnForgotPassword: UnderlineTextButton!
    @IBOutlet weak var btnLogin: ThemeButton!
    @IBOutlet weak var btnSignUp: ThemeButton!
    @IBOutlet weak var btnDone: ThemeButton!


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
        btnDone?.setUpRoundedButton()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        _ = self.txtEmail?.becomeFirstResponder()
    }

    private func initialViewSetup() {
        self.vwBar?.backgroundColor = UIColor.clear
        self.lblLoginTitle?.text = "LOGIN_LBL_TITLE".localized()
        self.lblLoginTitle?.setFont(name: FontName.GradDuke, size: FontSize.label_26)
        self.lblMessage?.text = "LOGIN_LBL_MESSAGE".localized()
        self.lblMessage?.setFont(name: FontName.Ovo, size: FontSize.label_18)
        self.txtEmail?.placeholder = "LOGIN_TXT_EMAIL".localized()
        self.txtEmail?.delegate = self
        self.txtPassword?.placeholder = "LOGIN_TXT_PASSWORD".localized()
        self.txtPassword?.delegate = self
        self.btnForgotPassword?.setFont(name: FontName.GradDuke, size: FontSize.button_20)
        self.btnForgotPassword?.setTitle("LOGIN_BTN_FORGOT_PASSWORD".localized(), for: .normal)
        self.btnSignUp?.setTitle("LOGIN_BTN_SIGN_UP".localized(), for: .normal)
        self.btnSignUp?.setFont(name: FontName.GradDuke, size: FontSize.button_22)
        self.btnLogin?.setTitle("LOGIN_BTN_SIGN_IN".localized(), for: .normal)
        self.btnLogin?.setFont(name: FontName.GradDuke, size: FontSize.button_22)
    }


    // MARK: - Action Methods
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnLoginTapped(_ sender: UIButton) {
        //self.uploadFile()

        if checkValidation() {
            self.btnLogin?.isEnabled = false
            self.btnDone?.isEnabled = false
            self.wsLogin()
        }
    }
    @IBAction func btnSignUpTapped(_ sender: Any) {
        Common.appDelegate.loadRegisterVC(navigaionVC: self.navigationController)
    }

    @IBAction func btnForgotPasswordTapped(_ sender: UIButton) {
        Common.appDelegate.loadTouchIdVC(navigaionVC: self.navigationController)
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


    func checkValidation() -> Bool {

        if !txtEmail.text!.isValidEmail() {
            let alert: CustomAlert = CustomAlert.fromNib()
            alert.initialize(message: "VALIDATION_MSG_INVALID_EMAIL".localized())
            alert.show(animated: true)
            alert.onBtnCancelTapped = {
                [weak alert, weak self] in
                alert?.dismiss();
                _ = self?.txtEmail.becomeFirstResponder()
            }
            return false
        }
        else if txtPassword.text!.isEmpty {
            let alert: CustomAlert = CustomAlert.fromNib()
            alert.initialize(message: "VALIDATION_MSG_INVALID_PASSWORD".localized())
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
//MARK:  Web Service Calls
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
            self.btnDone?.isEnabled = true
            if ResponseModel.isSuccess(response: model, withSuccessToast: true, andErrorToast: true) {
                if let user = response.data.first {
                    PreferenceHelper.shared.setUserId(user.id)
                    //PreferenceHelper.shared.setSessionToken(user.token)
                    Singleton.shared.user = user
                    Singleton.saveInDb()
                    Common.appDelegate.loadTherapistProfileVC()
                }

            } else {
                print(response.message)
            }
        }
    }

    

}
