import UIKit
//import FSCalendar

enum SubFilterType: Int {
    case Date = 0
    case ClientName = 1
    case Massages = 2
    case Therapies = 3
    case BookingType = 4
    case SessionType = 5
}

class CustomFilterDialog: ThemeBottomDialogView {

    var onBtnDoneTapped: ((_ filterType:SubFilterType, _ value:Any) -> Void)? = nil
    var onBtnClearAllTapped: (() -> Void)? = nil
    @IBOutlet var filterTypeButton: [SelectionButton]!
    @IBOutlet weak var activeView: UIView!
    @IBOutlet weak var dateView: UIView!

    //DateDialog
    @IBOutlet weak var vwCalendar: FSCalendar!
    @IBOutlet weak var btnPreviousMonth: ThemeButton!
    @IBOutlet weak var btnNextMonth: ThemeButton!
    @IBOutlet weak var lblMonthYear: ThemeLabel!
    var selectedMilli:Double = 0
    var minDate = Date()
    var maxDate = Date()
    var selectedValue: Any? = nil


    //ClientDialog
    @IBOutlet weak var vwClientSearch: UIView!
    @IBOutlet weak var vwClientSearchBar: UIView!
    @IBOutlet weak var txtClientSearch: ThemeTextField!
    @IBOutlet weak var tblForClient: UITableView!
    //ServiceDialog
    @IBOutlet weak var vwServiceSearch: UIView!
    @IBOutlet weak var vwServiceSearchBar: UIView!
    @IBOutlet weak var txtServiceSearch: ThemeTextField!
    @IBOutlet weak var vwServiceSelection: JDSegmentedControl!
    @IBOutlet weak var tblForServices: UITableView!
    var selectedServiceType: ServiceType = ServiceType.Massages
    //SessionDialog
    @IBOutlet weak var vwSession: UIView!
    @IBOutlet weak var tblForSessionType: UITableView!
    var arrForData: [SessionTypeDetails] = []
    var arrForClientData: [Client] = []
    var arrForMassageData: [Massage] = appSingleton.user.selectedServices.massages
    var arrForTherapyData: [Therapy] = appSingleton.user.selectedServices.therapies
    //BookingTypeView
    @IBOutlet weak var vwBookingType: UIView!
    @IBOutlet weak var lblCenter: ThemeLabel!
    @IBOutlet weak var lblHome: ThemeLabel!
    @IBOutlet weak var btnHome: JDRadioButton!
    @IBOutlet weak var btnCenter: JDRadioButton!

