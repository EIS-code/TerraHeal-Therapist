//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit

enum AvailabilityStatus: Int {
    case Available = 1
    case NotAvailable = 2
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
    @IBOutlet weak var cltForAvailability: UICollectionView!
    @IBOutlet weak var hCltVw: NSLayoutConstraint!

    var arrForAvailability:[Any] = []
    var arrForData:[AvailabilityCellDetail] = [
        AvailabilityCellDetail.init(value: "9 AM", availabilityStatus: .Available),
        AvailabilityCellDetail.init(value: "10 AM", availabilityStatus: .Available),
        AvailabilityCellDetail.init(value: "11 AM", availabilityStatus: .Available),
        AvailabilityCellDetail.init(value: "12 AM", availabilityStatus: .Available),
        AvailabilityCellDetail.init(value: "1 PM", availabilityStatus: .NotAvailable),
        AvailabilityCellDetail.init(value: "2 PM", availabilityStatus: .NotAvailable),
        AvailabilityCellDetail.init(value: "3 PM", availabilityStatus: .NotAvailable),
        AvailabilityCellDetail.init(value: "4 PM", availabilityStatus: .Available),
        AvailabilityCellDetail.init(value: "5 PM", availabilityStatus: .Available),
        AvailabilityCellDetail.init(value: "6 PM", availabilityStatus: .Available),
        AvailabilityCellDetail.init(value: "7 PM", availabilityStatus: .Available),
        AvailabilityCellDetail.init(value: "8 PM", availabilityStatus: .NotAvailable),
        AvailabilityCellDetail.init(value: "9 PM", availabilityStatus: .NotAvailable),
        AvailabilityCellDetail.init(value: "10 PM", availabilityStatus: .NotAvailable),
        AvailabilityCellDetail.init(value: "11 PM", availabilityStatus: .NotAvailable),
        AvailabilityCellDetail.init(value: "12 PM", availabilityStatus: .NotAvailable),
        AvailabilityCellDetail.init(value: "1 AM", availabilityStatus: .NotAvailable),
        AvailabilityCellDetail.init(value: "2 AM", availabilityStatus: .NotAvailable),
        AvailabilityCellDetail.init(value: "3 AM", availabilityStatus: .NotAvailable),
        AvailabilityCellDetail.init(value: "4 AM", availabilityStatus: .NotAvailable),
        AvailabilityCellDetail.init(value: "5 AM", availabilityStatus: .NotAvailable),
        AvailabilityCellDetail.init(value: "6 AM", availabilityStatus: .NotAvailable),
        AvailabilityCellDetail.init(value: "7 AM", availabilityStatus: .Available),
        AvailabilityCellDetail.init(value: "8 AM", availabilityStatus: .Available),
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
        self.hCltVw.constant = 80 * 8
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
        self.setupCollectionView(collectionView: self.cltForAvailability)

    }

    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        super.btnLeftTapped()
        self.popVC()
    }

    @IBAction func btnPreviousTapped(_ sender: Any) {
           let currentPage = self.vwCalendar.currentPage.previousMonth()
           self.vwCalendar.setCurrentPage(currentPage, animated: true)
    }

    @IBAction func btnNextTapped(_ sender: Any) {
           let currentPage = self.vwCalendar.currentPage.nextMonth()
           self.vwCalendar.setCurrentPage(currentPage, animated: true)
    }

}
