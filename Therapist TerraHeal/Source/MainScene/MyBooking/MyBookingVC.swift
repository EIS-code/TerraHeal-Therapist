//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit

struct MyBookingTblCellDetail {
    var title: String = ""
    var image: String = ""
    var isSelected:Bool = false

    init(data:BookingWebSerive.BookingData) {
        self.title = Date.milliSecToDate(milliseconds: data.bookingDateTime.toDouble, format: DateFormat.MyBookingCollapseDate)
    }
    init(data:MyBookingData) {
        self.title = Date.milliSecToDate(milliseconds: data.massageDate.toDouble, format: DateFormat.MyBookingCollapseDate)
    }
}

class MyBookingVC: BaseVC {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var vwForCard: ThemeCardView!

    var arrForPastBooking: [BookingWebSerive.BookingData] = []
    var arrForFutureBooking: [BookingWebSerive.BookingData] = []
    var arrForData: [MyBookingTblCellDetail] = []
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
            self.tableView.reloadData {
                
            }
        } 
    }
    
    private func initialViewSetup() {
        self.setBackground(color: UIColor.clear)
        self.setupTableView(tableView: self.tableView)
        self.vwForCard.topRound()
        self.vwForCard.addGradientFade(colors: [UIColor.init(hex: "#FFFFFF57").cgColor,UIColor.init(hex: "#F6F6F4").cgColor,UIColor.init(hex: "#F6F6F4").cgColor])
    }
    
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        super.btnLeftTapped()
        self.popVC()
    }

    @IBAction func btnSubmitTapped(_ sender: Any) {
        //Common.appDelegate.loadMainVC()
    }
    
    
}

//MARK:- Booking Web Service Calls
extension MyBookingVC {
    func wsGetTodaysBooking() {
        BookingWebSerive.todayBookingList { (response) in
            if ResponseModel.isSuccess(response: response) {
                self.arrForPastBooking.removeAll()
                for data in response.bookingList {
                    self.arrForPastBooking.append(data)
                }
                self.setDataSourceForPendingBooking(dataSource: self.arrForPastBooking)
                self.tableView.reloadData()
            }
        }
    }
    func wsGetFutureBooking() {
        BookingWebSerive.futureBookingList { (response) in
            if ResponseModel.isSuccess(response: response) {
                self.arrForFutureBooking.removeAll()
                for data in response.bookingList {
                    self.arrForFutureBooking.append(data)
                }
                self.setDataSourceForPendingBooking(dataSource: self.arrForPastBooking)
                self.tableView.reloadData()
            }
        }
    }

    func wsGetPastBooking() {
        BookingWebSerive.pastBookingList { (response) in
            if ResponseModel.isSuccess(response: response) {
                self.arrForFutureBooking.removeAll()
                for data in response.bookingList {
                    self.arrForFutureBooking.append(data)
                }
                self.setDataSourceForPendingBooking(dataSource: self.arrForPastBooking)
                self.tableView.reloadData()
            }
        }
    }

    func setDataSourceForUpcomingBooking(dataSource:[BookingWebSerive.BookingData]) {
        self.arrForData.removeAll()
        for data in dataSource {
            self.arrForData.append(MyBookingTblCellDetail.init(data: data))
        }
    }

    func setDataSourceForPendingBooking(dataSource:[BookingWebSerive.BookingData]) {
        self.arrForData.removeAll()
        for data in dataSource {
            self.arrForData.append(MyBookingTblCellDetail.init(data: data))
        }
    }
}


