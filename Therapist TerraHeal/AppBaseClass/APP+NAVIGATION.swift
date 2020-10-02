//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import Foundation
import UIKit


// MARK: - NAVIGATION
extension AppDelegate {
    
    func windowConfig(withRootVC rootVC: UIViewController?) {
        DispatchQueue.main.async {
            self.window?.clean()
            self.window?.rootViewController?.clean()
            self.window?.rootViewController = rootVC
            self.window?.makeKeyAndVisible()
        }
    }
    
    func loadLaunchVC() {
        if let launchVc: LaunchVC = Bundle.main.loadNibNamed(LaunchVC.name, owner: nil, options: nil)?.first as? LaunchVC{
            self.windowConfig(withRootVC: launchVc)
        }
    }
    
    func loadLoginVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: LoginVC =  nc.findVCs(ofType: LoginVC.self).first {
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: LoginVC = LoginVC.fromNib()
                nc.pushVC(targetVC)
            }
        } else {
            let targetVC: LoginVC = LoginVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }
    

    fileprivate func loadMainVC(_ navigaionVC: UINavigationController?) {
        let mainVC: NC = NC(rootViewController: MainVC.fromNib())
        let leftVC: NC = NC(rootViewController: SideVC.fromNib())
        let rightVC: NC = NC(rootViewController: SideVC.fromNib())
        let targetVC = PBRevealViewController.init(leftViewController: leftVC, mainViewController: mainVC, rightViewController: rightVC)
               self.windowConfig(withRootVC: targetVC)
    }
    
    
    
    
    func loadMainVC(navigaionVC:UINavigationController? = nil) {
        loadMainVC(navigaionVC)
        /*
        if !PreferenceHelper.shared.getUserId().isEmpty() {
            AppWebApi.getUserDetail { (response) in
                Loader.hideLoading()
                let model: ResponseModel = ResponseModel.init(fromDictionary: response.toDictionary())
                if ResponseModel.isSuccess(response: model, withSuccessToast: false, andErrorToast: false) {
                    let user = response.data
                    PreferenceHelper.shared.setUserId(user.id)
                    appSingleton.user = user
                    Singleton.saveInDb()
                    self.loadMainVC(navigaionVC)
                } else {
                    self.loadMainVC(navigaionVC)
                }
            }
        } else {
            loadMainVC(navigaionVC)
        }*/
        
    }
    
}

