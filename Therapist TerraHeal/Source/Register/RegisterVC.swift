//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit



class RegisterVC: MainVC {

    @IBOutlet weak var scrVw: UIScrollView!
    @IBOutlet weak var vwContent: UIView!
    @IBOutlet weak var hVwContent: NSLayoutConstraint!

    @IBOutlet weak var lblMessage: ThemeLabel!
    @IBOutlet weak var txtName: ACFloatingTextfield!
    @IBOutlet weak var txtEmail: ACFloatingTextfield!
    @IBOutlet weak var txtPassword: ACFloatingTextfield!
    @IBOutlet weak var txtConfirmPassword: ACFloatingTextfield!
    @IBOutlet weak var btnSignUp: ThemeButton!
    @IBOutlet weak var btnDone: ThemeButton!
    @IBOutlet weak var btnFacebook: ThemeButton!
    @IBOutlet weak var btnGoogle: ThemeButton!

    @IBOutlet weak var btnLogin: UnderlineTextButton!
    @IBOutlet weak var lblAlreadyMember: ThemeLabel!

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
        btnGoogle?.setRound(withBorderColor: .clear, andCornerRadious: 5.0, borderWidth: 1.0)
        btnLogin?.setRound(withBorderColor: .clear, andCornerRadious: 5.0, borderWidth: 1.0)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        _ = self.txtName?.becomeFirstResponder()
    }
    private func initialViewSetup() {
        self.vwBar?.backgroundColor = UIColor.clear
        self.lblMessage?.text = "REGISTER_LBL_MESSAGE".localized()
        self.lblMessage?.setFont(name: FontName.GradDuke, size: FontSize.label_36)
        self.txtName?.placeholder = "REGISTER_TXT_NAME".localized()
        self.txtName?.delegate = self
        self.txtEmail?.placeholder = "REGISTER_TXT_EMAIL".localized()
        self.txtEmail?.delegate = self
        self.txtPassword?.placeholder = "REGISTER_TXT_PASSWORD".localized()
        self.txtPassword?.delegate = self
        self.txtConfirmPassword?.placeholder = "REGISTER_TXT_CONFIRM_PASSWORD".localized()
        self.txtConfirmPassword?.delegate = self
        self.btnLogin?.setFont(name: FontName.GradDuke, size: FontSize.button_22)
        self.btnLogin?.setTitle("REGISTER_BTN_SIGN_IN".localized(), for: .normal)
        self.btnSignUp?.setTitle("REGISTER_BTN_SIGN_UP".localized(), for: .normal)
        self.btnSignUp?.setFont(name: FontName.GradDuke, size: FontSize.button_22)
        self.lblAlreadyMember?.text = "REGISTER_LBL_ALREADY_A_MEMBER".localized()
        self.lblAlreadyMember?.setFont(name: FontName.Ovo, size: FontSize.label_18)

    }


    // MARK: - Action Methods
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnLoginTapped(_ sender: UIButton) {
        Common.appDelegate.loadLoginVC(navigaionVC: self.navigationController)
    }

    @IBAction func btnRegisterTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        if checkValidation() {
            sender.isEnabled = false
            self.wsRegister()
        }
    }

}

extension RegisterVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtName {
            _ = txtEmail?.becomeFirstResponder()
        } else if textField == txtEmail {
            _ = txtPassword?.becomeFirstResponder()
        } else if textField == txtPassword {
            _ = txtConfirmPassword?.becomeFirstResponder()
        } else if textField == txtConfirmPassword {
            _ = txtConfirmPassword?.resignFirstResponder()
        }
        return true
    }
}

extension RegisterVC {

    func checkValidation() -> Bool {

        if txtName.text!.isEmpty() {
            let alert: CustomAlert = CustomAlert.fromNib()
            alert.initialize(message: "VALIDATION_MSG_INVALID_NAME".localized())
            alert.show(animated: true)
            alert.onBtnCancelTapped = {
                    [weak alert, weak self] in
                    alert?.dismiss()
                    _ = self?.txtName.becomeFirstResponder()
            }
            return false
        } else if !txtEmail.text!.isValidEmail() {
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
        } else if txtPassword.text! != txtConfirmPassword.text! {
            let alert: CustomAlert = CustomAlert.fromNib()
            alert.initialize(message: "VALIDATION_MSG_MISMATCH_CONFIRM_PASSWORD".localized())
            alert.show(animated: true)
            alert.onBtnCancelTapped = {
                [weak alert, weak self] in
                alert?.dismiss()
                _ = self?.txtConfirmPassword.becomeFirstResponder()

            }
            return false
        }
        return true
    }

}
//MARK:  Web Service Calls
extension RegisterVC {

    func wsRegister() {
        Loader.showLoading()
        var request: User.RequestRegister = User.RequestRegister()
        request.email = txtEmail.text?.trim() ?? ""
        request.password = txtPassword.text!
        request.name = (txtName.text?.trim())!
        AppWebApi.register(params: request) { (response) in
            let model: ResponseModel = ResponseModel.init(fromDictionary: response.toDictionary())
            Loader.hideLoading()
            self.btnSignUp?.isEnabled = true
            if let user = response.data.first {
                PreferenceHelper.shared.setUserId(user.id)
                //PreferenceHelper.shared.setSessionToken(user.token)
                Singleton.shared.user = user
                Singleton.saveInDb()
                Common.appDelegate.loadTherapistProfileVC()
            }
        }
    }
}
