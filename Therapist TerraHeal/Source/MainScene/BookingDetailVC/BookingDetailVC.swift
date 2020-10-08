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
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tblHeader: UIView!
    @IBOutlet weak var lblBookingId: ThemeLabel!
    @IBOutlet weak var btnNumber: UIButton!
    @IBOutlet weak var vwForBookingId: UIView!
    @IBOutlet weak var btnStart: FilledRoundedButton!
    @IBOutlet weak var btnCancel: RoundedBorderButton!

    var arrForData: [BookingDetail] = [
        BookingDetail.init(title: "client name", detail: "sauravsingh"),
        BookingDetail.init(title: "type of service", detail: "thai yoga massage\t90 min"),
        BookingDetail.init(title: "session type", detail: "single"),
        BookingDetail.init(title: "date & time", detail: "28 oct 2020\n13:00 - 14:30"),
        BookingDetail.init(title: "pressure preference", detail: "male only"),
        BookingDetail.init(title: "service details", detail: "medium pressure"),
        BookingDetail.init(title: "notes", detail: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam"),
        BookingDetail.init(title: "injuries", detail: "Lorem ipsum dolor"),
        BookingDetail.init(title: "focus area", detail: "head")
    ]
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if self.isViewAvailable() {
            self.tableView?.reloadData({
            })
            self.tableView?.contentInset = self.getGradientInset()
        }
    }
    
    private func initialViewSetup() {
        self.setBackground(color: UIColor.themeWhite)
        self.setupTableView(tableView: self.tableView)
        self.setNavigationTitle(title:"BOOKING_DETAILS_TITLE".localized())
        self.vwNavigationBar.backgroundColor = .white
        self.lblBookingId.setText("062488475")
        self.lblBookingId.setFont(name: FontName.SemiBold, size: FontSize.subHeader)
        self.btnNumber.setText("01")
        self.btnNumber.backgroundColor = UIColor.themeSecondary
        self.btnNumber.setTitleColor(UIColor.themeLightTextColor, for: .normal)
        self.updateUI()
        self.btnNumber.setRound()
        self.btnStart.setText("BOOKING_DETAILS_BTN_START".localized())
        self.btnCancel.setText("BOOKING_DETAILS_BTN_CANCEL".localized())
    }
    
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        super.btnLeftTapped()
        if arrForData.isEmpty {
                _ = (self.navigationController as? NC)?.popVC()
        } else {
            self.arrForData.removeAll()
            self.updateUI()
        }
        
    }
    
    func updateUI()  {
        if arrForData.isEmpty {
            self.tableView.isHidden = true
        } else {
            self.tableView.isHidden = false
        }
        self.tableView.reloadData()
    }

    @IBAction func btnStartTapped(_ sender: Any) {
        btnStart.isEnabled = false
        self.openScanDialog()
    }

    @IBAction func btnCancelTapped(_ sender: Any) {

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


            Common.appDelegate.loadServiceStatusVC(navigaionVC: self.navigationController)
        }
        scanDialog.onBtnCancelTapped = { [weak scanDialog, weak self]  in
            guard let self = self else {
                return
            }
            scanDialog?.dismiss()
            self.btnStart.isEnabled = true
        }
    }



}


extension BookingDetailVC: UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate {
    
    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .themeBackground
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(BookingDetailTblCell.nib()
            , forCellReuseIdentifier: BookingDetailTblCell.name)
        tableView.reloadData()
        let path = UIBezierPath(roundedRect: UIScreen.main.bounds, byRoundingCorners:[.topLeft,.topRight], cornerRadii: CGSize(width: 40.0, height: 40.0))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.vwForBookingId.layer.mask = mask
        tableView.tableHeaderView = tblHeader
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrForData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: BookingDetailTblCell.name, for: indexPath) as?  BookingDetailTblCell
        cell?.layoutIfNeeded()
        cell?.setData(data: arrForData[indexPath.row])
        cell?.layoutIfNeeded()
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

