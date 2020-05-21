//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit
import LocalAuthentication



class TouchIdVC: MainVC {



    @IBOutlet weak var lblTouchIDTitle: ThemeLabel!
    @IBOutlet weak var lblMessage: ThemeLabel!
    @IBOutlet weak var btnUsePassword: UnderlineTextButton!
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
        imgChecked?.setRound()
    }

    private func initialViewSetup() {
        self.vwBar?.backgroundColor = UIColor.clear
        self.lblTouchIDTitle?.text = "TOUCH_ID_LBL_TITLE".localized()
        self.lblTouchIDTitle?.setFont(name: FontName.GradDuke, size: FontSize.label_26)
        self.lblMessage?.text = "TOUCH_ID_LBL_MESSAGE".localized()
        self.lblMessage?.setFont(name: FontName.Ovo, size: FontSize.label_18)
        self.imgChecked?.isHidden = true
        self.btnUsePassword?.setFont(name: FontName.GradDuke, size: FontSize.button_20)
        self.btnUsePassword?.setTitle("TOUCH_ID_BTN_USE_PASSWORD".localized(), for: .normal)
    }




    // MARK: - Action Methods
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnUsePasswordTapped(_ sender: UIButton) {
        Common.appDelegate.loadLoginVC(navigaionVC: self.navigationController)
    }

    @IBAction func btnFingerPrintTapped(_ sender: UIButton) {
        authenticateUser(self)
    }


}

// MARK: - Web API Methods
extension TouchIdVC {

    private func wsLogin() {

    }

    func checkValidation() -> Bool {

        return true
    }

     func authenticateUser(_ sender: Any) {

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
            [weak alert/*,weak self*/] in
            alert?.dismiss()
        }
    }
}
