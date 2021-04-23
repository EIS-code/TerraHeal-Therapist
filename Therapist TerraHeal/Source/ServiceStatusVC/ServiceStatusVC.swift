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
    private var minuteTimer: Timer?
    var serviceEndTime:Double = Date().add(component: .second, value: 20).millisecondsSince1970
    var currentTime:Double = 0.0
    var totalDuration:Double = 0.0
    var serviceStartTime: Double = Date().add(component: .second, value: -20).millisecondsSince1970
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.startTimer()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    private func initialViewSetup() {
        self.setNavigationTitle(title: "SERVICE_PROGRESS_TITLE".localized())
        self.lblMinute.setFont(name: FontName.SemiBold, size: 80.0)
        self.lblMessage?.setFont(name: FontName.Bold, size: FontSize.header)
        self.lblMessage.setText("SERVICE_DURATION".localized() + " " + appSingleton.currentService.massageDuration)
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
    func wsFinishService(id:String) {
        BookingWebSerive.finishMassageService(params: BookingWebSerive.RequestEndService.init(booking_massage_id: id, end_time: Date().millisecondsSince1970.toString()), completionHandler: {  (response) in
            if ResponseModel.isSuccess(response: response, withSuccessToast: true, andErrorToast: true) {
                Common.appDelegate.loadRateVC(navigaionVC: self.navigationController)
            }
        })
    }

}


//MARK: Timer
extension ServiceStatusVC {

    func startTimer() {
        self.serviceStartTime = appSingleton.currentService.massageStartTime.toDouble
        self.serviceEndTime = appSingleton.currentService.massageStartTime.toDouble
        self.totalDuration = (self.serviceEndTime -  self.serviceStartTime)/60000
        self.endTimer()
        self.updateServiceTimer()
        minuteTimer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { [weak self] _ in
            self?.timerTrigger()
        }
    }
    @objc private func timerTrigger() {
        if self.minuteTimer != nil {
            self.updateServiceTimer()
        }
    }
    func updateServiceTimer() {
        let differenceSecond = ((Date().millisecondsSince1970 - serviceStartTime)/60000)
        self.currentTime = differenceSecond/totalDuration
        let timeToDisplay = Int(self.totalDuration - differenceSecond)
        if timeToDisplay <= 0 {
            self.lblMinute.setTextWithAnimation(text: abs(timeToDisplay).toString())
            if self.circularProgressView.progress != 1.0 {
                self.circularProgressView.setProgressWithAnimation(duration: 0.5, value: 1.0)
                self.circularProgressView.progressClr = UIColor.red
                self.lblMinRemaining.setText("SERVICE_MIN_EXTRA".localized())
            }

        } else {
            self.circularProgressView.setProgressWithAnimation(duration: 0.5, value: Float(self.currentTime))
            self.lblMinute.setTextWithAnimation(text: timeToDisplay.toString())
        }
    }
    func configureProgress() {
        if self.circularProgressView.fromValue != 0.0 {
            self.circularProgressView.progressClr = UIColor.themeSecondary
            self.circularProgressView.fromValue = 0.0
            self.lblMinRemaining.setText("SERVICE_MIN_EXTRA".localized())
        }

    }

    func endTimer() {
        minuteTimer?.invalidate()
        minuteTimer = nil
    }
}
extension ServiceStatusVC : QRScannerCodeDelegate {
    func qrScanner(_ controller: UIViewController, scanDidComplete result: String) {
        print("\(#function)")
        self.wsFinishService(id: appSingleton.currentService.bookingMassageId)

    }

    func qrScannerDidFail(_ controller: UIViewController, error: String) {
        (controller as? BaseVC)?.popVC()
        Common.showAlert(message: error)
        print("\(#function)")
    }

    func qrScannerDidCancel(_ controller: UIViewController) {
        (controller as? BaseVC)?.popVC()
        print("\(#function)")
    }
}
