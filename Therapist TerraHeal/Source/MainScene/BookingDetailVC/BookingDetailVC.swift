//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit


class BookingDetailVC: BaseVC {
    
    @IBOutlet weak var btnStart: FilledRoundedButton!
    @IBOutlet weak var btnCancel: RoundedBorderButton!
    @IBOutlet weak var btnNavigation: UIButton!

    //MARK: Card1
    @IBOutlet weak var vwForCard1: ThemeCardView!
    @IBOutlet weak var tblForCard1: UITableView!
    @IBOutlet weak var hTblCard1: NSLayoutConstraint!
    @IBOutlet weak var lblBookingId: ThemeLabel!
    @IBOutlet weak var btnRoomNumber: UIButton!
    var arrForTbl1:  [(title:String, detail:String)] = []
    //MARK: Card2
    @IBOutlet weak var vwForCard2: ThemeCardView!
    @IBOutlet weak var tblForCard2: UITableView!
    @IBOutlet weak var hTblCard2: NSLayoutConstraint!
    var arrForTbl2:  [(title:String, detail:String)] = []
    //MARK: Card3
    @IBOutlet weak var vwForCard3: ThemeCardView!
    @IBOutlet weak var tblForCard3: UITableView!
    @IBOutlet weak var hTblCard3: NSLayoutConstraint!
    var arrForTbl3:  [(title:String, detail:String)] = []

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
        vwForCard1.topRound()
        vwForCard1.addGradientFade(colors: [UIColor.init(hex: "#FFFFFF57").cgColor,UIColor.init(hex: "#F6F6F4").cgColor,UIColor.init(hex: "#F6F6F4").cgColor])

        vwForCard2.topRound()
        vwForCard2.addGradientFade(colors: [UIColor.init(hex: "##F6F6F4").cgColor,UIColor.init(hex: "#F6F6F4C8").cgColor,UIColor.init(hex: "#F6F6F48A").cgColor,UIColor.init(hex: "#F6F6F4").cgColor])
        vwForCard3.topRound()
        vwForCard3.addGradientFade(colors: [UIColor.init(hex: "#F6F6F4").cgColor,UIColor.init(hex: "#FFFFF8").cgColor])
        self.wsGetBookingDetil(id: appSingleton.currentService.bookingInfoId)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    func updateViewForBookingType() {
        if appSingleton.currentService.bookingType == BookingType.MassageCenter.rawValue {
            btnRoomNumber.isHidden = false
            btnNavigation.isHidden = true
            self.btnStart.setText("BOOKING_DETAILS_BTN_START".localized())
            self.btnCancel.setText("BOOKING_DETAILS_BTN_CANCEL".localized())
        } else {
            btnRoomNumber.isHidden = true
            btnNavigation.isHidden = false
            self.btnStart.setText("BOOKING_DETAILS_BTN_I_GO".localized())
            self.btnCancel.setText("BOOKING_DETAILS_BTN_I_AM_SAFE".localized())
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if self.isViewAvailable() {
            self.tblForCard1.reloadData(heightToFit: self.hTblCard1) {
            }
            self.tblForCard2.reloadData(heightToFit: self.hTblCard2) {
            }
            self.tblForCard3.reloadData(heightToFit: self.hTblCard3) {
            }
        }
    }
    
    private func initialViewSetup() {
        self.setBackground(color: UIColor.themeWhite)
        self.setupTableView(tableView: self.tblForCard1)
        self.setupTableView(tableView: self.tblForCard2)
        self.setupTableView(tableView: self.tblForCard3)
        self.setNavigationTitle(title:"BOOKING_DETAILS_TITLE".localized())
        self.vwNavigationBar.backgroundColor = .white
        self.lblBookingId.setFont(name: FontName.SemiBold, size: FontSize.subHeader)
        self.btnRoomNumber.backgroundColor = UIColor.themeSecondary
        self.btnRoomNumber.setTitleColor(UIColor.themeLightTextColor, for: .normal)
        self.btnRoomNumber.setRound()
        if appSingleton.bookingTypeSelected != .Today {
            self.btnStart.isHidden = true
            self.btnCancel.isHidden = true
        } else {
            self.btnStart.isHidden = false
            self.btnCancel.isHidden = false
        }
    }

    
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        super.btnLeftTapped()
        self.popVC()
    }
    
    @IBAction func btnStartTapped(_ sender: Any) {
        btnStart.isEnabled = false
        self.openScanDialog()
    }

    @IBAction func btnCancelTapped(_ sender: Any) {
        self.popVC()
    }

