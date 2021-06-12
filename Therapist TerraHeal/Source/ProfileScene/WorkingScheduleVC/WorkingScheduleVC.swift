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
    var arrForData:[ShiftContainerCellDetail] = []
    var selectedShiftForExchange: RequestExchangeShift? = nil
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
        if self.selectedShiftForExchange != nil {
            Common.appDelegate.loadExchangeOfferVC(navigaionVC: self.navigationController, shiftData: self.selectedShiftForExchange!)
        }
        else {
            Common.showAlert(message: "WORKING_SCHEDULE_PLEASE_SELECT_SHIFT".localized())
        }

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

    func wsAvailability(date:Double = Date().millisecondsSince1970WithUTC) {
        Loader.showLoading()
        AvailabilityWebService.getAvailabilities(params: AvailabilityWebService.RequestGetAvailability.init(id: "2", date: date.toString())) { (response) in
            Loader.hideLoading()
            if ResponseModel.isSuccess(response: response) {
                for data in response.availabilityList {
                    self.arrForData.append(ShiftContainerCellDetail.init(data: data))
                }
            }

            if !self.arrForData.isEmpty {
                self.arrForData[0].isSelected = true
                self.tblVwForData.reloadData()
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                    self.tblVwForData.reloadData {
                        self.tblVwForData.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .top, animated: true)
                    }
                }
            }
        }
    }
}
