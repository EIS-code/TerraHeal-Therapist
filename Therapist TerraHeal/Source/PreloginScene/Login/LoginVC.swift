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
    @IBOutlet weak var btnForgotPassword: ThemeButton!
    @IBOutlet weak var btnLogin: FilledRoundedButton!
    @IBOutlet weak var imgChecked: UIImageView!
    @IBOutlet weak var tblForData: UITableView!
    @IBOutlet weak var hTblData: NSLayoutConstraint!
    var loginForm = LoginViewModel()
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
        self.setBackground(color: UIColor.themeLightBackground)
        self.lblLoginTitle?.setText("LOGIN_LBL_TITLE".localized())
        self.lblLoginTitle?.setFont(name: FontName.Bold, size: FontSize.exLarge)
        self.lblMessage?.setText("LOGIN_LBL_MESSAGE".localized())
        self.lblMessage?.setFont(name: FontName.SemiBold, size: FontSize.regular)
        self.btnForgotPassword?.setFont(name: FontName.Regular, size: FontSize.regular)
        self.btnForgotPassword?.setText("LOGIN_BTN_FORGOT_PASSWORD".localized(), for: .normal)
        self.btnLogin?.setText("LOGIN_BTN_SIGN_IN".localized(), for: .normal)
        self.imgChecked?.isHidden = true
        self.setupTableView(tableView: self.tblForData)
    }

    // MARK: - Action Methods
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {

    }

    @IBAction func btnLoginTapped(_ sender: UIButton) {
        self.btnLogin.tempDisable()
        let (isValid,strMessage) = loginForm.isValid()
        if isValid {
            self.wsLogin(username: loginForm.username!, password: loginForm.password!)
        } else {
            Common.showAlert(message: strMessage)
        }

    }

    @IBAction func btnFingerPrintTapped(_ sender: UIButton) {
        self.btnFigerPrint.isEnabled = false
        self.checkFignerPrintData()
    }
}

// MARK: - Web API Methods
extension LoginVC {

    func wsLogin(username:String, password:String) {
        Loader.showLoading()
        self.btnLogin.isEnabled = false
        var request: UserWebService.RequestLogin = UserWebService.RequestLogin()
        request.email = username
        request.password = password
        UserWebService.callLoginAPI(params: request) { response in
            Loader.hideLoading()
            self.btnLogin?.isEnabled = true
            if ResponseModel.isSuccess(response: response, withSuccessToast: false, andErrorToast: true) {
                let user = response.data
                 PreferenceHelper.shared.setUserId(user.id)
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
}






