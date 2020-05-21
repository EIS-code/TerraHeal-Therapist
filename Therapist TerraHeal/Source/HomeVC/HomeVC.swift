//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit



class HomeVC: MainVC {

    @IBOutlet weak var lblMessage: ThemeLabel!
    @IBOutlet weak var lblHeader: ThemeLabel!
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
        self.lblMessage?.text = "HOME_LBL_MESSAGE".localized()
        self.lblMessage.setFont(name: FontName.Ovo, size: FontSize.label_20)
        self.lblHeader?.text = "HOME_LBL_TITLE".localized()
        self.lblHeader.setFont(name: FontName.GradDuke, size: FontSize.label_36)
        self.btnProceed.setTitle("HOME_BTN_LOGOUT".localized(), for: .normal)
        self.btnProceed.setFont(name: FontName.GradDuke, size: FontSize.button_22)
    }

    // MARK: Action Buttons
    @IBAction func btnDoneTapped(_ sender: Any) {
        Common.appDelegate.loadLoginVC()
    }

}

