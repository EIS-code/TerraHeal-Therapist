//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit


class ExchangeOfferVC: BaseVC {

    @IBOutlet weak var vwCalendar: FSCalendar!
    @IBOutlet weak var btnPreviousMonth: ThemeButton!
    @IBOutlet weak var btnNextMonth: ThemeButton!
    @IBOutlet weak var lblMonthYear: ThemeLabel!
    @IBOutlet weak var searchVw: UIView!
    @IBOutlet weak var txtSearchBar: ThemeTextField!
    @IBOutlet weak var tblForAvailability: UITableView!
    @IBOutlet weak var btnProceed: ThemeButton!
    var arrForAvailability:[Any] = []
    var arrForData:[AvailabilityCellDetail] = [
        AvailabilityCellDetail.init(shiftName: "shift - 1", shiftTime: "10 - 12", availabilityStatus: .Available, isSelected: false),
        AvailabilityCellDetail.init(shiftName: "shift - 2", shiftTime: "12 - 14", availabilityStatus: .Available, isSelected: false),
        AvailabilityCellDetail.init(shiftName: "shift - 3", shiftTime: "12 - 16", availabilityStatus: .Available, isSelected: false),
        AvailabilityCellDetail.init(shiftName: "shift - 4", shiftTime: "16 - 18", availabilityStatus: .Available, isSelected: false),
        AvailabilityCellDetail.init(shiftName: "shift - 5", shiftTime: "16 - 20", availabilityStatus: .Available, isSelected: false),
        AvailabilityCellDetail.init(shiftName: "shift - 6", shiftTime: "20 - 24", availabilityStatus: .Available, isSelected: false),
        AvailabilityCellDetail.init(shiftName: "shift - 7", shiftTime: "00 - 08", availabilityStatus: .Available, isSelected: false),
        AvailabilityCellDetail.init(shiftName: "shift - 8", shiftTime: "08 - 04", availabilityStatus: .Available, isSelected: false),
    ]

    let date = Date().startOfDay
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
            self.searchVw.setRound(withBorderColor: .themeDarkText, andCornerRadious: self.searchVw.bounds.height/2.0, borderWidth: 1.0)
            self.tblForAvailability.reloadData()
        }
    }
    
    private func initialViewSetup() {
        self.setBackground(color: UIColor.themeLightBackground)
        self.setNavigationTitle(title: "EXCHANGE_OFFER_TITLE".localized())
        self.btnProceed.setText("EXCHANGE_OFFER_BTN_SUBMIT".localized())
        self.setupSearchbar(searchBar: txtSearchBar)
        self.setupAvailabilityView(tableView: self.tblForAvailability)
        DispatchQueue.main.async {
            self.tblForAvailability.reloadData()
        }
    }

    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        super.btnLeftTapped()
        self.popVC()
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
        ExchangeWithOtherWebService.requestToExchangeOffer(params: ExchangeWithOtherWebService.RequestToExchangeOffer.init()) { (response) in
            Loader.hideLoading()
            if ResponseModel.isSuccess(response: response) {
            }
        }
    }


}
