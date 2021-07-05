//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit


enum BookingDateFilterType : Int {
    case Past = 0
    case Today  = 1
    case Future = 2
}
class HomeVC: BaseVC {



    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnFilter: FloatingRoundButton!
    @IBOutlet weak var vwFilterDialog: UIView!
    @IBOutlet weak var tblForFilter: UITableView!
    @IBOutlet weak var hFilterTble: NSLayoutConstraint!
    @IBOutlet weak var vwFilter: UIView!
    @IBOutlet weak var btnSubFilter: FloatingRoundButton!
    var selectedFilterType: BookingDateFilterType = .Today
    var selectedSubFilterType: SubFilterType = .Date

    var arrForData: [MyBookingTblDetail] = []
    var arrForOriginalData: [BookingData] = []
    var arrForFilter: [ImageWithTitle] = [
        ImageWithTitle.init(name: "HOME_FILTER_TODAY".localized(), imageName: ImageAsset.Filter.today, data: BookingDateFilterType.Today),
        ImageWithTitle.init(name: "HOME_FILTER_FUTURE".localized(), imageName: ImageAsset.Filter.future, data: BookingDateFilterType.Future),
        ImageWithTitle.init(name: "HOME_FILTER_PAST".localized(), imageName: ImageAsset.Filter.past, data: BookingDateFilterType.Past)
    ]
    var selectedDate: Date? = nil
    var currentBookingRequest: BookingWebSerive.RequestBookingList = BookingWebSerive.RequestBookingList.init()
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

            self.vwFilterDialog.setRound(withBorderColor: .clear, andCornerRadious: JDDeviceHelper.offseter(offset: 24), borderWidth: 1.0)
            self.vwFilterDialog.setShadow(radius: 10.0, opacity: 1.0, offset: CGSize.init(width: 0.0, height: 10), color: UIColor.init(hex: "#00000029"))
            self.tblForFilter.reloadData(heightToFit: self.hFilterTble) {

            }
            self.tableView?.reloadData({
            })
        }
    }
    
    private func initialViewSetup() {
        
        self.setupTableView(tableView: self.tableView)
        self.tableView.tableHeaderView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.bounds.width, height: JDDeviceHelper.offseter(offset: 0)))
        self.tableView.tableFooterView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.bounds.width, height: JDDeviceHelper.offseter(offset: 82)))
        self.registerNib(tableView: tableView)
        self.setupTableView(tableView: self.tblForFilter)
        self.registerFilterNib(tableView: self.tblForFilter)
        self.lblTitle?.setFont(name: FontName.Bold, size: FontSize.large)
        self.setNavigationTitle(title: "".localized())
        self.vwFilter.backgroundColor = .clear
        self.currentBookingRequest.massage_date = Date().millisecondsSince1970.toString()
        self.wsGetTodaysBooking(request: self.currentBookingRequest)
        //self.wsGetPastBooking(request: self.pastBookingRequest)
    }
    
    @IBAction func btnMenuTapped(_ sender: Any) {
        Common.appDelegate.loadLoginVC()
    }
    
    @IBAction func btnFilterTapped(_ sender: UIButton) {
        btnFilter.isEnabled = false
        btnFilter.isSelected.toggle()
        self.updateFilterButton(isShowFilter: btnFilter.isSelected)
    }

    @IBAction func btnSubFilterTapped(_ sender: Any) {
        self.btnSubFilter.isEnabled = false
        self.openSubFilterDialog()
    }


    func updateFilterButton(isShowFilter:Bool) {

        let image: UIImage? = isShowFilter ? UIImage.init(named: "asset-close") : UIImage.init(named: "asset-filter")

        isShowFilter ? self.showFilterDialog() : self.hideFilterDialog()

        UIView.transition(with: btnFilter as UIView, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.btnFilter.setImage(image, for: .normal)
            self.btnFilter.isEnabled = true
        }, completion: nil)
    }
}

