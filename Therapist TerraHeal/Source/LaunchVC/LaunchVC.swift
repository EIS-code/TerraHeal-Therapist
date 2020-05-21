//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit

class LaunchVC: MainVC {
    
    @IBOutlet weak var ivLogo: UIImageView!
    @IBOutlet weak var lblLogo: ThemeLabel!

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblLogo.setFont(name: FontName.GradDuke, size: FontSize.label_14)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.ivLogo?.setRound()
    }

    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
            if PreferenceHelper.shared.getUserId().isEmpty() {
                if PreferenceHelper.shared.getIsShowTutorial() {
                    Common.appDelegate.loadTutoraiVC()
                } else {
                    Common.appDelegate.loadLoginVC()
                }
            }
            else {
                Singleton.loadFrombDB()
                Common.appDelegate.loadTherapistKycVC()
            }
        }
    }
    // MARK: - StatusBar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