    var selectedTab: SubFilterType = SubFilterType.Date
    //var selectedFilterValues: BookingWebSerive.RequestBookingList = BookingWebSerive.RequestBookingList.init()
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initialSetup()
        self.setupClientSearchView()
        self.setupServiceSearchView()
        self.setupSession()
        self.setupDateView()
        self.setupBookingTypeView()
        self.wsGetSessionList()
    }

    override func initialSetup() {
        super.initialSetup()
        self.setDataForStepUpAnimation()
        self.lblTitle.setFont(name: FontName.Bold, size: FontSize.header)

        for button in filterTypeButton {
            var buttonTitle:String = ""
            switch button.tag {
            case 0:
                buttonTitle = "FILTER_BTN_DATE".localized()
                self.filterButtonTapped(button)
            case 1:
                button.deselect()
                buttonTitle = "FILTER_BTN_CLIENT_NAME".localized()
            case 2:
                button.deselect()
                buttonTitle = "FILTER_BTN_SERVICES".localized()
            case 3:
                button.deselect()
                buttonTitle = "FILTER_BTN_BOOKING_TYPE".localized()
            case 4:
                button.deselect()
                buttonTitle = "FILTER_BTN_SESSION_TYPE".localized()
            default:
                buttonTitle = ""
            }

            button.setText(buttonTitle)
        }


    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.vwClientSearchBar.setRound(withBorderColor: .clear, andCornerRadious:
            self.vwClientSearchBar.bounds.height/2.0, borderWidth: 1.0)
        self.vwServiceSearchBar.setRound(withBorderColor: .clear, andCornerRadious: self.vwServiceSearchBar.bounds.height/2.0, borderWidth: 1.0)

    }

    @IBAction func filterButtonTapped(_ sender: SelectionButton) {
        for button in filterTypeButton {
            if button.tag == sender.tag {
                button.select(withAnimation: true)
            } else {
                button.deselect()
            }
        }
        switch sender.tag {
        case 0:
            self.handleDateView()
        case 1:
            self.handleClientView()
        case 2:
            self.handleServiceView()
        case 3:
            self.handleBookingTypeView()
        case 4:
            self.handleSessionTypeView()
        default:
            print("")
        }
    }

    @IBAction func btnDoneTapped(_ sender: Any) {
        if selectedTab == .ClientName {
            self.selectedValue = txtClientSearch.text!
        }
        if self.selectedValue != nil {
            if self.onBtnDoneTapped != nil {
                self.onBtnDoneTapped!(self.selectedTab,self.selectedValue!)
            }
        } else {
            Common.showAlert(message: "Please Select Value")
        }
    }

    @IBAction func btnClearAllTapped(_ sender: Any) {
        self.selectedValue = nil
        if self.onBtnClearAllTapped != nil {
            self.onBtnClearAllTapped!()
        }

    }

    @IBAction func btnPreviousTapped(_ sender: Any) {
        let currentPage = self.vwCalendar.currentPage.previousMonth()
        self.vwCalendar.setCurrentPage(currentPage, animated: true)
    }
    @IBAction func btnNextTapped(_ sender: Any) {
        let currentPage = self.vwCalendar.currentPage.nextMonth()
        self.vwCalendar.setCurrentPage(currentPage, animated: true)
    }

    func handleDateView() {
        self.selectedTab = .Date
        self.vwSession.gone()
        self.vwServiceSearch.gone()
        self.vwClientSearch.gone()
        self.vwBookingType.gone()
        self.dateView.visible()
    }

    func handleServiceView() {
        self.selectedTab = .Massages
        self.vwSession.gone()
        self.vwClientSearch.gone()
        self.dateView.gone()
        self.vwBookingType.gone()
        self.vwServiceSearch.visible()
    }

    func handleClientView() {
        self.selectedTab = .ClientName
        self.vwSession.gone()
        self.vwServiceSearch.gone()
        self.dateView.gone()
        self.vwBookingType.gone()
        self.vwClientSearch.visible()
        self.wsGetClientList()
    }

    func handleBookingTypeView() {
        self.selectedTab = .BookingType
        self.vwSession.gone()
        self.vwServiceSearch.gone()
        self.dateView.gone()
        self.vwClientSearch.gone()
        self.vwBookingType.visible()
    }

    func handleSessionTypeView() {
        self.selectedTab = .SessionType
        self.vwServiceSearch.gone()
        self.dateView.gone()
        self.vwClientSearch.gone()
        self.vwBookingType.gone()
        self.vwSession.visible()
        self.tblForSessionType.reloadData()
    }
    @IBAction func btnHomeTapped(_ sender: Any) {
        btnHome.isSelected = true
        btnCenter.isSelected = false
        self.selectedValue = BookingType.AtHotelOrRoom.getParameterId()
    }
    @IBAction func btnCenterTapped(_ sender: Any) {
        btnHome.isSelected = false
        btnCenter.isSelected = true
        self.selectedValue = BookingType.MassageCenter.getParameterId()
    }
}

