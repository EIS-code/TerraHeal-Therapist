//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit


class ExchangeOfferVC: BaseVC {

    @IBOutlet weak var searchVw: UIView!
    @IBOutlet weak var txtSearchBar: ThemeTextField!
    @IBOutlet weak var tblVwForData: UITableView!
    @IBOutlet weak var btnProceed: ThemeButton!
    var arrForData:[ShiftContainerCellDetail] = []
    var selectedShiftForExchange: RequestExchangeShift!
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
        self.wsGetTherapistShiftList()
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
            self.searchVw.setRound(withBorderColor: .themeDarkText, andCornerRadious: self.searchVw.bounds.height/2.0, borderWidth: 1.0)
            self.tblVwForData.reloadData()
        }
    }
    
    private func initialViewSetup() {
        self.setBackground(color: UIColor.themeLightBackground)
        self.setNavigationTitle(title: "EXCHANGE_OFFER_TITLE".localized())
        self.btnProceed.setText("EXCHANGE_OFFER_BTN_SUBMIT".localized())
        self.setupSearchbar(searchBar: txtSearchBar)
        self.setupTableView(tableView: self.tblVwForData)
        DispatchQueue.main.async {
            self.tblVwForData.reloadData()
        }
    }

    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        super.btnLeftTapped()
        self.popVC()
    }

    @IBAction func btnSubmitTapped(_ sender: Any) {

        if selectedShiftForExchange.with_shift_id == nil {
            self.confirmationDialog()
           // Common.showAlert(message: "WORKING_SCHEDULE_PLEASE_SELECT_SHIFT".localized())
        } else {
            self.wsExchangeWithOther()
        }
    }

    func confirmationDialog() {
        let message = "your exchange request with \(self.selectedShiftForExchange!.shop_id) is processing, Please wait for the approval"
            let alert: CustomInformationDialog = CustomInformationDialog.fromNib()
            alert.initialize(title: "Exchange Shift!".localized(), data:message, buttonTitle: "BTN_DONE".localized(), cancelButtonTitle: "BTN_CANCEL".localized())
            alert.show(animated: true)
            alert.onBtnCancelTapped = {
                [weak alert, weak self] in
                guard let self = self else {return} ; print(self)
                alert?.dismiss()
            }
            alert.onBtnDoneTapped = {
                [weak alert, weak self]  in
                guard let self = self else {return} ; print(self)
                alert?.dismiss()
            }
    }

}

extension ExchangeOfferVC : UITextFieldDelegate {

    private func setupSearchbar(searchBar: UITextField) {
        self.txtSearchBar.delegate = self
        self.txtSearchBar.setFont(name: FontName.Regular, size: FontSize.textField_regular)
        self.txtSearchBar.addTarget(self, action: #selector(searching(_:)), for: .editingChanged)
        self.txtSearchBar.textColor = UIColor.themeDarkText
        self.txtSearchBar.changePlaceHolder(color: UIColor.themeDarkText)
        self.txtSearchBar.placeholder = "TXT_SEARCH_FOR_NAME".localized()
    }

    func searchData(for text: String) {
        //self.wsGetTherapist()
    }

    @IBAction func searching(_ sender: UITextField) {
        searchData(for: sender.text ?? "")
    }
    func wsGetTherapist() {
        Loader.showLoading()
        ExchangeWithOtherWebService.requestToGetTherapistList(params: ExchangeWithOtherWebService.RequestToTherapistList.init(name: txtSearchBar.text!)) { (response) in
            Loader.hideLoading()
            if ResponseModel.isSuccess(response: response) {

            }
        }
    }

    func wsExchangeWithOther() {
        Loader.showLoading()
        let request: ExchangeWithOtherWebService.RequestToExchangeOffer = ExchangeWithOtherWebService.RequestToExchangeOffer.init(from: self.selectedShiftForExchange)
        ExchangeWithOtherWebService.requestToExchangeOffer(params: request) { (response) in
            Loader.hideLoading()
            if ResponseModel.isSuccess(response: response) {
            }
        }
    }

    func wsGetTherapistShiftList() {
        Loader.showLoading()
        self.arrForData.removeAll()
        let request = ExchangeWithOtherWebService.RequestAllTherapistShift.init(date: self.selectedShiftForExchange.date ?? "", shop_id: self.selectedShiftForExchange.shop_id ?? "")
        ExchangeWithOtherWebService.requestToGetTherapistShiftList(params: request) { response in
            Loader.hideLoading()
            if ResponseModel.isSuccess(response: response) {
                for data in response.data {
                    self.arrForData.append(ShiftContainerCellDetail.init(data: data))
                }
            }
            self.tblVwForData.reloadData()
        }
    }
}
