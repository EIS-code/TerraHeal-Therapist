//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit


class WorkingScheduleVC: BaseVC {

    @IBOutlet weak var vwCalendar: FSCalendar!
    @IBOutlet weak var tblVwForData: UITableView!
    @IBOutlet weak var btnPreviousMonth: ThemeButton!
    @IBOutlet weak var btnNextMonth: ThemeButton!
    let date = Date().startOfDay
    var arrForNotAvailableDays: [Double] = []
    var arrForWorkingDays: [Double] = []
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
        self.btnPreviousMonth.setText(FontSymbol.back_arrow, for: .normal)
        self.btnPreviousMonth.setFont(name: FontName.SemiBold, size: FontSize.button_22)
        self.btnNextMonth.setText(FontSymbol.next_arrow, for: .normal)
        self.btnNextMonth.setFont(name: FontName.SemiBold, size: FontSize.button_22)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.wsGetWorkingSchedule()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if self.isViewAvailable() {

        }
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
    private func initialViewSetup() {
        self.arrForWorkingDays = []
        self.arrForNotAvailableDays = []

        self.setNavigationTitle(title: "MY_WORKING_SCHEDULE_TITLE".localized())
        self.setBackground(color: UIColor.themeLightBackground)
        self.setupTableView(tableView: self.tblVwForData)
        self.setupCalendarView(calendar: self.vwCalendar)
    }
   
    @IBAction func btnExchangeTapped(_ sender: Any) {
        Common.appDelegate.loadExchangeOfferVC(navigaionVC: self.navigationController)
    }

}




extension WorkingScheduleVC {
    func wsGetWorkingSchedule(date:String = Date().startOfMonth().millisecondsSince1970.toString()) {
        self.arrForWorkingDays.removeAll()
        self.arrForNotAvailableDays.removeAll()
        Loader.showLoading()
        WorkingScheduleWebService.getWorkignSchedule(params: WorkingScheduleWebService.RequestSchedule.init(date: date)) { (response) in
            Loader.hideLoading()
            for data in response.workingList {
                if data.isWorking.toBool {
                    self.arrForWorkingDays.append(data.date.toDouble)
                }
                if data.isAbsent.toBool{
                    self.arrForNotAvailableDays.append(data.date.toDouble)
                }

            }
            self.vwCalendar.reloadData()
            self.tblVwForData.reloadData()
        }
    }

}
