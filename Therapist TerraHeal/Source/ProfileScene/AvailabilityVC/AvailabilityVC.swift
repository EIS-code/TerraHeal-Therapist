//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit

enum AvailabilityStatus: Int {
    case Available = 1
    case NotAvailable = 2
}

enum AvailabilityOptions: Int {
    case FreeSpot = 1
    case Absent = 2
    case ExchangeWithOthers = 3

    func name() -> String {
        switch self {
        case .FreeSpot:
            return "AVAILABILITY_OPTION_FREE_SPOT".localized()
        case .Absent:
            return "AVAILABILITY_OPTION_ABSENT".localized()
        case .ExchangeWithOthers:
            return "AVAILABILITY_OPTION_EXCHANGE".localized()
        /*default:
            return "UNKNOWN".localized()*/
        }
    }

    func getID() -> String {
           return self.rawValue.toString()
    }

    static func getAvailabilityOption(id:String) -> AvailabilityOptions {
        switch id.toInt {
        case 1:
            return .FreeSpot
        case 2:
            return .Absent
        case 3:
            return .ExchangeWithOthers
        default:
            return .FreeSpot
        }
    }




}
class AvailabilityVC: BaseVC {

    @IBOutlet weak var vwCalendar: FSCalendar!
    @IBOutlet weak var btnPreviousMonth: ThemeButton!
    @IBOutlet weak var btnNextMonth: ThemeButton!
    @IBOutlet weak var btnSelectWeek: ThemeButton!
    @IBOutlet weak var lblMonthYear: ThemeLabel!
    @IBOutlet weak var btnProceed: FilledRoundedButton!
    @IBOutlet weak var lblAvailableTime: ThemeLabel!
    @IBOutlet weak var btnSelectMore: RoundedBorderButton!
    @IBOutlet weak var tblForAvailability: UITableView!

    var arrForAvailability:[Any] = []
    var arrForData:[ShiftCellDetail] = [
      
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
        self.wsAvailability()

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

        }
    }
    
    private func initialViewSetup() {

        self.setBackground(color: UIColor.themeLightBackground)
        self.setNavigationTitle(title: "MY_AVAILABILITY_TITLE".localized())
        self.btnPreviousMonth.setText(FontSymbol.back_arrow, for: .normal)
        self.btnPreviousMonth.setFont(name: FontName.SemiBold, size: FontSize.button_22)
        self.btnNextMonth.setText(FontSymbol.next_arrow, for: .normal)
        self.btnNextMonth.setFont(name: FontName.SemiBold, size: FontSize.button_22)
        self.btnSelectWeek.setText("MY_AVAILABILITY_BTN_WEEK".localized())
        self.btnSelectWeek.setFont(name: FontName.Regular, size: FontSize.button_14)
        self.lblMonthYear.setFont(name: FontName.Regular, size: FontSize.subHeader)
        self.lblMonthYear.setText(Date().toString(format: "MMM yyyy"))
        self.btnProceed.setText("MY_AVAILABILITY_BTN_SUBMIT".localized())
        self.lblAvailableTime.setText("MY_AVAILABILITY_SECTION_HEADER".localized())
        self.lblAvailableTime.setFont(name: FontName.SemiBold, size: FontSize.header)
        self.btnSelectMore.setText("MY_AVAILABILITY_BTN_SELECT_MORE".localized())
        self.setupCalendarView(calendar: self.vwCalendar)
        self.setupAvailabilityView(tableView: self.tblForAvailability)
    }

    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        super.btnLeftTapped()
        self.popVC()
    }

    @IBAction func btnSelectWeekTapped(_ sender: Any) {
        let currentPage = self.vwCalendar.currentPage.nextWeek()
        self.vwCalendar.setCurrentPage(currentPage, animated: true)
    }

    @IBAction func btnPreviousTapped(_ sender: Any) {
        let currentPage = self.vwCalendar.currentPage.previousMonth()
        self.vwCalendar.setCurrentPage(currentPage, animated: true)
    }

    @IBAction func btnNextTapped(_ sender: Any) {
        let currentPage = self.vwCalendar.currentPage.nextMonth()
        self.vwCalendar.setCurrentPage(currentPage, animated: true)
    }
    @IBAction func btnSelectMoreTapped(_ sender: Any) {
        self.openSelectOptionForAvailability()
    }

}

//MARK:- Dialogs
extension AvailabilityVC {

