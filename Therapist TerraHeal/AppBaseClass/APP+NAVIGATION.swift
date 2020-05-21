//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import Foundation
import UIKit


// MARK: - NAVIGATION
extension AppDelegate {

    func loadLaunchVC() {
        if let launchVc: LaunchVC = Bundle.main.loadNibNamed(LaunchVC.name, owner: nil, options: nil)?.first as? LaunchVC{
            self.windowConfig(withRootVC: launchVc)
        }
    }

    func loadHomeVC() {
        let targetVc: HomeVC = HomeVC.fromNib()
        let nC: NC = NC(rootViewController: targetVc)
        self.windowConfig(withRootVC: nC)
    }

    func loadTutoraiVC(navigaionVC:UINavigationController? = nil) {

        if let nc = navigaionVC as? NC {
            if let targetVC: TutorialVC =  nc.findVCs(ofType: TutorialVC.self).first {
                _ = nc.popToViewController(targetVC, animated: true)
            } else {
                let targetVC: TutorialVC = TutorialVC.fromNib()
                nc.pushViewController(targetVC, animated: true)
            }
        } else {
            let targetVC: TutorialVC = TutorialVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }



    }

    func loadRegisterVC(navigaionVC:UINavigationController? = nil) {
        PreferenceHelper.shared.setUserId("")
        PreferenceHelper.shared.setSessionToken("")
        if let nc = navigaionVC as? NC {
            if let targetVC: RegisterVC =  nc.findVCs(ofType: RegisterVC.self).first {
                _ = nc.popToViewController(targetVC, animated: true)
            } else {
                let targetVC: RegisterVC = RegisterVC.fromNib()
                nc.pushViewController(targetVC, animated: true)
            }
        } else {
            let targetVC: RegisterVC = RegisterVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }

    }

    func loadLoginVC(navigaionVC:UINavigationController? = nil) {

        PreferenceHelper.shared.setUserId("")
        PreferenceHelper.shared.setSessionToken("")
        if let nc = navigaionVC as? NC {
            if let targetVC: LoginVC =  nc.findVCs(ofType: LoginVC.self).first {
                _ = nc.popToViewController(targetVC, animated: true)
            } else {
                let targetVC: LoginVC = LoginVC.fromNib()
                nc.pushViewController(targetVC, animated: true)
            }
        } else {
            let targetVC: LoginVC = LoginVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }
    func loadTouchIdVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: TouchIdVC =  nc.findVCs(ofType: TouchIdVC.self).first {
                _ = nc.popToViewController(targetVC, animated: true)
            } else {
                let targetVC: TouchIdVC = TouchIdVC.fromNib()
                nc.pushViewController(targetVC, animated: true)
            }
        } else {
            let targetVC: TouchIdVC = TouchIdVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }

    func loadContactVerificationVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: ContactVerificationVC =  nc.findVCs(ofType: ContactVerificationVC.self).first {
                _ = nc.popToViewController(targetVC, animated: true)
            } else {
                let targetVC: ContactVerificationVC = ContactVerificationVC.fromNib()
                nc.pushViewController(targetVC, animated: true)
            }
        } else {
            let targetVC: ContactVerificationVC = ContactVerificationVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }



    func loadAddCardVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: AddCardVC =  nc.findVCs(ofType: AddCardVC.self).first {
                _ = nc.popToViewController(targetVC, animated: true)
            } else {
                let targetVC: AddCardVC = AddCardVC.fromNib()
                nc.pushViewController(targetVC, animated: true)
            }
        } else {
            let targetVC: AddCardVC = AddCardVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }

   
//MARK: - Therapist Application
    func loadTherapistKycVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: TherapistKycVC =  nc.findVCs(ofType: TherapistKycVC.self).first {
                _ = nc.popToViewController(targetVC, animated: true)
            } else {
                let targetVC: TherapistKycVC = TherapistKycVC.fromNib()
                nc.pushViewController(targetVC, animated: true)
            }
        } else {
            let targetVC: TherapistKycVC = TherapistKycVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }

    func loadTherapistKycInfoVC(navigaionVC:UINavigationController? = nil) {
        AppWebApi.getUserDetail { (response) in
            Loader.hideLoading()
            let model: ResponseModel = ResponseModel.init(fromDictionary: response.toDictionary())
            if ResponseModel.isSuccess(response: model, withSuccessToast: false, andErrorToast: false) {
                if let user = response.data.first {
                    PreferenceHelper.shared.setUserId(user.id)
                    //PreferenceHelper.shared.setSessionToken(user.token)
                    appSingleton.user = user
                    Singleton.saveInDb()
                    if let nc = navigaionVC as? NC {
                        if let targetVC: TherapistKycInfoVC =  nc.findVCs(ofType: TherapistKycInfoVC.self).first {
                            _ = nc.popToViewController(targetVC, animated: true)
                        } else {
                            let targetVC: TherapistKycVC = TherapistKycInfoVC.fromNib()
                            nc.pushViewController(targetVC, animated: true)
                        }
                    } else {
                        let targetVC: TherapistKycInfoVC = TherapistKycInfoVC.fromNib()
                        let nC: NC = NC(rootViewController: targetVC)
                        self.windowConfig(withRootVC: nC)
                    }
                }

            }


        }


    }


    func loadIdentityVerificationInstructionVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: IdentityVerificationInstructionVC =  nc.findVCs(ofType: IdentityVerificationInstructionVC.self).first {
                _ = nc.popToViewController(targetVC, animated: true)
            } else {
                let targetVC: IdentityVerificationInstructionVC = IdentityVerificationInstructionVC.fromNib()
                nc.pushViewController(targetVC, animated: true)
            }
        } else {
            let targetVC: IdentityVerificationInstructionVC = IdentityVerificationInstructionVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }


    func loadPaymentAccountVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: PaymentAccountVC =  nc.findVCs(ofType: PaymentAccountVC.self).first {
                _ = nc.popToViewController(targetVC, animated: true)
            } else {
                let targetVC: PaymentAccountVC = PaymentAccountVC.fromNib()
                nc.pushViewController(targetVC, animated: true)
            }
        } else {
            let targetVC: PaymentAccountVC = PaymentAccountVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }

    func loadTherapistProfileVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: TherapistProfileVC =  nc.findVCs(ofType: TherapistProfileVC.self).first {
                _ = nc.popToViewController(targetVC, animated: true)
            } else {
                let targetVC: TherapistProfileVC = TherapistProfileVC.fromNib()
                nc.pushViewController(targetVC, animated: true)
            }
        } else {
            let targetVC: TherapistProfileVC = TherapistProfileVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }

    func windowConfig(withRootVC rootVC: UIViewController?) {
        DispatchQueue.main.async {
            self.window?.clean()
            self.window?.rootViewController?.clean()
            
            self.window?.rootViewController = rootVC
            self.window?.makeKeyAndVisible()
        }
    }

}

