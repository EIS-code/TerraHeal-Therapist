import UIKit
//import FSCalendar

class CustomFilterDialog: ThemeBottomDialogView {

    var onBtnDoneTapped: ((_ filterType:FilterTab, _ value:Any) -> Void)? = nil
    @IBOutlet var filterTypeButton: [SelectionButton]!
    @IBOutlet weak var activeView: UIView!
    @IBOutlet weak var dateView: UIView!
    //DateDialog
    @IBOutlet weak var vwCalendar: FSCalendar!
    @IBOutlet weak var btnPreviousMonth: ThemeButton!
    @IBOutlet weak var btnNextMonth: ThemeButton!
    var selectedMilli:Double = 0
    var minDate = Date()
    var maxDate = Date()
    var selectedValue: Any? = nil
    enum FilterTab: Int {
        case Date = 0
        case ClientName = 1
        case ServiceType = 2
        case BookingType = 3
        case SessionType = 4
    }

    //ClientDialog
    @IBOutlet weak var vwClientSearch: UIView!
    @IBOutlet weak var vwClientSearchBar: UIView!
    @IBOutlet weak var txtClientSearch: ThemeTextField!
    //ServiceDialog
    @IBOutlet weak var vwServiceSearch: UIView!
    @IBOutlet weak var vwServiceSearchBar: UIView!
    @IBOutlet weak var txtServiceSearch: ThemeTextField!
    @IBOutlet weak var vwServiceSelection: JDSegmentedControl!
    var selectedServiceType: ServiceType = ServiceType.Massages
    //SessionDialog
    @IBOutlet weak var vwSession: UIView!
    @IBOutlet weak var tblForSessionType: UITableView!
    var arrForData: [RadioSelectionTblCellDetail] = []
    //BookingTypeView
    @IBOutlet weak var vwBookingType: UIView!
    @IBOutlet weak var lblCenter: ThemeLabel!
    @IBOutlet weak var lblHome: ThemeLabel!
    @IBOutlet weak var btnHome: JDRadioButton!
    @IBOutlet weak var btnCenter: JDRadioButton!

    var selectedTab: FilterTab = FilterTab.Date

    override func awakeFromNib() {
        super.awakeFromNib()
        self.initialSetup()
        self.setupClientSearchView()
        self.setupServiceSearchView()
        self.setupSession()
        self.setupDateView()
        self.setupBookingTypeView()
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
            case 1:
                buttonTitle = "FILTER_BTN_CLIENT_NAME".localized()
            case 2:
                buttonTitle = "FILTER_BTN_SERVICES".localized()
            case 3:
                buttonTitle = "FILTER_BTN_BOOKING_TYPE".localized()
            case 4:
                buttonTitle = "FILTER_BTN_SESSION_TYPE".localized()
            default:
                buttonTitle = ""
            }
            button.deselect()
            button.setText(buttonTitle)
        }
        self.handleDateView()
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
        self.selectedTab = .ServiceType
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
    }
    @IBAction func btnHomeTapped(_ sender: Any) {
        btnHome.isSelected = true
        btnCenter.isSelected = false
        self.selectedValue = "Home Booking"
    }
    @IBAction func btnCenterTapped(_ sender: Any) {
        btnHome.isSelected = false
        btnCenter.isSelected = true
        self.selectedValue = "Center Booking"
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
    }

    func therapiesTapped(){
        self.vwServiceSelection.selectItemAt(index: 1)
        self.selectedServiceType = ServiceType.Therapies
        self.selectedValue = "Therapy"
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
