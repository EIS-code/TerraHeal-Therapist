//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit


class MissingDaysVC: BaseVC {

    @IBOutlet weak var vwCalendar: FSCalendar!
    @IBOutlet weak var btnPreviousMonth: ThemeButton!
    @IBOutlet weak var btnNextMonth: ThemeButton!
    @IBOutlet weak var tblVwForData: UITableView!
    let date = Date().startOfDay
    var arrForNotAvailableDays: [Double] = []
    var arrForWorkingDays: [Double] = []
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
        self.wsGetMissingDays()
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

    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        super.btnLeftTapped()
        self.popVC()
    }
    private func initialViewSetup() {
        self.setNavigationTitle(title: "MY_MISSING_DAYS_TITLE".localized())
        self.setBackground(color: UIColor.themeLightBackground)
        self.btnPreviousMonth.setText(FontSymbol.back_arrow, for: .normal)
        self.btnPreviousMonth.setFont(name: FontName.SemiBold, size: FontSize.button_22)
        self.btnNextMonth.setText(FontSymbol.next_arrow, for: .normal)
        self.btnNextMonth.setFont(name: FontName.SemiBold, size: FontSize.button_22)
        self.setupTableView(tableView: self.tblVwForData)
        self.setupCalendarView(calendar: self.vwCalendar)
        self.arrForWorkingDays = []
        self.arrForNotAvailableDays = []
        
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


extension MissingDaysVC: UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate {
    
    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.register(WorkingScheduleTblCell.nib()
            , forCellReuseIdentifier: WorkingScheduleTblCell.name)
        tableView.register(WorkingScheduleTblSection.nib(), forHeaderFooterViewReuseIdentifier: WorkingScheduleTblSection.name)
        tableView.tableFooterView = UIView()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrForNotAvailableDays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: WorkingScheduleTblCell.name, for: indexPath) as?  WorkingScheduleTblCell
        cell?.lblDetails.setText(Date.init(milliseconds: arrForNotAvailableDays[indexPath.row]).convertDateFormate())
        cell?.lblDetails.textColor = UIColor.notAvailableColor
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: WorkingScheduleTblSection.name) as? WorkingScheduleTblSection {
            view.lblTitle.textColor = UIColor.notAvailableColor
            view.lblTitle.setText(arrForNotAvailableDays.count.toString() + " " + "MISSING_DAYS".localized())
            return view
        }

        return UIView.init()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension MissingDaysVC {
    func wsGetMissingDays(date:String = Date().startOfMonth().millisecondsSince1970.toString()) {
        Loader.showLoading()
        self.arrForWorkingDays.removeAll()
        self.arrForNotAvailableDays.removeAll()
        MissingDayWebService.getMissingDays(params: MissingDayWebService.RequestSchedule.init(date: date)) { (response) in
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
