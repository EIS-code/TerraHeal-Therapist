//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit

struct CreditCardDetail {
    var id: String  = ""
    var name: String  = ""
    var value: String = ""
    var isSeleced: Bool  = false
}


enum PaymentMethod: Int {
    case Paypal = 1
    case CreditCard = 2

    func name() -> String {
        switch self {
        case .Paypal:
            return "PAYMENT_METHOD_PAYPAL".localized()
        case .CreditCard:
            return "PAYMENT_METHOD_CREDIT_CARD".localized()
        default:
            return "UNKNOWN".localized()
        }
    }

    func getID() -> String {
        return self.rawValue.toString()
    }
    static func getSelectedMethod(id:String) -> PaymentMethod?{
        switch id.toInt {
        case 1:
            return PaymentMethod.Paypal
        case 2:
            return PaymentMethod.CreditCard
        default:
            return nil
        }
    }
}

class PaymentPreferenceVC: BaseVC {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnSubmit: FilledRoundedButton!
    @IBOutlet weak var vwPaypalDetail: UIView!
    @IBOutlet weak var ivPaypal: UIImageView!
    @IBOutlet weak var lblPaypal: ThemeLabel!
    @IBOutlet weak var lblPaypalEmailId: ThemeLabel!
    @IBOutlet weak var btnDefault: ThemeButton!
    @IBOutlet weak var btnExpandPaypal: UIButton!
    @IBOutlet weak var vwCreditCardDetail: UIView!
    @IBOutlet weak var ivCreditCard: UIImageView!
    @IBOutlet weak var lblCreditCard: ThemeLabel!
    @IBOutlet weak var lblCreditCardValue: ThemeLabel!
    @IBOutlet weak var btnExpandCreditCard: ThemeButton!
    @IBOutlet weak var hTblVw: NSLayoutConstraint!
    @IBOutlet weak var btnAddPayment: RoundedBorderButton!
    
