//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit



class IdentityVerificationInstructionVC: MainVC {



    @IBOutlet weak var lblHeader: ThemeLabel!
    @IBOutlet weak var lblMessage: ThemeLabel!
    @IBOutlet var vwBg: UIView!

    @IBOutlet weak var btnInfo1: ThemeButton!
    @IBOutlet weak var lblInfo1Title: ThemeLabel!
    @IBOutlet weak var lblInfo1Detail: ThemeLabel!

    @IBOutlet weak var btnInfo2: ThemeButton!
    @IBOutlet weak var lblInfo2Title: ThemeLabel!
    @IBOutlet weak var lblInfo2Detail: ThemeLabel!

    @IBOutlet weak var btnInfo3: ThemeButton!
    @IBOutlet weak var lblInfo3Title: ThemeLabel!
    @IBOutlet weak var lblInfo3Detail: ThemeLabel!
    @IBOutlet weak var btnPrivacyPolicy: ThemeButton!

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
        self.vwBg?.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
        self.btnInfo1?.setRound()
        self.btnInfo2?.setRound()
        self.btnInfo3?.setRound()

    }

    private func initialViewSetup() {
        self.vwBar?.backgroundColor = UIColor.clear

        self.lblHeader?.text = "T_IDENTITY_VERIFICATION_LBL_TITLE".localized()
        self.lblHeader?.setFont(name: FontName.GradDuke, size: FontSize.label_26)

        self.lblMessage?.text = "T_IDENTITY_VERIFICATION_LBL_MESSAGE".localized()
        self.lblMessage?.setFont(name: FontName.Ovo, size: FontSize.label_18)

        self.lblInfo1Title?.text = "T_IDENTITY_VERIFICATION_LBL_INFO_1_TITLE".localized()
        self.lblInfo1Title?.setFont(name: FontName.GradDuke, size: FontSize.label_18)

        self.lblInfo1Detail?.text = "T_IDENTITY_VERIFICATION_LBL_INFO_1_MESSAGE".localized()
        self.lblInfo1Detail?.setFont(name: FontName.Ovo, size: FontSize.label_14)

        self.lblInfo2Title?.text = "T_IDENTITY_VERIFICATION_LBL_INFO_2_TITLE".localized()
        self.lblInfo2Title?.setFont(name: FontName.GradDuke, size: FontSize.label_18)

        self.lblInfo2Detail?.text = "T_IDENTITY_VERIFICATION_LBL_INFO_2_MESSAGE".localized()
        self.lblInfo2Detail?.setFont(name: FontName.Ovo, size: FontSize.label_14)

        self.lblInfo3Title?.text = "T_IDENTITY_VERIFICATION_LBL_INFO_3_TITLE".localized()
        self.lblInfo3Title?.setFont(name: FontName.GradDuke, size: FontSize.label_18)

        self.lblInfo3Detail?.text = "T_IDENTITY_VERIFICATION_LBL_INFO_3_MESSAGE".localized()
        self.lblInfo3Detail?.setFont(name: FontName.Ovo, size: FontSize.label_14)


        let attributedString = NSMutableAttributedString.init(string: "T_IDENTITY_VERIFICATION_LBL_PRIVACY_POLICY_".localized())
        attributedString.append("T_IDENTITY_VERIFICATION_BTN_PRIVACY_POLICY_".localized().getUnderLineAttributedText())



        self.btnPrivacyPolicy.titleLabel?.numberOfLines = 0
        self.btnPrivacyPolicy.titleLabel?.lineBreakMode = .byWordWrapping
        self.btnPrivacyPolicy?.setAttributedTitle(attributedString, for: .normal)
        self.btnPrivacyPolicy?.setFont(name: FontName.Ovo, size: FontSize.button_18)


    }

    // MARK: - Action Methods
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnPrivacyTapped(_ sender: Any) {
        Common.appDelegate.loadPaymentAccountVC(navigaionVC: self.navigationController)
    }

    @IBAction func btnProofOfAddress(_ sender: UIButton) {
        sender.isEnabled = false
        let alert: UploadDocumentDialog = UploadDocumentDialog.fromNib()
        alert.initialize(message: "Upload your proof of address from here securely.", documentCount: 0)
        alert.show(animated: true)
        alert.onBtnDoneTapped = { [weak alert, weak self] (documents:[UploadDocumentDetail]) in
            alert?.dismiss()
            sender.isEnabled = true
        }
        alert.onBtnCancelTapped = { [weak alert, weak self] in
            alert?.dismiss()
            sender.isEnabled = true
        }
    }

    @IBAction func btnProofOfIdentity(_ sender: UIButton) {

        sender.isEnabled = false
        let alert: UploadDocumentDialog = UploadDocumentDialog.fromNib()
        alert.initialize(message: "Upload your proof of identity here securely.", documentCount: 2)
        alert.show(animated: true)
        alert.onBtnDoneTapped = { [weak alert, weak self] (documents:[UploadDocumentDetail]) in
            alert?.dismiss()
            sender.isEnabled = true
        }
        alert.onBtnCancelTapped = { [weak alert, weak self] in
            alert?.dismiss()
            sender.isEnabled = true
        }
    }

    @IBAction func btnProofOfAssurance(_ sender: UIButton) {
        sender.isEnabled = false
        let alert: UploadDocumentDialog = UploadDocumentDialog.fromNib()
        alert.initialize(message: "Upload your proof of insurance here securely.", documentCount:1)
        alert.show(animated: true)
        alert.onBtnDoneTapped = { [weak alert, weak self] (documents:[UploadDocumentDetail]) in
            alert?.dismiss()
            sender.isEnabled = true
            self?.uploadFile()
        }
        alert.onBtnCancelTapped = { [weak alert, weak self] in
            alert?.dismiss()
            sender.isEnabled = true
        }

    }

    func uploadFile() {
        AppWebApi.uploadDocument(params: User.RequestUploadDocument(), documents:  ["file":UIImage(named: "asset-cancel")!,"test":UIImage(named: "asset-cancel")!]) { (response) in
            print(response)
        }

    }
}

