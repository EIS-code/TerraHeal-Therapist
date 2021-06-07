//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit


class ExchangeOfferRequestVC: BaseVC {

   @IBOutlet weak var tblVwForData: UITableView!
    var arrForData:[AvailabilityCellDetail] = [AvailabilityCellDetail.init(),AvailabilityCellDetail.init(),AvailabilityCellDetail.init(),AvailabilityCellDetail.init(),AvailabilityCellDetail.init(),AvailabilityCellDetail.init(),AvailabilityCellDetail.init()]
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

        self.setNavigationTitle(title: "MY_WORKING_SCHEDULE_TITLE".localized())
        self.setBackground(color: UIColor.themeLightBackground)
        self.setupTableView(tableView: self.tblVwForData)
    }
   

}




extension ExchangeOfferRequestVC {
    func wsGetWorkingSchedule(date:String = Date().startOfMonth().millisecondsSince1970.toString()) {
        Loader.showLoading()
        WorkingScheduleWebService.getWorkignSchedule(params: WorkingScheduleWebService.RequestSchedule.init(date: date)) { (response) in
            Loader.hideLoading()
            for data in response.workingList {
                if data.isWorking.toBool {
            //        self.arrForWorkingDays.append(data.date.toDouble)
                }
                if data.isAbsent.toBool{
             //       self.arrForNotAvailableDays.append(data.date.toDouble)
                }

            }
            self.tblVwForData.reloadData()
        }
    }

}
