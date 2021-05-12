//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit


struct NotificationDetail {
    var title: String = ""
    var message: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do"
    var date: String = "today 3:15 PM"
}

class NotificationVC: BaseVC {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblEmptyTitle: ThemeLabel!
    @IBOutlet weak var lblEmptyMsg: ThemeLabel!
    @IBOutlet weak var vwForEmpty: UIView!
    var arrForNotification: [NotificationDetail] = [
        NotificationDetail(),
        NotificationDetail(),
        NotificationDetail()
    ]
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
        tableView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
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
        
        self.setBackground(color: UIColor.themeWhite)
        self.setupTableView(tableView: self.tableView)

        self.setNavigationTitle(title:"NOTIFICATION_TITLE".localized())
        self.lblEmptyTitle.setFont(name: FontName.Bold, size: FontSize.subHeader)
        self.lblEmptyMsg.setFont(name: FontName.Regular, size: FontSize.detail)
        self.lblEmptyTitle.setText( "NO_NOTIFICATION_TITLE".localized())
        self.lblEmptyMsg.setText("")
        self.updateUI()
    }
    
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        super.btnLeftTapped()
        self.popVC()
        /*if arrForNotification.isEmpty {

        } else {
            self.arrForNotification.removeAll()
            self.updateUI()
        }*/

        
    }
    
    func updateUI()  {
        if arrForNotification.isEmpty {
            self.setBackground(color: UIColor.themeWhite)
            self.vwForEmpty.isHidden = false
            self.tableView.isHidden = true
        } else {
            self.setBackground(color: UIColor.themeLightBackground)
            self.vwForEmpty.isHidden = true
            self.tableView.isHidden = false
        }
        self.tableView.reloadData()
    }
}


extension NotificationVC: UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate {
    
    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(NotificationTblCell.nib()
            , forCellReuseIdentifier: NotificationTblCell.name)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrForNotification.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationTblCell.name, for: indexPath) as?  NotificationTblCell
        cell?.layoutIfNeeded()
        cell?.setData(data: arrForNotification[indexPath.row])
        cell?.layoutIfNeeded()
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}

