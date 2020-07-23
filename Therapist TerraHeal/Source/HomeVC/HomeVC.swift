//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit

struct MyBookingTblDetail{
    var title: String = ""
    var isSelected: Bool = false
}

class HomeVC: MainVC {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var vwTab: JDSegmentedControl!
    @IBOutlet weak var btnFilter: FloatingRoundButton!
    @IBOutlet weak var vwFilterDialog: UIView!
    @IBOutlet weak var tblForFilter: UITableView!
    @IBOutlet weak var hFilterTble: NSLayoutConstraint!
    @IBOutlet weak var btnMenu: FloatingRoundButton!
    @IBOutlet weak var vwFilter: UIView!
    
    var arrForMyPlaces: [MyBookingTblDetail] = [
        MyBookingTblDetail(title: "29 oct 2020 4:20pm", isSelected: false),
        MyBookingTblDetail(title: "30 oct 2020 6:20pm", isSelected: false),
        MyBookingTblDetail(title: "31 oct 2020 7:30pm", isSelected: false),
        MyBookingTblDetail(title: "01 nov 2020 3:20pm", isSelected: true),
        MyBookingTblDetail(title: "02 nov 2020 12:20pm", isSelected: true),
        MyBookingTblDetail(title: "03 nov 2020 04:20pm", isSelected: true),
    ]
    var arrForFilter: [ImageWithTitle] = [
        ImageWithTitle.init(name: "HOME_FILTER_PAST".localized(), imageName: ImageAsset.Filter.past),
        ImageWithTitle.init(name: "HOME_FILTER_UPCOMING".localized(), imageName: ImageAsset.Filter.upcoming)
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
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if self.isViewAvailable() {
            
            self.vwFilterDialog.setRound(withBorderColor: .themePrimary, andCornerRadious: 20.0, borderWidth: 1.0)
            self.vwTab?.setRound(withBorderColor: .themePrimary, andCornerRadious: self.vwTab.bounds.height/2.0, borderWidth: 0.1)
            self.vwTab?.setShadow()
            self.tableView?.reloadData({
            })
        }
    }
    
    private func initialViewSetup() {
        
        self.setupTableView(tableView: self.tableView)
        self.registerNib(tableView: tableView)
        self.setupTableView(tableView: self.tblForFilter)
        self.registerFilterNib(tableView: self.tblForFilter)
        self.lblTitle?.setFont(name: FontName.Bold, size: FontSize.label_26)
        self.setTitle(title: "".localized())
        
        vwTab.allowChangeThumbWidth = false
        vwTab.itemTitles = ["HOME_BTN_NEWS".localized(),"HOME_BTN_BOOKING".localized(),"HOME_BTN_CHAT".localized()]
        vwTab.itemImages =  [UIImage.init(named: "asset-home")!, UIImage.init(named: "asset-home")!, UIImage.init(named: "asset-home")!]
        vwTab.itemSelectedImages = [UIImage.init(named: "asset-home-selected")!, UIImage.init(named: "asset-home-selected")!, UIImage.init(named: "asset-home-selected")!]
        vwTab.changeBackgroundColor(UIColor.themeLightTextColor)
        vwTab.didSelectItemWith = { [weak self] (index,title) in
            guard let self = self else { return } ; print(self)
        }
        
    }
    
    @IBAction func btnMenuTapped(_ sender: Any) {
        Common.appDelegate.loadLoginVC()
    }
    
    @IBAction func btnFilterTapped(_ sender: UIButton) {
        sender.isEnabled = false
        sender.isSelected.toggle()
        let image: UIImage? = sender.isSelected ? UIImage.init(named: "asset-close") : UIImage.init(named: "asset-filter")
        sender.isSelected ? self.showFilterDialog() : self.hideFilterDialog()
        UIView.transition(with: sender as UIView, duration: 0.5, options: .transitionCrossDissolve, animations: {
            sender.setImage(image, for: .normal)
            sender.isEnabled = true
        }, completion: nil)
    }
    
    func showFilterDialog() {
        
        self.vwFilter.isUserInteractionEnabled = false
        self.vwFilterDialog.setAnchorPoint(CGPoint.init(x: 1.0, y: 1.0))
        self.vwFilterDialog.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        self.tblForFilter.transform = CGAffineTransform(translationX: 0.0, y: self.tblForFilter.frame.maxY)
        self.vwFilter.isHidden = false
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
            self.vwFilterDialog.transform = .identity
            self.tblForFilter.transform = CGAffineTransform.identity
            
        }) { (success) in
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
                }
        })
    }
}


extension HomeVC: UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate {
    
    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    private func registerNib(tableView: UITableView) {
        tableView.register(MyBookingTblCell.nib()
            , forCellReuseIdentifier: MyBookingTblCell.name)
        tableView.tableFooterView = UIView()
    }
    private func registerFilterNib(tableView: UITableView) {
        tableView.register(FilterTblCell.nib()
            , forCellReuseIdentifier: FilterTblCell.name)
        tableView.tableFooterView = UIView()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblForFilter {
            return arrForFilter.count
        }
        return arrForMyPlaces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == tblForFilter {
            let cell = tableView.dequeueReusableCell(withIdentifier: FilterTblCell.name, for: indexPath) as?  FilterTblCell
            cell?.setData(data: arrForFilter[indexPath.row])
            return cell!
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: MyBookingTblCell.name, for: indexPath) as?  MyBookingTblCell
            cell?.layoutIfNeeded()
            cell?.setData(data: arrForMyPlaces[indexPath.row])
            cell?.layoutIfNeeded()
            return cell!
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == tblForFilter {
            return 30
        }
        return UITableView.automaticDimension
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if tableView == tblForFilter {
            self.hideFilterDialog()
        }  else {
            Common.appDelegate.loadBookingDetailVC(navigaionVC: self.navigationController,isBookingFinished: self.arrForMyPlaces[indexPath.row].isSelected)
        }
        
    }
    
}

