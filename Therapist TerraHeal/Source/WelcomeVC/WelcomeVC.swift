//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit



class WelcomeVC: MainVC {

    @IBOutlet weak var lblMessage: ThemeLabel!
    @IBOutlet weak var lblHeader: ThemeLabel!
    @IBOutlet weak var vwClient: UIView!
    @IBOutlet weak var btnClient: ThemeButton!
    @IBOutlet weak var vwTherapist: UIView!
    @IBOutlet weak var btnTherapist: ThemeButton!
    @IBOutlet weak var btnProceed: ThemeButton!
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
        self.lblMessage?.text = "WELCOME_LBL_MESSAGE".localized()
        self.lblMessage.setFont(name: FontName.Ovo, size: FontSize.label_20)

        self.lblHeader?.text = "WELCOME_LBL_I_AM".localized()
        self.lblHeader.setFont(name: FontName.GradDuke, size: FontSize.label_36)
        self.btnClient.setTitle("WELCOME_BTN_CLIENT".localized(), for: .normal)
        self.btnClient.setFont(name: FontName.Ovo, size: FontSize.button_18)
        self.btnTherapist.setTitle("WELCOME_BTN_THERAPIST".localized(), for: .normal)
        self.btnTherapist.setFont(name: FontName.Ovo, size: FontSize.button_18)

        self.btnProceed.setTitle("WELCOME_BTN_PROCEED".localized(), for: .normal)
        self.btnProceed.setFont(name: FontName.GradDuke, size: FontSize.button_22)


    }


    // MARK: Action Buttons
    @IBAction func btnDoneTapped(_ sender: Any) {
        Common.appDelegate.loadTutoraiVC(navigaionVC: self.navigationController)
    }

    // MARK: Other Functions

}

