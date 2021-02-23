//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit

class BookingListVC: BaseVC {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var vwTab: JDSegmentedControl!
    @IBOutlet weak var vwBg: UIView!
    
    var arrForOriginalData: [BookingData] = []
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
        //self.getPastBookingList()
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
            self.vwTab?.setRound(withBorderColor: .themePrimary, andCornerRadious: self.vwTab.bounds.height/2.0, borderWidth: 0.1)
            self.vwBg?.setRound(withBorderColor: UIColor.clear, andCornerRadious: 20.0, borderWidth: 1.0)
            self.vwBg?.setShadow()
        }
    }
    
    private func initialViewSetup() {
        self.setBackground(color: UIColor.themeBackground)
        self.setupTableView(tableView: self.tableView)
        self.setNavigationTitle(title: "MY_BOOKING_TITLE".localized())
        self.vwTab.allowChangeThumbWidth = false
        self.vwTab.itemTitles = ["pending","upcoming","past"]
        self.vwTab.changeThumbShadowColor(UIColor.themePrimary)
        self.vwTab.changeBackgroundColor(UIColor.themeLightTextColor)
        self.vwTab.didSelectItemWith = { [weak self] (index,title) in
            guard let self = self else { return } ; print(self)
            switch index {
            case 0:
                break
            //self.getPastBookingList()
            default:
                break
            //self.getPastBookingList()
            }
        }
    }
    
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        super.btnLeftTapped()
        self.popVC()
    }
    @IBAction func btnSubmitTapped(_ sender: Any) {
        Common.appDelegate.loadMainVC()
    }
    
    
}


extension BookingListVC: UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate {
    
    func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 500
        tableView.register(BookingDetailTblCell.nib()
                           , forCellReuseIdentifier: BookingDetailTblCell.name)
        tableView.register(MyBookingExpandTblCell.nib()
                           , forCellReuseIdentifier: MyBookingExpandTblCell.name)
        tableView.tableFooterView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.bounds.width, height: JDDeviceHelper.offseter(offset: 88)))
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrForData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let data = arrForOriginalData[indexPath.row]
        if data.isSelected {
            let cell = tableView.dequeueReusableCell(withIdentifier: MyBookingExpandTblCell.name, for: indexPath) as?  MyBookingExpandTblCell
            cell?.parentVC = self
            cell?.indexPath = indexPath
            cell?.layoutIfNeeded()
            cell?.setData(data: data)
            self.tableView.reloadRows(at: [indexPath], with: .none)
            cell?.layoutIfNeeded()
            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: MyBookingCollapseCell.name, for: indexPath) as?  MyBookingCollapseCell
            cell?.setData(data: data)
            return cell!
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if arrForData[indexPath.row].isSelected {
            print("Row Height:- \(tableView.estimatedRowHeight)")
            return UITableView.automaticDimension
        }
        return UITableView.automaticDimension

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        for i in 0..<arrForData.count {
            if indexPath.row != i {
                arrForData[i].isSelected = false
            } else {
                self.arrForData[indexPath.row].isSelected.toggle()
            }

        }
        tableView.beginUpdates()
        if arrForData[indexPath.row].isSelected {
            self.tableView.reloadRows(at: [indexPath], with: .fade)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
                self.tableView.reloadData()
            }
        } else {
            self.tableView.reloadRows(at: [indexPath], with: .fade)
        }
        tableView.endUpdates()

    }
    
}

extension BookingListVC {
    func wsGetTodaysBooking(request: BookingWebSerive.RequestTodayBookingList) {
        Loader.showLoading()
        BookingWebSerive.todayBookingList { (response) in
            Loader.hideLoading()
            if ResponseModel.isSuccess(response: response) {
                self.arrForOriginalData.removeAll()
                for data in response.bookingList {
                    self.arrForOriginalData.append(data)
                }
                self.tableView.reloadData()
            }
        }
    }
    func wsGetFutureBooking(request: BookingWebSerive.RequestFutureBookingList) {
        Loader.showLoading()
        BookingWebSerive.futureBookingList(params: request) { (response) in
            Loader.hideLoading()
            if ResponseModel.isSuccess(response: response) {
                self.arrForOriginalData.removeAll()
                for data in response.bookingList {
                    self.arrForOriginalData.append(data)
                }
                self.tableView.reloadData()
            }

        }
    }

    func wsGetPastBooking(request: BookingWebSerive.RequestPastBookingList) {
        Loader.showLoading()
        BookingWebSerive.pastBookingList(params: request) { (response) in
            Loader.hideLoading()
            if ResponseModel.isSuccess(response: response) {
                self.arrForOriginalData.removeAll()
                for data in response.bookingList {
                    self.arrForOriginalData.append(data)
                }
                self.tableView.reloadData()
            }
        }
    }
}
