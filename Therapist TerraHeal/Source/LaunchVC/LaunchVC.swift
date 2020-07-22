//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit

class LaunchVC: MainVC {
    
    // MARK: - Outlets
    @IBOutlet weak var ivLogo: UIImageView!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if self.isViewAvailable() {
         
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
        Common.appDelegate.loadLoginVC()
        //self.loadNextScreen()
    }
    // MARK: - StatusBar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    // MARK: - Other Functions
    fileprivate func loadNextScreen() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
            if !PreferenceHelper.shared.getUserId().isEmpty() {
                Common.appDelegate.loadHomeVC()
            } else {
                Common.appDelegate.loadLoginVC()
            }
        }
    }
}
