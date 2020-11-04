//
//  Created by Jaydeep VyasUnderlineTextButton
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit

class ServiceStatusVC: BaseVC {

    @IBOutlet weak var vwContent: UIView!
    @IBOutlet weak var lblMessage: ThemeLabel!
    @IBOutlet weak var btnSubmit: FilledRoundedButton!
    @IBOutlet weak var vwCircle: DashedCircleView!
    @IBOutlet weak var circularProgressView: CircularProgressView!
    @IBOutlet weak var lblMinute: ThemeLabel!
    @IBOutlet weak var lblMinRemaining: ThemeLabel!

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
        circularProgressView.progressClr = UIColor.themePrimary
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if self.isViewAvailable() {
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        circularProgressView.setProgressWithAnimation(duration: 0.5, value: 0.6)
    }

    private func initialViewSetup() {
        self.setNavigationTitle(title: "SERVICE_PROGRESS_TITLE".localized())
        self.lblMinute.setFont(name: FontName.SemiBold, size: 80.0)
        self.lblMessage?.setFont(name: FontName.Bold, size: FontSize.header)
        self.lblMessage.setText("SERVICE_DURATION".localized() + " 90 min")
         self.lblMinRemaining.setFont(name: FontName.Bold, size: FontSize.header)
        self.lblMinRemaining.setText("SERVICE_MIN_REMAINING".localized())
        self.btnSubmit?.setText("SERVICE_PROGRESS_BTN_FINISH".localized())
    }
    
    // MARK: - Action Methods
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        _ = self.popVC()
    }

    @IBAction func btnSubmitTapped(_ sender: UIButton) {
        self.btnSubmit.isEnabled = false
        self.openScanQrDialog()
    }
    func openScanQrDialog() {
        let scanDialog: ScanDialog = ScanDialog.fromNib()
        scanDialog.initialize(title: "DIALOG_SCAN_TITLE".localized(), buttonTitle: "DIALOG_BTN_SCAN".localized(), cancelButtonTitle: "".localized())
        scanDialog.show(animated: true)

        scanDialog.onBtnDoneTapped = { [weak scanDialog, weak self]  in
            guard let self = self else {
                return
            }
            scanDialog?.dismiss()
            self.btnSubmit.isEnabled = true
            self.openCameraVC()
        }
        scanDialog.onBtnCancelTapped = { [weak scanDialog, weak self]  in
            guard let self = self else {
                return
            }
            scanDialog?.dismiss()
            self.btnSubmit.isEnabled = true

        }
    }
    func openCameraVC() {
        Common.appDelegate.loadScanVC(navigaionVC: self.navigationController) { (scanVC) in
                   print("\(scanVC)")
                   scanVC.delegate = self
               }
    }
}



extension ServiceStatusVC : QRScannerCodeDelegate {
    func qrScanner(_ controller: UIViewController, scanDidComplete result: String) {
        print("\(#function)")
        (controller as? BaseVC)?.popVC()
        Common.appDelegate.loadRateVC(navigaionVC: self.navigationController)
    }

    func qrScannerDidFail(_ controller: UIViewController, error: String) {
        print("\(#function)")
    }

    func qrScannerDidCancel(_ controller: UIViewController) {
        print("\(#function)")
    }
}