extension HomeVC {
    func showFilterDialog() {

        self.vwFilter.isUserInteractionEnabled = false
        //self.vwFilterDialog.setAnchorPoint(CGPoint.init(x: 1.0, y: 1.0))
        self.vwFilterDialog.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        self.tblForFilter.transform = CGAffineTransform(translationX: 0.0, y: self.tblForFilter.frame.maxY)
        self.vwFilter.isHidden = false
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
            self.vwFilterDialog.transform = .identity
            self.tblForFilter.transform = CGAffineTransform.identity

        }) { (success) in
            self.btnFilter.isSelected = true
            self.vwFilter.isUserInteractionEnabled = true
        }
    }


    func hideFilterDialog() {
        self.vwFilter.isHidden = false
        self.vwFilterDialog.isUserInteractionEnabled = false
        self.vwFilterDialog.transform = CGAffineTransform.identity
        self.tblForFilter.transform = CGAffineTransform.identity
        UIView.animate(withDuration: 0.2, delay: 0, options: UIView.AnimationOptions.curveLinear,
                       animations: {
                        self.vwFilterDialog.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                        self.tblForFilter.transform = CGAffineTransform(translationX: 0.0, y: -10.0)
                       }, completion: { Void in()
                        UIView.animate(withDuration: 0.5, animations: {
                            self.tblForFilter.transform = CGAffineTransform(translationX: 0.0, y: (self.view.frame.maxY - self.tblForFilter.frame.minY))
                            self.vwFilterDialog.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
                        }) { (success) in
                            self.vwFilter.isHidden = true
                            self.btnFilter.isSelected = false
                        }
                       })

    }

    func openSubFilterDialog() {
        let alert: CustomFilterDialog = CustomFilterDialog.fromNib()
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            guard let self = self else { return } ; print(self)
            alert?.dismiss()
            self.btnSubFilter.isEnabled = true
        }
        alert.onBtnClearAllTapped = { [weak alert, weak self] in
            guard let self = self else { return } ; print(self)
            alert?.dismiss()
            self.btnSubFilter.isEnabled = true
            self.currentBookingRequest = BookingWebSerive.RequestBookingList.init()
            if self.selectedFilterType == .Past {
                self.wsGetPastBooking(request: self.currentBookingRequest)
            } else if self.selectedFilterType == .Future {
                self.wsGetFutureBooking(request: self.currentBookingRequest)
            } else {
                self.wsGetTodaysBooking(request: self.currentBookingRequest)
            }

        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self] (filterType,value) in
            guard let self = self else { return } ; print(self)
            alert?.dismiss()
            self.btnSubFilter.isEnabled = true
            self.selectedSubFilterType = filterType
            switch filterType {
            case .BookingType:
                self.currentBookingRequest.booking_type = value as! String
            case .Date:
                self.currentBookingRequest.massage_date = value as! String
                self.selectedDate = Date.init(milliseconds: (value as! String).toDouble)
            case .ClientName:
                self.currentBookingRequest.user_id = value as! String
            case .Massages:
                self.currentBookingRequest.type = (ServiceType.Massages.rawValue).toString()
                self.currentBookingRequest.service_id = value as! String
            case .Therapies:
                self.currentBookingRequest.type = (ServiceType.Therapies.rawValue).toString()
                self.currentBookingRequest.service_id = value as! String
            case .SessionType:
                self.currentBookingRequest.session_type = value as! String
            }
            if self.selectedFilterType == .Future {
                self.wsGetFutureBooking(request: self.currentBookingRequest)
            } else if self.selectedFilterType == .Past{
                self.wsGetPastBooking(request: self.currentBookingRequest)
            } else {
                self.wsGetTodaysBooking(request: self.currentBookingRequest)
            }
        }
    }

    @objc func openDatePicker(sender: UIButton) {
        let alert: DateDialog = DateDialog.fromNib()
        alert.initialize(title: "Date")
        let initialFrame: CGRect =  sender.convert(sender.bounds, to: Common.appDelegate.window!)
        alert.initialFrame = initialFrame
        if self.selectedFilterType == .Past {
            alert.setDate(minDate: nil, maxDate: Date())
        } else if self.selectedFilterType == .Future {
            alert.setDate(minDate: Date(), maxDate: nil)
        } else {
            alert.setDate(minDate: nil, maxDate: nil)
        }
        alert.show(animated: true)

        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            guard let self = self else { return } ; print(self)
            alert?.dismiss()
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self] (date) in
            guard let self = self else { return } ; print(self)
            alert?.dismiss()
            self.selectedDate = Date.init(milliseconds: date)
            if self.selectedFilterType == .Past {
                self.currentBookingRequest.massage_date = date.toString()
                self.wsGetPastBooking(request: self.currentBookingRequest)
            } else if self.selectedFilterType == .Future {
                self.currentBookingRequest.massage_date = date.toString()
                self.wsGetFutureBooking(request: self.currentBookingRequest)
            } else {
                self.currentBookingRequest.massage_date = Date().millisecondsSince1970.toString()
                self.wsGetTodaysBooking(request: self.currentBookingRequest)
            }
        }
    }
}



extension HomeVC: PBRevealViewControllerDelegate {
    func revealControllerPanGestureShouldBegin(_ revealController: PBRevealViewController, direction: PBRevealControllerPanDirection) -> Bool {
        return true
    }

}

//MARK:- Web Service Call
extension HomeVC {
    func wsGetTodaysBooking(request: BookingWebSerive.RequestBookingList) {
        Loader.showLoading()
        self.selectedDate = Date.init(milliseconds: request.massage_date.toDouble)
        BookingWebSerive.todayBookingList(params: request) { (response) in
            Loader.hideLoading()
            if ResponseModel.isSuccess(response: response) {
                self.arrForOriginalData.removeAll()
                self.arrForData.removeAll()
                for data in response.bookingList {
                    self.arrForData.append(data.toBookingModel(filterType: self.selectedSubFilterType))
                    self.arrForOriginalData.append(data)
                }
                self.tableView?.reloadData()
            }
        }
    }
    func wsGetFutureBooking(request: BookingWebSerive.RequestBookingList) {
        Loader.showLoading()

        self.selectedDate = Date.init(milliseconds: request.massage_date.toDouble)
        BookingWebSerive.futureBookingList(params: request) { (response) in
            Loader.hideLoading()
            if ResponseModel.isSuccess(response: response) {
                self.arrForOriginalData.removeAll()
                self.arrForData.removeAll()
                for data in response.bookingList {
                    self.arrForData.append(data.toBookingModel(filterType: self.selectedSubFilterType))
                    self.arrForOriginalData.append(data)
                }
                self.tableView.reloadData()
            }
        }
    }

    func wsGetPastBooking(request: BookingWebSerive.RequestBookingList) {
        Loader.showLoading()
        self.selectedDate = Date.init(milliseconds: request.massage_date.toDouble)
        BookingWebSerive.pastBookingList(params: request) { (response) in
            Loader.hideLoading()
            if ResponseModel.isSuccess(response: response) {
                self.arrForOriginalData.removeAll()
                self.arrForData.removeAll()
                for data in response.bookingList {
                    self.arrForData.append(data.toBookingModel(filterType: self.selectedSubFilterType))
                    self.arrForOriginalData.append(data)
                }
                self.tableView.reloadData()
            }
        }
    }
}
