//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit



class TherapistKycVC: MainVC {


    @IBOutlet weak var btnNext: ThemeButton!
    @IBOutlet weak var btnDone: ThemeButton!
    @IBOutlet weak var lblHeader: ThemeLabel!
    @IBOutlet weak var lblMessage: ThemeLabel!

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
        self.btnDone?.setUpRoundedButton()
    }

    private func initialViewSetup() {
        self.vwBar?.backgroundColor = UIColor.clear

        self.btnNext?.setTitle("T_KYC_BTN_PROCEED".localized(), for: .normal)
        self.btnNext?.setFont(name: FontName.GradDuke, size: FontSize.button_22)

        self.lblHeader?.text = "T_KYC_LBL_TITLE".localized()
        self.lblHeader?.setFont(name: FontName.GradDuke, size: FontSize.label_26)

        self.lblMessage?.text = "T_KYC_LBL_MESSAGE".localized()
        self.lblMessage?.setFont(name: FontName.Ovo, size: FontSize.label_18)

    }

    // MARK: - Action Methods
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnSkipTapped(_ sender: Any) {
        self.btnDone.isEnabled = false
        self.btnNext.isEnabled = false
        Common.appDelegate.loadHomeVC()
    }

    @IBAction func btnNextTapped(_ sender: Any) {
        self.btnDone.isEnabled = false
        self.btnNext.isEnabled = false
        Common.appDelegate.loadTherapistKycInfoVC()
    }


}

