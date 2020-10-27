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
        let rightVC: NC = NC(rootViewController: ProfileVC.fromNib())
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

    func loadNotificationVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: NotificationVC =  nc.findVCs(ofType: NotificationVC.self).first {
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: NotificationVC = NotificationVC.fromNib()
                nc.pushVC(targetVC)
            }
        } else {
            let targetVC: NotificationVC = NotificationVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }

    func loadSuggestionVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: SuggestionAndComplaintVC =  nc.findVCs(ofType: SuggestionAndComplaintVC.self).first {
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: SuggestionAndComplaintVC = SuggestionAndComplaintVC.fromNib()
                nc.pushVC(targetVC)
            }
        } else {
            let targetVC: SuggestionAndComplaintVC = SuggestionAndComplaintVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }
    func loadRateVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: RateVC =  nc.findVCs(ofType: RateVC.self).first {
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: RateVC = RateVC.fromNib()
                nc.pushVC(targetVC)
            }
        } else {
            let targetVC: RateVC = RateVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }
    func loadNewsVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: NewsVC =  nc.findVCs(ofType: NewsVC.self).first {
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: NewsVC = NewsVC.fromNib()
                nc.pushVC(targetVC)
            }
        } else {
            let targetVC: NewsVC = NewsVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }
    func loadBookingDetailVC(navigaionVC:UINavigationController? = nil, completion: (BookingDetailVC) -> Void) {
        if let nc = navigaionVC as? NC {
            if let targetVC: BookingDetailVC =  nc.findVCs(ofType: BookingDetailVC.self).first {
                _ = nc.popToVc(targetVC)
                completion(targetVC)
            } else {
                let targetVC: BookingDetailVC = BookingDetailVC.fromNib()
                nc.pushVC(targetVC)
                completion(targetVC)
            }
        } else {
            let targetVC: BookingDetailVC = BookingDetailVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
            completion(targetVC)
        }
    }

    func loadCameraVC(navigaionVC:UINavigationController? = nil) -> CameraVC {
        if let nc = navigaionVC as? NC {
            if let targetVC: CameraVC =  nc.findVCs(ofType: CameraVC.self).first {
                _ = nc.popToVc(targetVC)
                return targetVC
            } else {
                let targetVC: CameraVC = CameraVC.fromNib()
                nc.pushVC(targetVC)
                return targetVC
            }
        } else {
            let targetVC: CameraVC = CameraVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
            return targetVC
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

    func loadEditProfileVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: EditProfileVC =  nc.findVCs(ofType: EditProfileVC.self).first {
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: EditProfileVC = EditProfileVC.fromNib()
                nc.pushVC(targetVC)
            }
        } else {
            let targetVC: EditProfileVC = EditProfileVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }

    func loadServiceNavigationVC(navigaionVC:UINavigationController? = nil, completion: (ServiceNavigationVC) -> Void) {
        if let nc = navigaionVC as? NC {
            if let targetVC: ServiceNavigationVC =  nc.findVCs(ofType: ServiceNavigationVC.self).first {
                _ = nc.popToVc(targetVC)
                completion(targetVC)

            } else {
                let targetVC: ServiceNavigationVC = ServiceNavigationVC.fromNib()
                nc.pushVC(targetVC)
                completion(targetVC)

            }
        } else {
            let targetVC: ServiceNavigationVC = ServiceNavigationVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
            completion(targetVC)
        }
    }

    func loadMyDocumentsVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: MyDocumentsVC =  nc.findVCs(ofType: MyDocumentsVC.self).first {
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: MyDocumentsVC = MyDocumentsVC.fromNib()
                nc.pushVC(targetVC)
            }
        } else {
            let targetVC: MyDocumentsVC = MyDocumentsVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }

    func loadManageDocumentVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: ManageDocumentVC =  nc.findVCs(ofType: ManageDocumentVC.self).first {
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: ManageDocumentVC = ManageDocumentVC.fromNib()
                nc.pushVC(targetVC)
            }
        } else {
            let targetVC: ManageDocumentVC = ManageDocumentVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }

}