//Search Client Setup
extension CustomFilterDialog: UITextFieldDelegate {
    func searchData(for text: String) {
        if text.isEmpty {

        } else {

        }
    }
    func setupClientSearchView() {
        self.vwClientSearch.frame = self.activeView.bounds
        self.activeView.addSubview(vwClientSearch)
        self.txtClientSearch.delegate = self
        self.txtClientSearch.setFont(name: FontName.Regular, size: FontSize.textField_14)
        self.txtClientSearch.addTarget(self, action: #selector(searching(_:)), for: .editingChanged)
        self.txtClientSearch.textColor = UIColor.themeDarkText
        self.txtClientSearch.changePlaceHolder(color: UIColor.themeDarkText)
        self.txtClientSearch.placeholder = "FILTER_DIALOG_TXT_SEARCH_CLIENT".localized()
        self.vwClientSearchBar.setRound(withBorderColor: .clear, andCornerRadious: self.vwClientSearchBar.bounds.height/2.0, borderWidth: 1.0)
        self.setupTableView(tableView: self.tblForClient)
    }

    @IBAction func searching(_ sender: UITextField) {
        searchData(for: sender.text ?? "")
    }

}

//Search Service Setup
extension CustomFilterDialog {
    func searchServiceData(for text: String) {
        if text.isEmpty {

        } else {

        }
    }
    func setupServiceSearchView() {
        self.vwServiceSearch.frame = self.activeView.bounds
        self.activeView.addSubview(vwServiceSearch)
        self.txtServiceSearch.delegate = self
        self.txtServiceSearch.setFont(name: FontName.Regular, size: FontSize.textField_14)
        self.txtServiceSearch.addTarget(self, action: #selector(searchingService(_:)), for: .editingChanged)
        self.txtServiceSearch.textColor = UIColor.themeDarkText
        self.txtServiceSearch.changePlaceHolder(color: UIColor.themeDarkText)
        self.txtServiceSearch.placeholder = "FILTER_DIALOG_TXT_SEARCH_SERVICE".localized()
        self.vwServiceSearchBar.setRound(withBorderColor: .clear, andCornerRadious: self.vwServiceSearchBar.bounds.height/2.0, borderWidth: 1.0)
        self.setupSwitch()
        self.setupTableView(tableView: self.tblForServices)
    }

    private func setupSwitch() {
        self.vwServiceSelection.allowChangeThumbWidth = false
        self.vwServiceSelection.thumbColor = UIColor.themePrimary
        self.vwServiceSelection.itemTitles = ["massages".localized(),"therapies".localized()]
        self.vwServiceSelection.changeBackgroundColor(UIColor.themeLightTextColor)
        self.vwServiceSelection.didSelectItemWith = { [weak self] (index,title) in
            guard let self = self else {
                return
            }
            if index == 0 {
                self.massagesTapped()
            } else {
                self.therapiesTapped()
            }
        }
    }

    func massagesTapped(){
        self.vwServiceSelection.selectItemAt(index: 0)
        self.selectedServiceType = ServiceType.Therapies
        self.selectedValue = "Massages"
        self.tblForServices.reloadData()
    }

    func therapiesTapped(){
        self.vwServiceSelection.selectItemAt(index: 1)
        self.selectedServiceType = ServiceType.Therapies
        self.selectedValue = "Therapy"
        self.tblForServices.reloadData()
    }

    @IBAction func searchingService(_ sender: UITextField) {
        searchServiceData(for: sender.text ?? "")
    }

}
//MARK: Booking Type Setup

extension CustomFilterDialog {

    func setupBookingTypeView() {
        self.vwBookingType.frame = self.activeView.bounds
        self.activeView.addSubview(vwBookingType)
        self.lblHome.setText("FILTER_DIALOG_HOME".localized())
        self.lblHome.setFont(name: FontName.SemiBold, size: FontSize.subHeader)
        self.lblCenter.setText("FILTER_DIALOG_CENTER".localized())
        self.lblCenter.setFont(name: FontName.SemiBold, size: FontSize.subHeader)
        self.btnHome.isSelected = false
        self.btnCenter.isSelected = false
    }
}

//MARK: Web Service Calls

extension CustomFilterDialog {

    func wsGetSessionList() {
        Loader.showLoading()
        SessionWebService.getAllSessionTypes { (response) in
            Loader.hideLoading()
            if ResponseModel.isSuccess(response: response) {
                self.arrForData = response.groupBySession
            }
            self.tblForSessionType.reloadData()
        }
    }

    func wsGetClientList() {
        Loader.showLoading()
        ClientWebService.getAllClients(params: ClientWebService.RequestClientList.init(search_val: txtClientSearch.text!), completionHandler: { (response) in
            Loader.hideLoading()
            if ResponseModel.isSuccess(response: response) {
                self.arrForClientData = response.clientList
            }
            self.tblForClient.reloadData()
        })
    }


}