    @IBAction func btnNavigationTapped(_ sender: Any) {
        self.btnNavigation.isEnabled = false
        Common.appDelegate.loadServiceNavigationVC(navigaionVC: self.navigationController) { [weak self] (vc) in
            guard let self = self else { return}
            self.btnNavigation.isEnabled = true
        }
    }

    func openScanDialog() {
        let scanDialog: ScanDialog = ScanDialog.fromNib()
        scanDialog.initialize(title: "DIALOG_SCAN_TITLE".localized(), buttonTitle: "DIALOG_BTN_SCAN".localized(), cancelButtonTitle: "".localized())
        scanDialog.show(animated: true)
        scanDialog.onBtnDoneTapped = { [weak scanDialog, weak self]  in
            guard let self = self else {
                return
            }
            scanDialog?.dismiss()
            self.btnStart.isEnabled = true
            self.openCameraVC()
        }
        scanDialog.onBtnCancelTapped = { [weak scanDialog, weak self]  in
            guard let self = self else {
                return
            }
            scanDialog?.dismiss()
            self.btnStart.isEnabled = true

        }
    }
    func openCameraVC() {
        Common.appDelegate.loadScanVC(navigaionVC: self.navigationController) { (scanVC) in
            print("\(scanVC)")
            scanVC.delegate = self
        }
    }
}

extension BookingDetailVC : QRScannerCodeDelegate {
    func qrScanner(_ controller: UIViewController, scanDidComplete result: String) {
        print("\(#function)")
        self.wsStartService(id: appSingleton.currentService.bookingMassageId)
    }

    func qrScannerDidFail(_ controller: UIViewController, error: String) {
        print("\(#function)")
    }

    func qrScannerDidCancel(_ controller: UIViewController) {
        print("\(#function)")
    }
}

extension BookingDetailVC {
    func wsGetBookingDetil(id:String) {
        BookingWebSerive.getBookingDetail(params: BookingWebSerive.RequestBookingDetail.init(booking_info_id: id)) { (response) in
            if ResponseModel.isSuccess(response: response) {
                appSingleton.currentService = response.bookingDetail
                self.setupData(bookingDetail: appSingleton.currentService )
            }
        }
    }

    func wsStartService(id:String) {
        BookingWebSerive.startMassageService(params: BookingWebSerive.RequestStartService.init(booking_massage_id: id, start_time: Date().millisecondsSince1970.toString()), completionHandler: {  (response) in
            if ResponseModel.isSuccess(response: response, withSuccessToast: true, andErrorToast: true) {
                Common.appDelegate.loadServiceStatusVC(navigaionVC: self.navigationController)
            }
        })
    }


    

    func setupData(bookingDetail:BookingDetail) {
        self.lblBookingId.setText(bookingDetail.bookingInfoId)
        //self.btnRoomNumber.setText(bookingDetail.rooomId)

        self.arrForTbl1 = [
            (title: "BOOKING_DETAIL_CLIENT_NAME".localized(), detail: bookingDetail.clientName),
            (title: "BOOKING_DETAIL_TYPE_OF_SERVICE".localized(), detail: bookingDetail.massageName )
        ]
        let date = Date.init(milliseconds: bookingDetail.massageDate.toDouble).toString(format: "dd MMM yyyy")
        let startTime = Date.init(milliseconds: bookingDetail.massageStartTime.toDouble).toString(format: "hh:mm a")
        let endTime = Date.init(milliseconds: bookingDetail.massageEndTime.toDouble).toString(format: "hh:mm a")
        self.arrForTbl2 = [
            (title: "BOOKING_DETAIL_SESSION_TYPE".localized(), detail: bookingDetail.sessionType),
            (title: "BOOKING_DETAIL_DATE_AND_TIME".localized(), detail: date + "\n" + startTime + " - " + endTime),
            (title: "BOOKING_DETAIL_PRESSURE_PREFERENCE".localized(), detail: bookingDetail.pressurePreference)
        ]
        self.arrForTbl3 = [
            (title: "BOOKING_DETAIL_SERVICE_DETAILS".localized(), detail: bookingDetail.pressurePreference),
            (title: "BOOKING_DETAIL_NOTES".localized(), detail: bookingDetail.notes),
            (title: "BOOKING_DETAIL_FOCUS_AREA".localized(), detail: bookingDetail.focusArea)
        ]
        self.tblForCard1.reloadData()
        self.tblForCard2.reloadData()
        self.tblForCard3.reloadData()
        self.updateViewForBookingType()
    }
}


