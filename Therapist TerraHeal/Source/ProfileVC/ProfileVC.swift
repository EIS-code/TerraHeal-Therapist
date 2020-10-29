//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit




enum ProfileMenu: String {
    case MyProfile = "1"
    case MyBookings = "3"
    case MyWorkingSchedule = "2"
    case MyAvailability = "4"
    case MyMissingDays = "5"
    case MyNumberOfMassages = "6"
    case MyRating = "7"
    case PaymentPreference = "8"
    case Logout = "9"

    func name() -> String {
        switch self {
        case .MyProfile:
            return "PROFILE_MENU_PROFILE".localized()
        case .MyBookings:
            return "PROFILE_MENU_MY_BOOKING".localized()
        case .MyWorkingSchedule:
            return  "PROFILE_MENU_MY_WORKING_SCHEDULE".localized()
        case .MyAvailability:
            return  "PROFILE_MENU_MY_AVAILABILITY".localized()
        case .MyMissingDays:
            return  "PROFILE_MENU_MY_MISSING_DAYS".localized()
        case .MyRating:
            return  "PROFILE_MENU_MY_RATING".localized()
        case .MyNumberOfMassages:
            return  "PROFILE_MENU_MY_NUMBER_OF_MASSAGE".localized()
        case .Logout:
            return  "PROFILE_MENU_LOGOUT".localized()
        case .PaymentPreference:
            return  "PROFILE_MENU_PAYMENT_PREFERENCE".localized()
        }
    }
    func image() -> String {
        switch self {
        case .MyProfile:
            return ImageAsset.ProfileMenu.myProfile
        case .MyBookings:
            return ImageAsset.ProfileMenu.booking
        case .MyWorkingSchedule:
            return ImageAsset.ProfileMenu.workingSchedule
        case .MyAvailability:
            return  ImageAsset.ProfileMenu.availability
        case .MyMissingDays:
            return  ImageAsset.ProfileMenu.missingDays
        case .MyRating:
            return  ImageAsset.ProfileMenu.rating
        case .MyNumberOfMassages:
            return  ImageAsset.ProfileMenu.numberOfMassages
        case .Logout:
            return  ImageAsset.ProfileMenu.logout
        case .PaymentPreference:
            return  ImageAsset.ProfileMenu.paymentPreference
        }
    }
}

struct ProfileItemDetail {
    var type: ProfileMenu = ProfileMenu.MyProfile
}


class ProfileVC: BaseVC {
    
    @IBOutlet weak var btnCancel: CancelButton!
    @IBOutlet weak var btnMenu: FloatingRoundButton!
    @IBOutlet weak var lblEmail: ThemeLabel!
    @IBOutlet weak var lblUserName: ThemeLabel!
    @IBOutlet weak var lblMobile: ThemeLabel!
    @IBOutlet weak var ivQrCode: UIImageView!
    @IBOutlet weak var lblDescription: ThemeLabel!
    @IBOutlet weak var vwBg: UIView!
    @IBOutlet weak var tableView: UITableView!
    var kTableHeaderHeight:CGFloat = 300.0
    @IBOutlet weak var scrVw: UIScrollView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var ivUser: RoundedImageView!
    @IBOutlet weak var hVwContent: NSLayoutConstraint!
    
    
    
    var arrForMenu: [ProfileItemDetail] = [
        ProfileItemDetail(type: ProfileMenu.MyProfile),
        ProfileItemDetail(type: ProfileMenu.MyBookings),
        ProfileItemDetail(type: ProfileMenu.MyWorkingSchedule),
        ProfileItemDetail(type: ProfileMenu.MyAvailability),
        ProfileItemDetail(type: ProfileMenu.MyMissingDays),
        ProfileItemDetail(type: ProfileMenu.MyNumberOfMassages),
        ProfileItemDetail(type: ProfileMenu.MyRating),
        ProfileItemDetail(type: ProfileMenu.PaymentPreference),
        ProfileItemDetail(type: ProfileMenu.Logout)
        //,ProfileItemDetail(type: ProfileMenu.KycVerification,  image: ""),
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
        self.headerView.layoutIfNeeded()
        self.kTableHeaderHeight = self.headerView.frame.height
        scrVw.contentInset = UIEdgeInsets(top: kTableHeaderHeight, left: 0, bottom: 0, right: 0)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setUserData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if self.isViewAvailable() {
            
            //self.updateHeaderView()
            self.vwBg?.setRound(withBorderColor: UIColor.clear, andCornerRadious: 20.0, borderWidth: 1.0)
            self.vwBg?.setShadow(radius: 2.0, opacity: 1.0, offset: CGSize.init(width: 1.0, height: 0.0), color: UIColor.init(hex: "#B2B3B5"))
            
            
        }
    }
    
    private func initialViewSetup() {
        self.setBackground(color: .themeLightBackground)
        self.lblEmail?.setFont(name: FontName.Regular, size: FontSize.regular)
        self.lblMobile?.setFont(name: FontName.Regular, size: FontSize.regular)
        self.lblUserName?.setFont(name: FontName.SemiBold, size: FontSize.regular)
        self.lblDescription?.setFont(name: FontName.Regular, size: FontSize.regular)
        self.setUserData()
        self.setupTableView(tableView: self.tableView)
    }
    func setUserData() {
        self.lblEmail?.text = appSingleton.user.email
        self.lblMobile?.text = appSingleton.user.telNumber
        self.lblUserName?.text = appSingleton.user.name
        self.lblDescription?.text = "description goes here."//appSingleton.user.name
        if appSingleton.user.profilePhoto.isEmpty() {
                   self.ivUser.image = UIImage.init(named: ImageAsset.Placeholder.user)
        } else {
                   self.ivUser.downloadedFrom(link: appSingleton.user.profilePhoto)
        }
    }
    // MARK: - Action Methods
    @IBAction func btnMenuTapped(_ sender: Any) {
        
    }
    @IBAction func btnCancelTapped(_ sender: Any) {
        self.revealViewController()?.revealRightView()
    }
}


extension ProfileVC: UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate {
    
    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        self.scrVw.delegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        tableView.register(ProfileTblCell.nib()
            , forCellReuseIdentifier: ProfileTblCell.name)
        tableView.tableFooterView = UIView()
        self.updateHeaderView()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateHeaderView()
    }
    
    func updateHeaderView() {
        
        if self.scrVw.contentOffset.y < -20 {
            let y = abs(self.scrVw.contentOffset.y)
            let transLation = y/kTableHeaderHeight
            self.tableView.isScrollEnabled = false
            headerView.alpha = transLation
            headerView.transform = CGAffineTransform.init(scaleX: transLation, y: transLation)
            
        } else {
            headerView.alpha = 0.0
            self.tableView.isScrollEnabled = true
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrForMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTblCell.name, for: indexPath) as?  ProfileTblCell
        cell?.layoutIfNeeded()
        cell?.setData(data: arrForMenu[indexPath.row])
        cell?.layoutIfNeeded()
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return tableView.frame.width * 0.2
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedType = arrForMenu[indexPath.row].type
        switch selectedType {
        case .MyProfile:
            Common.appDelegate.loadEditProfileVC(navigaionVC: self.navigationController)
            print("")
        case .MyBookings:
            Common.appDelegate.loadBookingListVC(navigaionVC: self.navigationController)
        case .MyWorkingSchedule:
            print("")
        case .MyAvailability:
            print("")
        case .MyMissingDays:
            print("")
        case .MyRating:
            print("")
        case .MyNumberOfMassages:
            print("")
        case .PaymentPreference:
            print("")
        case .Logout:
            Common.appDelegate.loadLoginVC()
        }

    }
}

