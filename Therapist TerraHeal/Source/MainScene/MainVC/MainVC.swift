//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit



class MainVC: BaseVC, PBRevealViewControllerDelegate {
    
    @IBOutlet weak var btnProfile: FloatingRoundButton!
    @IBOutlet weak var btnMenu: FloatingRoundButton!
    @IBOutlet weak var vwFloatingBottom: HomeSegmentedControl!
    @IBOutlet weak var ivUser: RoundedImageView!

    @IBOutlet weak var bookingView: UIView!
    @IBOutlet weak var newsView: UIView!
    @IBOutlet weak var calendarView: UIView!

    var homeVC: HomeVC? = nil
    var calendarVC: CalendarGraphVC? = nil
    var newsVC: NewsVC? = nil

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
        self.ivUser?.downloadedFrom(link: appSingleton.user.profilePhoto)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if self.isViewAvailable() {
            vwFloatingBottom.setRound(withBorderColor: .clear, andCornerRadious: self.vwFloatingBottom.bounds.height/2.0, borderWidth: 0.1)
            vwFloatingBottom.setHomeBottomMenuShadow()
        }
    }
    
    private func initialViewSetup() {
        
        self.lblTitle?.setFont(name: FontName.Bold, size: FontSize.large)
        self.setNavigationTitle(title: "".localized())
        
        self.bookingView.isHidden = false
        self.newsView.isHidden = true
        self.calendarView.isHidden = true
        if homeVC == nil {
            homeVC = HomeVC.fromNib()
        }
        self.add(homeVC!, view:self.bookingView)
        vwFloatingBottom.allowChangeThumbWidth = false
        vwFloatingBottom.itemTitles = ["HOME_BTN_CALENDER".localized(),"HOME_BTN_BOOKING".localized(),"HOME_BTN_NEWS".localized()]

        self.revealViewController()?.delegate = homeVC
        vwFloatingBottom.itemImages =  [
            ImageAsset.getImage(ImageAsset.BottomMenu.calender)!,
            ImageAsset.getImage(ImageAsset.BottomMenu.booking)!,
            ImageAsset.getImage(ImageAsset.BottomMenu.news)!]
        vwFloatingBottom.itemSelectedImages = [
        ImageAsset.getImage(ImageAsset.BottomMenu.Selected.calender)!,
        ImageAsset.getImage(ImageAsset.BottomMenu.Selected.booking)!,
        ImageAsset.getImage(ImageAsset.BottomMenu.Selected.news)!]

        vwFloatingBottom.changeThumbColor(UIColor.themeSecondary)
        vwFloatingBottom.changeBackgroundColor(UIColor.themeLightTextColor)
        vwFloatingBottom.didSelectItemWith = { [weak self] (index,title) in
            guard let self = self else { return } ; print(self)
            switch index {
            case 0:
                self.calendarSelected()
            case 1:
                self.homeSelected()
            default:
                self.newsSelected()
                //Common.appDelegate.loadAddObservationVC(navigaionVC: self.navigationController)
            }
        }
        self.vwFloatingBottom.selectItemAt(index: 1)
        self.btnMenu.addTarget(self.revealViewController(), action: #selector(PBRevealViewController.revealLeftView), for: .touchUpInside)
        self.btnProfile.addTarget(self.revealViewController(), action: #selector(PBRevealViewController.revealRightView), for: .touchUpInside)
    }

    func newsSelected() {
        if newsVC == nil {
            newsVC = NewsVC.fromNib()
        }
        newsVC?.isHideNavigationBar = true
        self.add(newsVC!, view:self.newsView)
        self.bookingView.gone()
        self.calendarView.gone()
        self.newsView.visible()
        self.homeVC?.removeFromParent()
        self.calendarVC?.removeFromParent()
    }

    func homeSelected() {
        if homeVC == nil {
            homeVC = HomeVC.fromNib()
        }
        self.add(homeVC!, view:self.bookingView)
        self.calendarView.gone()
        self.newsView.gone()
        self.bookingView.visible()
        self.newsVC?.removeFromParent()
        self.calendarVC?.removeFromParent()

    }
    func calendarSelected() {
        if calendarVC == nil {
            calendarVC = CalendarGraphVC.fromNib()
        }
        self.add(calendarVC!, view:self.calendarView)
        self.bookingView.gone()
        self.newsView.gone()
        self.calendarView.visible()
        self.newsVC?.removeFromParent()
        self.homeVC?.removeFromParent()
    }
    func revealControllerTapGestureShouldBegin(_ revealController: PBRevealViewController) -> Bool {
        return false
    }
}


