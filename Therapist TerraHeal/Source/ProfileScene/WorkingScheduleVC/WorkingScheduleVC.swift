//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit


class WorkingScheduleVC: BaseVC {

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
        self.arrForWorkingDays = [date.add(component: .day, value: 1).millisecondsSince1970,
        date.add(component: .day, value: 3).millisecondsSince1970,
        date.add(component: .day, value: 5).millisecondsSince1970,
        date.add(component: .day, value: 7).millisecondsSince1970,
        date.add(component: .day, value: -1).millisecondsSince1970,
        date.add(component: .day, value: -2).millisecondsSince1970,
        date.add(component: .day, value: -4).millisecondsSince1970,
        date.add(component: .day, value: -6).millisecondsSince1970]

        self.arrForNotAvailableDays = [date.add(component: .day, value: 2).millisecondsSince1970,
        date.add(component: .day, value: 3).millisecondsSince1970,
        date.add(component: .day, value: 4).millisecondsSince1970,
        date.add(component: .day, value: 6).millisecondsSince1970,
        date.add(component: .day, value: 7).millisecondsSince1970,
        date.add(component: .day, value: 8).millisecondsSince1970,
        date.add(component: .day, value: 9).millisecondsSince1970,
        date.add(component: .day, value: 10).millisecondsSince1970]

        self.setNavigationTitle(title: "MY_WORKING_SCHEDULE_TITLE".localized())
        self.setBackground(color: UIColor.themeLightBackground)
        self.setupTableView(tableView: self.tblVwForData)
        self.setupCalendarView(calendar: self.vwCalendar)
    }

}


extension WorkingScheduleVC: UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate {
    
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
        return arrForWorkingDays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: WorkingScheduleTblCell.name, for: indexPath) as?  WorkingScheduleTblCell
        cell?.lblDetails.setText(Date.init(milliseconds: arrForWorkingDays[indexPath.row]).toString(format: "ddd-MMM-yyyy"))
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: WorkingScheduleTblSection.name) as? WorkingScheduleTblSection {
            view.lblTitle.textColor = UIColor.init(hex: "#33B199")

            view.lblTitle.setText(arrForWorkingDays.count.toString() + " " + "WORKING_DAYS".localized())
            return view
        }


        return UIView.init()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
}

