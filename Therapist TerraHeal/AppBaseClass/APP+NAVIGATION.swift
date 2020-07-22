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
    
    func loadBookingDetailVC(navigaionVC:UINavigationController? = nil, isBookingFinished:Bool = false) {
        if let nc = navigaionVC as? NC {
            if let targetVC: BookingDetailVC =  nc.findVCs(ofType: BookingDetailVC.self).first {
                targetVC.isBookingFinished = isBookingFinished
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: BookingDetailVC = BookingDetailVC.fromNib()
                targetVC.isBookingFinished = isBookingFinished
                nc.pushVC(targetVC)
            }
        } else {
            let targetVC: BookingDetailVC = BookingDetailVC.fromNib()
            targetVC.isBookingFinished = isBookingFinished
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }
    
    func loadMapBookVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: MapBookVC =  nc.findVCs(ofType: MapBookVC.self).first {
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: MapBookVC = MapBookVC.fromNib()
                nc.pushVC(targetVC)
            }
        } else {
            let targetVC: MapBookVC = MapBookVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }
    
    func loadCameraVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: CameraVC =  nc.findVCs(ofType: CameraVC.self).first {
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: CameraVC = CameraVC.fromNib()
                nc.pushVC(targetVC)
            }
        } else {
            let targetVC: CameraVC = CameraVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }
    
    func loadServiceStatusVC(navigaionVC:UINavigationController? = nil) {
           if let nc = navigaionVC as? NC {
               if let targetVC: ServiceStatusVC =  nc.findVCs(ofType: ServiceStatusVC.self).first {
                   _ = nc.popToVc(targetVC)
               } else {
                   let targetVC: ServiceStatusVC = ServiceStatusVC.fromNib()
                   nc.pushVC(targetVC)
               }
           } else {
               let targetVC: ServiceStatusVC = ServiceStatusVC.fromNib()
               let nC: NC = NC(rootViewController: targetVC)
               self.windowConfig(withRootVC: nC)
           }
       }
    fileprivate func loadHomeVC(_ navigaionVC: UINavigationController?) {
        if let nc = navigaionVC as? NC {
            if let targetVC: HomeVC =  nc.findVCs(ofType: HomeVC.self).first {
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: HomeVC = HomeVC.fromNib()
                nc.pushVC(targetVC)
            }
        } else {
            let targetVC: HomeVC = HomeVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }
    
    
    
    
    func loadHomeVC(navigaionVC:UINavigationController? = nil) {
        
        if !PreferenceHelper.shared.getUserId().isEmpty() {
            AppWebApi.getUserDetail { (response) in
                Loader.hideLoading()
                let model: ResponseModel = ResponseModel.init(fromDictionary: response.toDictionary())
                if ResponseModel.isSuccess(response: model, withSuccessToast: false, andErrorToast: false) {
                    let user = response.data
                    PreferenceHelper.shared.setUserId(user.id)
                    appSingleton.user = user
                    Singleton.saveInDb()
                    self.loadHomeVC(navigaionVC)
                } else {
                    self.loadHomeVC(navigaionVC)
                }
            }
        } else {
            loadHomeVC(navigaionVC)
        }
    }
    
}

