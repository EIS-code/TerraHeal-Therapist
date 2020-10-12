//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit

struct MyBookingTblCellDetail {
    var title: String = ""
    var image: String = ""
    var isSelected:Bool = false

    init(data:MyBookingData) {
        self.title = Date.milliSecToDate(milliseconds: data.massageDate.toDouble, format: DateFormat.MyBookingCollapseDate)
    }
}

class MyBookingVC: BaseVC {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var vwForCard: ThemeCardView!

    var arrForPastBooking: [MyBookingData] = []
    var arrForFutureBooking: [MyBookingData] = []
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
            self.tableView.reloadData {
                
            }
        } 
    }
    
    private func initialViewSetup() {
        self.setBackground(color: UIColor.themeBackground)
        self.setupTableView(tableView: self.tableView)
        self.vwForCard.topRound()
        self.vwForCard.addGradientFade(colors: [UIColor.init(hex: "#FFFFFF57").cgColor,UIColor.init(hex: "#F6F6F4").cgColor,UIColor.init(hex: "#F6F6F4").cgColor])
    }
    
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        super.btnLeftTapped()
        _ = (self.navigationController as? NC)?.popVC()
    }

    @IBAction func btnSubmitTapped(_ sender: Any) {
        //Common.appDelegate.loadMainVC()
    }
    
    
}


