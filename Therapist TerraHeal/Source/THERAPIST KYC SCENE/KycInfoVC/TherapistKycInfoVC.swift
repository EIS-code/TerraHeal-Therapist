//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit



class TherapistKycInfoVC: MainVC {



    @IBOutlet weak var btnNext: ThemeButton!
    @IBOutlet weak var btnDone: ThemeButton!
    @IBOutlet weak var lblHeader: ThemeLabel!
    @IBOutlet weak var lblMessage: ThemeLabel!
    @IBOutlet weak var tblDocuments: UITableView!

    var arrForSteps:[DocumentDetail] = []

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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.arrForSteps =
        [
            DocumentDetail(id: "1", name: "Account Created", isCompleted: true),
            DocumentDetail(id: "2", name: "Contact Verification", isCompleted: appSingleton.user.isContactVerified()),
            DocumentDetail(id: "3", name: "Identity Verification", isCompleted: appSingleton.user.isDocumentVerified.toBool),
            DocumentDetail(id: "4", name: "Payment Details", isCompleted: false),
            DocumentDetail(id: "5", name: "Profile Details", isCompleted: false),
            DocumentDetail(id: "6", name: "Last Step", isCompleted: false)
        ]
        self.tblDocuments.reloadData()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.btnDone?.setUpRoundedButton()
    }

    private func initialViewSetup() {
        self.vwBar?.backgroundColor = UIColor.clear

        self.lblHeader?.text = "KYC_INFO_LBL_TITLE".localized()
        self.lblHeader?.setFont(name: FontName.GradDuke, size: FontSize.label_26)
        self.lblMessage?.text = "KYC_INFO_LBL_MESSAGE".localized()
        self.lblMessage?.setFont(name: FontName.Ovo, size: FontSize.label_18)
        self.btnNext?.setTitle("KYC_INFO_BTN_HOME".localized(), for: .normal)
        self.btnNext?.setFont(name: FontName.GradDuke, size: FontSize.button_22)
        self.setupTableView()
    }

    func setupTableView() {
        tblDocuments.delegate = self
        tblDocuments.dataSource = self

        tblDocuments.rowHeight = UITableView.automaticDimension
        tblDocuments.estimatedRowHeight = UITableView.automaticDimension
        tblDocuments.register(KycInfoTblCell.nib()
            , forCellReuseIdentifier: KycInfoTblCell.name)
        tblDocuments.tableFooterView = UIView()
    }

    // MARK: - Action Methods
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnNextTapped(_ sender: Any) {
       Common.appDelegate.loadHomeVC()
    }

}


extension TherapistKycInfoVC:  UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrForSteps.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: KycInfoTblCell.name) as? KycInfoTblCell
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: KycInfoTblCell.name) as? KycInfoTblCell
        }
        cell?.setData(data: arrForSteps[indexPath.row])
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        switch indexPath.row {
        case 0:
            Common.appDelegate.loadIdentityVerificationInstructionVC(navigaionVC: self.navigationController)
        case 1:
            Common.appDelegate.loadContactVerificationVC(navigaionVC: self.navigationController)
        case 2:
            Common.appDelegate.loadIdentityVerificationInstructionVC(navigaionVC: self.navigationController)
        case 3:
            Common.appDelegate.loadPaymentAccountVC(navigaionVC: self.navigationController)
        case 4:
            Common.appDelegate.loadTherapistProfileVC(navigaionVC: self.navigationController)
        default:
            print("Default")
        }
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
