//
//  Created by Jaydeep VyasUnderlineTextButton
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit

class ServiceStatusVC: MainVC {

    @IBOutlet weak var scrVw: UIScrollView!
    @IBOutlet weak var vwContent: UIView!
    @IBOutlet weak var lblMessage: ThemeLabel!
    @IBOutlet weak var btnSubmit: ThemeButton!
    @IBOutlet weak var vwCircle: DashedCircleView!
    
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
            self.btnSubmit.layoutIfNeeded()
            self.btnSubmit.setHighlighted(isHighlighted: true)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
       
    }

    private func initialViewSetup() {
        self.setTitle(title: "SERVICE_PROGRESS_TITLE".localized())
        //self.lblMessage?.text = "LOGIN_LBL_MESSAGE".localized()
        self.lblMessage?.setFont(name: FontName.Regular, size: FontSize.label_18)
        self.btnSubmit?.setFont(name: FontName.SemiBold, size: FontSize.button_14)
        self.btnSubmit?.setTitle("SERVICE_PROGRESS_BTN_FINISH".localized(), for: .normal)
        self.btnSubmit.setHighlighted(isHighlighted: true)
      
    }
    
    // MARK: - Action Methods
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        _ = _ = (self.navigationController as? NC)?.popVC()
    }

    @IBAction func btnSubmitTapped(_ sender: UIButton) {
        self.openScanQrDialog()
    }
    func openScanQrDialog() {
        let scanQrDialog: ScanQRDialog = ScanQRDialog.fromNib()
        scanQrDialog.initialize(title: "Scan QR", buttonTitle: "", cancelButtonTitle: "BTN_BACK".localized())
        scanQrDialog.show(animated: true)
        scanQrDialog.onBtnCancelTapped = {
            [weak scanQrDialog, weak self] in
            guard let self = self else {return}; print(self)
            scanQrDialog?.dismiss();
        }
        scanQrDialog.onBtnDoneTapped = {
            [weak scanQrDialog, weak self] in
            guard let self = self else {return}; print(self)
            scanQrDialog?.dismiss()
            Common.appDelegate.loadCameraVC(navigaionVC: self.navigationController)
        }
    }
}

