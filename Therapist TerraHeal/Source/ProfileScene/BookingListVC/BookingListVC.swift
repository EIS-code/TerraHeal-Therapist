//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit

class BookingListVC: BaseVC {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var vwTab: JDSegmentedControl!
    @IBOutlet weak var vwBg: UIView!
    
    var arrForOriginalData: [BookingDetail] = []
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
                self.wsGetPendingBooking()
                break
            case 1:
                self.wsGetUpcomingBooking()
                break
            default:
                self.wsGetPastBooking()
                break
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
        tableView.register(MyBookingCollapseCell.nib()
                           , forCellReuseIdentifier: MyBookingCollapseCell.name)
        tableView.register(MyBookingExpandTblCell.nib()
                           , forCellReuseIdentifier: MyBookingExpandTblCell.name)
        tableView.tableFooterView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.bounds.width, height: JDDeviceHelper.offseter(offset: 88)))
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrForOriginalData.count
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
        if arrForOriginalData[indexPath.row].isSelected {
            print("Row Height:- \(tableView.estimatedRowHeight)")
            return UITableView.automaticDimension
        }
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        for i in 0..<arrForOriginalData.count {
            if indexPath.row != i {
                arrForOriginalData[i].isSelected = false
            } else {
                self.arrForOriginalData[indexPath.row].isSelected.toggle()
            }

        }
        tableView.beginUpdates()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            self.tableView.reloadData()
        }
        tableView.endUpdates()

    }
    
}

extension BookingListVC {
    func wsGetPendingBooking() {
        Loader.showLoading()
        BookingWebSerive.myBookingPendingList { (response) in
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
    func wsGetUpcomingBooking() {
        Loader.showLoading()
        BookingWebSerive.myBookingUpcomingList { (response) in
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

    func wsGetPastBooking() {
        Loader.showLoading()
        BookingWebSerive.myBookingPastList { (response) in
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
