//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit

struct MyBookingTblCellDetail {
    var title: String = ""
    var image: String = ""
    var isSelected:Bool = false

    init(data:BookingData) {
        self.title = Date.milliSecToDate(milliseconds: data.bookingDateTime.toDouble, format: DateFormat.MyBookingCollapseDate)
    }
    init(data:BookingDetail) {
        self.title = Date.milliSecToDate(milliseconds: data.massageDate.toDouble, format: DateFormat.MyBookingCollapseDate)
    }
}

class MyBookingVC: BaseVC {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var vwForCard: ThemeCardView!

    var arrForOriginalBooking: [BookingDetail] = []
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
    func wsGetBookingList(date:String) {
        CalenderWebService.callCalenderBookingDetail(params: CalenderWebService.RequestGetCalenderBookingDetail.init(booking_date: date)) { (response) in
            if ResponseModel.isSuccess(response: response) {
                self.arrForOriginalBooking.removeAll()
                for data in response.bookingList {
                    self.arrForOriginalBooking.append(data)
                }
                //self.setDataSourceForPendingBooking(dataSource: self.arrForPastBooking)
                self.tableView.reloadData()
            }
        }
    }



}


