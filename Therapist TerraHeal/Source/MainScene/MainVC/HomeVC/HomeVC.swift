//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit



class HomeVC: BaseVC {

    enum FilterType : Int {
        case Past = 0
        case Today  = 1
        case Future = 2
    }

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnFilter: FloatingRoundButton!
    @IBOutlet weak var vwFilterDialog: UIView!
    @IBOutlet weak var tblForFilter: UITableView!
    @IBOutlet weak var hFilterTble: NSLayoutConstraint!
    @IBOutlet weak var vwFilter: UIView!
    @IBOutlet weak var btnSubFilter: FloatingRoundButton!

    var selectedFilterType: FilterType = .Today

    var arrForMyPlaces: [MyBookingTblDetail] = [
        MyBookingTblDetail(title: "29 oct 2020 4:20pm", isSelected: false),
        MyBookingTblDetail(title: "30 oct 2020 6:20pm", isSelected: false),
        MyBookingTblDetail(title: "31 oct 2020 7:30pm", isSelected: false),
        MyBookingTblDetail(title: "01 nov 2020 3:20pm", isSelected: true),
        MyBookingTblDetail(title: "02 nov 2020 12:20pm", isSelected: true),
        MyBookingTblDetail(title: "03 nov 2020 04:20pm", isSelected: true),
    ]
    var arrForFilter: [ImageWithTitle] = [
        ImageWithTitle.init(name: "HOME_FILTER_TODAY".localized(), imageName: ImageAsset.Filter.today, data: FilterType.Today),
        ImageWithTitle.init(name: "HOME_FILTER_FUTURE".localized(), imageName: ImageAsset.Filter.future, data: FilterType.Future),
        ImageWithTitle.init(name: "HOME_FILTER_PAST".localized(), imageName: ImageAsset.Filter.past, data: FilterType.Past)
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
        self.tableView.tableHeaderView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.bounds.width, height: JDDeviceHelper.offseter(offset: 80)))
        self.tableView.tableFooterView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.bounds.width, height: JDDeviceHelper.offseter(offset: 52)))
        self.registerNib(tableView: tableView)
        self.setupTableView(tableView: self.tblForFilter)
        self.registerFilterNib(tableView: self.tblForFilter)
        self.lblTitle?.setFont(name: FontName.Bold, size: FontSize.large)
        self.setNavigationTitle(title: "".localized())
        self.vwFilter.backgroundColor = .clear
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
        alert.onBtnDoneTapped = {
            [weak alert, weak self] (filterType,value) in
            guard let self = self else { return } ; print(self)
            alert?.dismiss()
            self.arrForMyPlaces.removeAll()
            for _ in 0...5 {
                self.arrForMyPlaces.append(MyBookingTblDetail.init(title: value as! String, isSelected: false))
            }
            self.tableView.reloadData()
            self.btnSubFilter.isEnabled = true
        }
    }
}



extension HomeVC: PBRevealViewControllerDelegate {
    func revealControllerPanGestureShouldBegin(_ revealController: PBRevealViewController, direction: PBRevealControllerPanDirection) -> Bool {
        return true
    }

}
