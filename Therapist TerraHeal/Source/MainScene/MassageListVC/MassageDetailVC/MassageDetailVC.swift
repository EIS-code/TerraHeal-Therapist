//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit



class MassageDetailVC: BaseVC {
    @IBOutlet weak var vwExpanded: UIView!
       @IBOutlet weak var vwDate: UIView!
       @IBOutlet weak var lblDate: ThemeLabel!
       @IBOutlet weak var tableView: UITableView!
       @IBOutlet weak var htblVw: NSLayoutConstraint!
       @IBOutlet weak var lblBookingTime: ThemeLabel!
       @IBOutlet weak var lblDelayTime: ThemeLabel!
       @IBOutlet weak var lblBookingDetail: ThemeLabel!
       @IBOutlet weak var lblBookingTypeValue: ThemeLabel!
       @IBOutlet weak var lblCenterName: ThemeLabel!
       @IBOutlet weak var lblCenterAddress: ThemeLabel!
       @IBOutlet weak var lblBookDateAndTime: ThemeLabel!
       @IBOutlet weak var ivForQr: UIImageView!
       @IBOutlet weak var lblbSessionDetail: ThemeLabel!
       @IBOutlet weak var lblSessionValue: ThemeLabel!
        var arrForData: [MyBookingTblCellDetail] = [MyBookingTblCellDetail.init(data: MyBookingData.init(fromDictionary: [:])),MyBookingTblCellDetail.init(data: MyBookingData.init(fromDictionary: [:])),MyBookingTblCellDetail.init(data: MyBookingData.init(fromDictionary: [:])),MyBookingTblCellDetail.init(data: MyBookingData.init(fromDictionary: [:])),MyBookingTblCellDetail.init(data: MyBookingData.init(fromDictionary: [:]))]
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
            self.tableView.reloadData(heightToFit: self.htblVw) {
                      self.vwExpanded?.setRound(withBorderColor: .clear, andCornerRadious: 15.0, borderWidth: 1.0)
                      self.vwDate?.setRound(withBorderColor: .clear, andCornerRadious: 15, borderWidth: 1.0)
                      print(#function)
                  }
        }
    }
    
    private func initialViewSetup() {
        self.setBackground(color: .themeBackground)
        self.setNavigationTitle(title: "MY_MASSAGES_DETAIL_TITLE".localized())
        self.lblDate?.setFont(name: FontName.Bold, size: FontSize.subHeader)
        self.vwExpanded?.setRound(withBorderColor: .clear, andCornerRadious: 15.0, borderWidth: 1.0)
        self.vwDate?.setRound(withBorderColor: .clear, andCornerRadious: 15, borderWidth: 1.0)
        self.lblBookingTime.setFont(name: FontName.Regular, size: FontSize.detail)
        self.lblDelayTime.setFont(name: FontName.Regular, size: FontSize.detail)
        self.lblBookingDetail.setFont(name: FontName.SemiBold, size: FontSize.subHeader)
        self.lblBookingTypeValue.setFont(name: FontName.Regular, size: FontSize.detail)
        self.lblCenterName.setFont(name: FontName.Regular, size: FontSize.detail)
        self.lblCenterAddress.setFont(name: FontName.Regular, size: FontSize.detail)
        self.lblBookDateAndTime.setFont(name: FontName.Regular, size: FontSize.detail)
        self.lblbSessionDetail.setFont(name: FontName.SemiBold, size: FontSize.subHeader)
        self.lblSessionValue.setFont(name: FontName.Regular, size: FontSize.detail)
        self.setupTableView(tableView: self.tableView)
    }
    

    
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        super.btnLeftTapped()
        self.popVC()
    }

}

extension MassageDetailVC :  UITableViewDelegate,UITableViewDataSource {
    func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 40
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 50
        tableView.register(MassageDetailTblCell.nib()
                   , forCellReuseIdentifier: MassageDetailTblCell.name)
        tableView.register(UserDetailTblSection.nib(), forHeaderFooterViewReuseIdentifier: UserDetailTblSection.name)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrForData.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: MassageDetailTblCell.name, for: indexPath) as?  MassageDetailTblCell
        cell?.setData(data: MassageCellDetail.init(title: "ABC", subTitle: "abc"))
        return cell!
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       guard let view = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: UserDetailTblSection.name)
            as? UserDetailTblSection
            else {
                return nil
        }
        view.setData(data: UserDetailSectionModel.init(name: "jaydeep", age: "25", gender: "Male"))
        return view

    }
}
