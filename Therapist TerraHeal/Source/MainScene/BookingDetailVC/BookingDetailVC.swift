//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit

struct BookingDetail {
    var title: String = ""
    var detail: String = ""
}
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
    var arrForTbl1:  [BookingDetail] = []
    //MARK: Card2
    @IBOutlet weak var vwForCard2: ThemeCardView!
    @IBOutlet weak var tblForCard2: UITableView!
    @IBOutlet weak var hTblCard2: NSLayoutConstraint!
    var arrForTbl2:  [BookingDetail] = []
    //MARK: Card3
    @IBOutlet weak var vwForCard3: ThemeCardView!
    @IBOutlet weak var tblForCard3: UITableView!
    @IBOutlet weak var hTblCard3: NSLayoutConstraint!
    var arrForTbl3:  [BookingDetail] = []

    var bookingDetail:MyBookingData = MyBookingData.init(fromDictionary: [:])

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
        self.arrForTbl1 = [BookingDetail.init(title: "client name", detail: bookingDetail.clientName),
                           BookingDetail.init(title: "type of service", detail: bookingDetail.massageDetail.first!.name + " " + bookingDetail.massageDetail.first!.time + " " + "min")]
        self.arrForTbl2 = [BookingDetail.init(title: "session type", detail: bookingDetail.sessionType),
        BookingDetail.init(title: "date & time", detail: bookingDetail.massageDate + "\n" + bookingDetail.massageTime),
        BookingDetail.init(title: "pressure preference", detail: bookingDetail.pressurePreference)]

        self.arrForTbl3 = [BookingDetail.init(title: "Service Details", detail: bookingDetail.pressurePreference),
               BookingDetail.init(title: "notes", detail: bookingDetail.notes),
               BookingDetail.init(title: "focus area", detail: bookingDetail.focusPreference)]

        self.initialViewSetup()
        vwForCard1.topRound()
        vwForCard1.addGradientFade(colors: [UIColor.init(hex: "#FFFFFF57").cgColor,UIColor.init(hex: "#F6F6F4").cgColor,UIColor.init(hex: "#F6F6F4").cgColor])

        vwForCard2.topRound()
        vwForCard2.addGradientFade(colors: [UIColor.init(hex: "##F6F6F4").cgColor,UIColor.init(hex: "#F6F6F4C8").cgColor,UIColor.init(hex: "#F6F6F48A").cgColor,UIColor.init(hex: "#F6F6F4").cgColor])
        vwForCard3.topRound()
        vwForCard3.addGradientFade(colors: [UIColor.init(hex: "#F6F6F4").cgColor,UIColor.init(hex: "#FFFFF8").cgColor])
        
        self.updateViewForBookingType()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    func updateViewForBookingType() {
        if bookingDetail.bookingType == BookingType.MassageCenter.rawValue {
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
        self.lblBookingId.setText("062488475")
        self.lblBookingId.setFont(name: FontName.SemiBold, size: FontSize.subHeader)
        self.btnRoomNumber.setText("01")
        self.btnRoomNumber.backgroundColor = UIColor.themeSecondary
        self.btnRoomNumber.setTitleColor(UIColor.themeLightTextColor, for: .normal)
        self.btnRoomNumber.setRound()
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
        let cameraVC: CameraVC =  Common.appDelegate.loadCameraVC(navigaionVC: self.navigationController)
        cameraVC.onBtnCaptureTapped = { [weak self] (document)  in
                   guard let self = self else {
                       return
                   }
                self.popVC()
                Common.appDelegate.loadServiceStatusVC(navigaionVC: self.navigationController)
        }
    }
}



