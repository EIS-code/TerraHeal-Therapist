//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit



class MainVC: BaseVC {
    
    @IBOutlet weak var btnProfile: FloatingRoundButton!
    @IBOutlet weak var btnMenu: FloatingRoundButton!
    @IBOutlet weak var vwFloatingBottom: HomeSegmentedControl!
    @IBOutlet weak var ivUser: RoundedImageView!

    @IBOutlet weak var bookingView: UIView!
    @IBOutlet weak var newsView: UIView!
    @IBOutlet weak var calendarView: UIView!

    var homeVC: HomeVC? = nil
    var calendarVC: HomeVC? = nil
    var newsVC: HomeVC? = nil

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
            vwFloatingBottom.setRound(withBorderColor: .clear, andCornerRadious: self.vwFloatingBottom.bounds.height/2.0, borderWidth: 0.1)
            vwFloatingBottom.setHomeBottomMenuShadow()
        }
    }
    
    private func initialViewSetup() {
        
        self.lblTitle?.setFont(name: FontName.Bold, size: FontSize.large)
        self.setTitle(title: "".localized())
        
        self.bookingView.isHidden = false
        self.newsView.isHidden = true
        self.calendarView.isHidden = true
        if homeVC == nil {
            homeVC = HomeVC.fromNib()
        }
        self.add(homeVC!, view:self.bookingView)
        vwFloatingBottom.allowChangeThumbWidth = false
        vwFloatingBottom.itemTitles = ["HOME_BTN_CALENDER".localized(),"HOME_BTN_BOOKING".localized(),"HOME_BTN_NEWS".localized()]
        vwFloatingBottom.itemImages =  [UIImage.init(named: "asset-home-tab-news")!, UIImage.init(named: "asset-home-tab-news")!, UIImage.init(named: "asset-home-tab-news")!]
        vwFloatingBottom.itemSelectedImages = [UIImage.init(named: "asset-home-tab-news-selected")!, UIImage.init(named: "asset-home-tab-news-selected")!,UIImage.init(named: "asset-home-tab-news-selected")!]
        vwFloatingBottom.changeThumbColor(UIColor.themeSecondary)
        vwFloatingBottom.changeBackgroundColor(UIColor.themeLightTextColor)
        vwFloatingBottom.didSelectItemWith = { [weak self] (index,title) in
            guard let self = self else { return } ; print(self)
            switch index {
            case 0:
                print("")
                //self.homeButtonSelected()
            case 1:
                print("")
                //self.exploreButtonSelected()
            default:
                print("")
                //self.favouriteButtonSelected()
            }
        }
        self.btnMenu.addTarget(self.revealViewController(), action: #selector(PBRevealViewController.revealLeftView), for: .touchUpInside)
    }
}