    var amount:Double = 0.0
    var comeFromVC: BaseVC? = nil
    var arrForData: [CreditCardDetail] = [CreditCardDetail.init(id: "1", name: "personal", value: "254xxxxxxxxx324841", isSeleced: false),CreditCardDetail.init(id: "2", name: "business", value: "254xxxxxxxxx324841", isSeleced: true)]
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
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if self.isViewAvailable() {
            self.vwPaypalDetail?.setRound(withBorderColor: .clear, andCornerRadious: JDDeviceHelper.offseter(offset: 15), borderWidth: 1.0)
            self.vwCreditCardDetail?.setRound(withBorderColor: .clear, andCornerRadious: JDDeviceHelper.offseter(offset: 15), borderWidth: 1.0)
            self.btnDefault.setRound(withBorderColor: .clear, andCornerRadious: JDDeviceHelper.offseter(offset: 5), borderWidth: 1.0)
            self.reloadTableDataToFitHeight(tableView: self.tableView, height: self.hTblVw)
            
            
        }
    }
    
    private func initialViewSetup() {
        
        self.setupTableView(tableView: self.tableView)
        self.setNavigationTitle(title: "PAYMENT_PREFERENCE_TITLE".localized())
        self.lblPaypal.text = "PAYMENT_LBL_PAYPAL".localized()
        self.lblPaypal.setFont(name: FontName.Bold, size: FontSize.subHeader)
        self.lblPaypalEmailId.text = "PAYMENT_PAYPAL_EMAIL_ID".localized()
        self.lblPaypalEmailId.setFont(name: FontName.Regular, size: FontSize.detail)
        self.lblCreditCard.text = "PAYMENT_LBL_CARDS".localized()
        self.lblCreditCard.setFont(name: FontName.Bold, size: FontSize.subHeader)
        self.lblCreditCardValue.text = "XXXX-XXXX-XXXX-5555".localized()
        self.lblCreditCardValue.setFont(name: FontName.Regular, size: FontSize.detail)
        self.btnDefault?.setTitle("PAYMENT_LBL_DEFAULT".localized(), for: .normal)
        self.btnDefault?.setFont(name: FontName.Regular, size: FontSize.button_13)
        self.btnAddPayment?.setTitle("PAYMENT_BTN_ADD_NEW".localized(), for: .normal)
        self.setupTableView(tableView: self.tableView)
        self.btnAddPayment.addTarget(self, action: #selector(btnAddPaymentTapped(_:)), for: .touchUpInside)
        if comeFromVC == nil {
            self.btnSubmit?.setTitle("PAYMENT_BTN_ADD_NEW".localized(), for: .normal)
            self.btnAddPayment.isHidden = true
            self.btnSubmit.addTarget(self, action: #selector(btnAddPaymentTapped(_:)), for: .touchUpInside)
        } else {
            self.btnSubmit.setTitle("BTN_PAY".localized(with: [appSingleton.currencySymbol,amount.toString()]), for: .normal)
            self.btnAddPayment.isHidden = false
            self.btnSubmit.addTarget(self, action: #selector(btnSubmitTapped(_:)), for: .touchUpInside)
        }
    }
    
    
    @IBAction func onBtnExpandCreditCardDetailTapped(_ sender: Any) {
        if btnExpandCreditCard.isSelected {
            tableView.gone()
        } else {
            tableView.visible()
        }
        self.reloadTableDataToFitHeight(tableView: tableView, height: hTblVw)
        btnExpandCreditCard.isSelected.toggle()
    }
    
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        super.btnLeftTapped()
        self.popVC()
        //_ = (self.navigationController as? NC)?.popVC()
    }
    @IBAction func btnAddPaymentTapped(_ sender: Any) {
        self.openAddPaymentDialog()
    }
    
    @IBAction func btnSubmitTapped(_ sender: Any) {
        //btnSubmit.isEnabled = false
    }

    func openAddPaymentDialog() {
        let option1: SelectionBorderTableCellDetail = SelectionBorderTableCellDetail.init(id: PaymentMethod.Paypal.getID(), title: PaymentMethod.Paypal.name(),isSelected: true)
        let option2: SelectionBorderTableCellDetail = SelectionBorderTableCellDetail.init(id: PaymentMethod.CreditCard.getID(), title: PaymentMethod.CreditCard.name(),isSelected: false)
        let arrForData: [SelectionBorderTableCellDetail] = [option1,option2]
        let addNewDialog: CustomTblSelectionDialog = CustomTblSelectionDialog.fromNib()
        addNewDialog.initialize(title: "DIALOG_ADD_NEW_PAYMENT_TITLE".localized(), buttonTitle: "DIALOG_ADD_NEW_PAYMENT_BTN_PROCEED".localized(), cancelButtonTitle: "BTN_BACK".localized())
        addNewDialog.setDataSource(dataList: arrForData)
        addNewDialog.show(animated: true)
        addNewDialog.onBtnCancelTapped = {
            [weak addNewDialog, weak self] in
            guard let self = self else {return}; print(self)
            addNewDialog?.dismiss();
        }
        addNewDialog.onBtnDoneTapped = {
            [weak addNewDialog, weak self] (selectionData) in
            guard let self = self else {return}; print(self)
            addNewDialog?.dismiss();
            if let paymentMethod = PaymentMethod.getSelectedMethod(id: selectionData.id), paymentMethod == .Paypal {
                self.openTextFieldPicker()
            } else {
                Common.appDelegate.loadAddCardVC(navigaionVC: self.navigationController)
            }

        }
    }
    
    func openTextFieldPicker() {
        let alert: CustomTextFieldDialog = CustomTextFieldDialog.fromNib()
        alert.initialize(title: "paypal email", data: "", buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_BACK".localized())
        alert.show(animated: true)
        alert.configTextField(data: InputTextFieldDetail.getEmailConfiguration())
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            guard let self = self else { return } ; print(self)
            alert?.dismiss()
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self] (description) in
            guard let self = self else { return } ; print(self)
            alert?.dismiss()
            self.lblPaypalEmailId.text = description
        }
    }
    
}


extension PaymentPreferenceVC: UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate {
    
    private func reloadTableDataToFitHeight(tableView: UITableView, height:NSLayoutConstraint) {
        if tableView.isHidden == false {
            DispatchQueue.main.async {
                tableView.reloadData(heightToFit:height) {
                }
            }
        } else {
            height.constant = 0
        }
    }
    
    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.register(CreditCardTblCell.nib()
            , forCellReuseIdentifier: CreditCardTblCell.name)
        tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrForData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CreditCardTblCell.name, for: indexPath) as?  CreditCardTblCell
        cell?.layoutIfNeeded()
        cell?.setData(data: arrForData[indexPath.row])
        cell?.layoutIfNeeded()
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //self.openNewAddressDialog(index: indexPath.row)
    }
    
}

