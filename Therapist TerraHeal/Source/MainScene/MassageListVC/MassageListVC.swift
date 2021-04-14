//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit



class MassageListVC: BaseVC {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblNumberOfMassage: ThemeLabel!
    @IBOutlet weak var lblNumberOfMassageValue: ThemeLabel!
    @IBOutlet weak var vwTotalNumberOfMassage: UIView!

    var arrForData: [MyBookingTblDetail] = []
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
        self.wsGetBookingList()
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
            self.vwTotalNumberOfMassage.setRound(withBorderColor: .clear, andCornerRadious: JDDeviceHelper.offseter(offset: 15), borderWidth: 1.0)
            self.vwTotalNumberOfMassage.setShadow(radius: 10.0, opacity: 1.0, offset: CGSize.init(width: 3.0, height: 0.0), color: UIColor.init(hex: "#0000001C"))
            self.tableView?.reloadData({
            })
            self.tableView?.contentInset = self.getGradientInset()
        }
    }
    
    private func initialViewSetup() {
        self.setBackground(color: .themeBackground)
        self.setupTableView(tableView: self.tableView)
        self.setNavigationTitle(title: "MY_NUMBER_OF_MASSAGES_TITLE".localized())
        self.lblNumberOfMassage.setFont(name: FontName.SemiBold, size: FontSize.subHeader)
        self.lblNumberOfMassageValue.setFont(name: FontName.SemiBold, size: FontSize.subHeader)
        self.lblNumberOfMassage.setText("MY_NUMBER_OF_MASSAGES_TITLE".localized())
        self.lblNumberOfMassageValue.setText(appSingleton.user.totalMassages)
    }
    

    
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        super.btnLeftTapped()
        self.popVC()
    }

    @IBAction func btnSubmitTapped(_ sender: Any) {
        Common.appDelegate.loadMainVC()
    }
}

extension MassageListVC: UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate {
    
    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        tableView.register(MyMassageTblCell.nib()
            , forCellReuseIdentifier: MyMassageTblCell.name)
        tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrForData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: MyMassageTblCell.name, for: indexPath) as?  MyMassageTblCell
        cell?.setData(data: arrForData[indexPath.row])
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        Common.appDelegate.loadMassageDetailVC(navigaionVC: self.navigationController, bookingDetail: self.arrForOriginalData[indexPath.row])

    }

    
}
extension MassageListVC {
    func wsGetBookingList() {
        Loader.showLoading()
        BookingWebSerive.numberOfBookingList {  (response) in
            Loader.hideLoading()
            if ResponseModel.isSuccess(response: response) {
                self.arrForOriginalData.removeAll()
                self.arrForData.removeAll()
                for data in response.bookingList {
                    self.arrForData.append(data.toBookingModel())
                    self.arrForOriginalData.append(data)
                }
                self.tableView.reloadData()
            }
        }
    }
}
