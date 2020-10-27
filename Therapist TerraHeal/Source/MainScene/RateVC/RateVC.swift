//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit



class RateVC: BaseVC {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnRate: FilledRoundedButton!
    @IBOutlet weak var btnCancel: RoundedBorderButton!

    var arrForData: [RateTblCellDetail] = [
    RateTblCellDetail.init(title: "Punctuality And Presence For Reservations", rate: 1.0, isSelected: false),
    RateTblCellDetail.init(title: "Behavior", rate: 2.0, isSelected: false),
    RateTblCellDetail.init(title: "Sexual Issues", rate: 3.0, isSelected: false),
    RateTblCellDetail.init(title: "Hygiene", rate: 4.0, isSelected: false),
    RateTblCellDetail.init(title: "Left Bad / Good Review", rate: 5.0, isSelected: false),
    RateTblCellDetail.init(title: "Payment Issues", rate: 1.0, isSelected: false)]
    
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
            self.tableView?.reloadData({
            })
            self.tableView?.contentInset = self.getGradientInset()
        }
    }
    
    private func initialViewSetup() {
        self.setBackground(color: .themeWhite)
        self.setupTableView(tableView: self.tableView)
        self.setNavigationTitle(title: "RATING_TITLE".localized())
        self.btnRate.setText("RATING_BTN_RATE".localized(), for: .normal)
        self.btnCancel.setText("RATING_BTN_CANCEL".localized(), for: .normal)
    }
    

    
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        super.btnLeftTapped()
        _ = (self.navigationController as? NC)?.popVC()
    }

    @IBAction func btnSubmitTapped(_ sender: Any) {
        Common.appDelegate.loadMainVC()
    }
}

extension RateVC: UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate {
    
    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        tableView.register(RateTblCell.nib()
            , forCellReuseIdentifier: RateTblCell.name)
        tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrForData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: RateTblCell.name, for: indexPath) as?  RateTblCell
        cell?.layoutIfNeeded()
        cell?.setData(data: arrForData[indexPath.row])
        cell?.layoutIfNeeded()
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

    }
    
}