    func openTextViewPicker() {
        let alert: CustomTextViewDialog = CustomTextViewDialog.fromNib()
        alert.initialize(title: "DIALOG_AVAILABILITY_ABSENT_TITLE".localized()
            , data: "", buttonTitle: "DIALOG_AVAILABILITY_ABSENT_BTN_PROCEED".localized(), cancelButtonTitle: "BTN_BACK".localized())
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            guard let self = self else {return}; print(self)
            alert?.dismiss()
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self] (description) in
            guard let self = self else { return } ; print(self)
            alert?.dismiss()
            let request: AbsentDayWebService.RequestToAbsent = AbsentDayWebService.RequestToAbsent.init(date: (self.vwCalendar.selectedDate ?? Date()).millisecondsSince1970.toString(), absent_reason: description)
            self.wsAbsentRequest(request: request)
        }
    }
    func openFreeSpotDialog() {
        let alert: FreeSpotDialog = FreeSpotDialog.fromNib()
        alert.initialize(title: "DIALOG_FREE_SPOT_TITLE".localized()
            , buttonTitle: "DIALOG_FREE_SPOT_BTN_PROCEED".localized(), cancelButtonTitle: "BTN_BACK".localized())
        alert.wsGetFreeSlots()
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            guard let self = self else {return}; print(self)
            alert?.dismiss()
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self] () in
            guard let self = self else { return } ; print(self)
            alert?.dismiss()

        }
    }

    func openExchangeOfferDialog() {
        //Common.appDelegate.loadExchangeOfferVC(navigaionVC: self.navigationController)
        /*let alert: ExchangeOfferDialog = ExchangeOfferDialog.fromNib()
        alert.initialize(title: AvailabilityOptions.ExchangeWithOthers.name(), buttonTitle: "DIALOG_EXCHANGE_OFFER_BTN_PROCEED".localized(), cancelButtonTitle: "BTN_BACK".localized())
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            guard let self = self else {return}; print(self)
            alert?.dismiss()
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self] () in
            guard let self = self else { return } ; print(self)
            alert?.dismiss()
        }*/
        
    }

    func openSelectOptionForAvailability() {
        self.btnSelectMore.isEnabled = false
        let option1: SelectionBorderTableCellDetail = SelectionBorderTableCellDetail.init(id: AvailabilityOptions.FreeSpot.rawValue.toString(), title: AvailabilityOptions.FreeSpot.name())
        let option2: SelectionBorderTableCellDetail = SelectionBorderTableCellDetail.init(id: AvailabilityOptions.Absent.rawValue.toString(), title: AvailabilityOptions.Absent.name())
        let option3: SelectionBorderTableCellDetail = SelectionBorderTableCellDetail.init(id: AvailabilityOptions.ExchangeWithOthers.rawValue.toString(), title: AvailabilityOptions.ExchangeWithOthers.name())
        let arrForData: [SelectionBorderTableCellDetail] = [option1,option2,option3]
        let addNewDialog: CustomTblSelectionDialog = CustomTblSelectionDialog.fromNib()
        addNewDialog.initialize(title: "DIALOG_AVAILABILITY_OPTION_TITLE".localized(), buttonTitle: "DIALOG_AVAILABILITY_BTN_PROCEED".localized(), cancelButtonTitle: "BTN_BACK".localized())
        addNewDialog.setDataSource(dataList: arrForData)
        addNewDialog.show(animated: true)
        addNewDialog.onBtnCancelTapped = {
            [weak addNewDialog, weak self] in
            guard let self = self else {return}; print(self)
            addNewDialog?.dismiss();
            self.btnSelectMore.isEnabled = true
        }
        addNewDialog.onBtnDoneTapped = {
            [weak addNewDialog, weak self] (selectionData) in
            guard let self = self else {return}; print(self)
            addNewDialog?.dismiss();
            switch AvailabilityOptions.getAvailabilityOption(id: selectionData.id) {
            case .FreeSpot:
                self.openFreeSpotDialog()
            case .Absent:
                self.openTextViewPicker()
            default:
                self.openExchangeOfferDialog()
            }
            self.btnSelectMore.isEnabled = true
        }
    }
}


extension AvailabilityVC {
    func wsAbsentRequest(request:AbsentDayWebService.RequestToAbsent) {
        Loader.showLoading()
        AbsentDayWebService.requestToAbsent(params: request) { (response) in
            Loader.hideLoading()
            if ResponseModel.isSuccess(response: response) {
                self.popVC()
            }
        }

    }
    func wsAvailability() {
        Loader.showLoading()
        AvailabilityWebService.getAvailabilities(params: AvailabilityWebService.RequestGetAvailability.init()) { (response) in
            Loader.hideLoading()
            if ResponseModel.isSuccess(response: response) {
                for data in response.availabilityData.shifts {
                    self.arrForData.append(ShiftCellDetail.init(shift: data))
                }
            }
            self.tblForAvailability.reloadData()

        }


    }
}
