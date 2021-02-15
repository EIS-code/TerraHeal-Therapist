//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit



class NewsVC: BaseVC {
    
    @IBOutlet weak var tableView: UITableView!

    var isHideNavigationBar: Bool = false
    var arrForData: [NewsWebService.NewsData] = []
    
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
        self.vwNavigationBar.isHidden = isHideNavigationBar
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.wsGetNews()
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
        self.setupTableView(tableView: self.tableView)
        self.setNavigationTitle(title: "NEWS_TITLE".localized())

    }
    

    
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        super.btnLeftTapped()
        self.popVC()
    }

    @IBAction func btnSubmitTapped(_ sender: Any) {
        Common.appDelegate.loadMainVC()
    }
}

extension NewsVC: UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate {
    
    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        tableView.register(NewsTblCell.nib()
            , forCellReuseIdentifier: NewsTblCell.name)
        tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrForData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTblCell.name, for: indexPath) as?  NewsTblCell
        cell?.layoutIfNeeded()
        cell?.setData(data: arrForData[indexPath.row])
        cell?.btnCheck.tag = indexPath.row
        cell?.btnCheck.addTarget(self, action: #selector(readNews(sender:)), for: .touchUpInside)
        cell?.layoutIfNeeded()
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

    }
    @objc func readNews(sender:UIButton) {
        self.wsReadNews(id: self.arrForData[sender.tag].id)

    }
    
}

extension NewsVC {
    func wsGetNews() {
        Loader.showLoading()
        NewsWebService.getUpdatedNews { (response) in
            Loader.hideLoading()
            self.arrForData.removeAll()
            if ResponseModel.isSuccess(response: response) {

                for data in response.newsList {
                    self.arrForData.append(data)
                }
                self.tableView.reloadData()
            }
        }
    }
    func wsReadNews(id:String) {
        Loader.showLoading()
        NewsWebService.readNews(params: NewsWebService.RequestReadNews.init(id: id)) { (response) in
            Loader.hideLoading()
            if ResponseModel.isSuccess(response: response) {
                self.wsGetNews()
            }
        }
    }
}
