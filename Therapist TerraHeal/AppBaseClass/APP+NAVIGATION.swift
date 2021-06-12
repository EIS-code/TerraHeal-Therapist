//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import Foundation
import UIKit
import Mantis

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
        if !PreferenceHelper.shared.getUserId().isEmpty() {
            self.loadMainVC(navigaionVC)
            AppWebApi.getUserDetail { (response) in
                Loader.hideLoading()
                if ResponseModel.isSuccess(response: response, withSuccessToast: false, andErrorToast: false) {
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
            self.loadLoginVC()
        }
        
    }
    func loadExchangeOfferVC(navigaionVC:UINavigationController? = nil, shiftData: RequestExchangeShift) {
        if let nc = navigaionVC as? NC {
            if let targetVC: ExchangeOfferVC =  nc.findVCs(ofType: ExchangeOfferVC.self).first {
                targetVC.selectedShiftForExchange = shiftData
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: ExchangeOfferVC = ExchangeOfferVC.fromNib()
                targetVC.selectedShiftForExchange = shiftData
                nc.pushVC(targetVC)
            }
        } else {
            let targetVC: ExchangeOfferVC = ExchangeOfferVC.fromNib()
            targetVC.selectedShiftForExchange = shiftData
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
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

    func loadExchangeOfferRequestVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: ExchangeOfferRequestVC =  nc.findVCs(ofType: ExchangeOfferRequestVC.self).first {
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: ExchangeOfferRequestVC = ExchangeOfferRequestVC.fromNib()
                nc.pushVC(targetVC)
            }
        } else {
            let targetVC: ExchangeOfferRequestVC = ExchangeOfferRequestVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }

    func loadAddObservationVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: AddObserverationVC =  nc.findVCs(ofType: AddObserverationVC.self).first {
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: AddObserverationVC = AddObserverationVC.fromNib()
                nc.pushVC(targetVC)
            }
        } else {
            let targetVC: AddObserverationVC = AddObserverationVC.fromNib()
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

    func loadMyRateVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: MyRateVC =  nc.findVCs(ofType: MyRateVC.self).first {
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: MyRateVC = MyRateVC.fromNib()
                nc.pushVC(targetVC)
            }
        } else {
            let targetVC: MyRateVC = MyRateVC.fromNib()
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

    func loadCameraVC(navigaionVC:UINavigationController? = nil, cameraData:CameraMessageInfo = CameraMessageInfo.init()) -> CameraVC {
        if let nc = navigaionVC as? NC {
            if let targetVC: CameraVC =  nc.findVCs(ofType: CameraVC.self).first {
                _ = nc.popToVc(targetVC)
                targetVC.cameraMessage = cameraData
                return targetVC
            } else {
                let targetVC: CameraVC = CameraVC.fromNib()
                targetVC.cameraMessage = cameraData
                nc.pushVC(targetVC)
                return targetVC
            }
        } else {
            let targetVC: CameraVC = CameraVC.fromNib()
            targetVC.cameraMessage = cameraData
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

    func loadManageDocumentVC(navigaionVC:UINavigationController? = nil, docType:DocumentType) {
        if let nc = navigaionVC as? NC {
            if let targetVC: ManageDocumentVC =  nc.findVCs(ofType: ManageDocumentVC.self).first {
                targetVC.selectedDocType = docType
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: ManageDocumentVC = ManageDocumentVC.fromNib()
                targetVC.selectedDocType = docType
                nc.pushVC(targetVC)
            }
        } else {
            let targetVC: ManageDocumentVC = ManageDocumentVC.fromNib()
            targetVC.selectedDocType = docType
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }

    func loadManageSingleDocumentVC(navigaionVC:UINavigationController? = nil, docType:DocumentType) {
        if let nc = navigaionVC as? NC {
            if let targetVC: ManageSingleDocumentVC =  nc.findVCs(ofType: ManageSingleDocumentVC.self).first {
                targetVC.selectedDocType = docType
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: ManageSingleDocumentVC = ManageSingleDocumentVC.fromNib()
                targetVC.selectedDocType = docType
                nc.pushVC(targetVC)
            }
        } else {
            let targetVC: ManageSingleDocumentVC = ManageSingleDocumentVC.fromNib()
            targetVC.selectedDocType = docType
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }

    func loadManageIdPassportVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: ManageIdPassportVC =  nc.findVCs(ofType: ManageIdPassportVC.self).first {
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: ManageIdPassportVC = ManageIdPassportVC.fromNib()
                nc.pushVC(targetVC)
            }
        } else {
            let targetVC: ManageIdPassportVC = ManageIdPassportVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }

    func openImageCropper(vc: UIViewController & CropViewControllerDelegate, image:UIImage? = nil) {
        if image == nil {
            Common.showAlert(message: "Image not found")
        } else {
            if let nc = vc.navigationController as? NC {
                if let targetVC: CropViewController =  nc.findVCs(ofType: CropViewController.self).first {
                    targetVC.delegate = vc
                    _ = nc.popToVc(targetVC)
                } else {
                    let targetVC = Mantis.cropViewController(image: image!)
                    targetVC.delegate = vc
                    nc.pushVC(targetVC)
                }
            } else {
                let targetVC = Mantis.cropViewController(image: image!)
                targetVC.delegate = vc
                let nC: NC = NC(rootViewController: targetVC)
                self.windowConfig(withRootVC: nC)
            }
        }

    }


    func loadBookingListVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: BookingListVC =  nc.findVCs(ofType: BookingListVC.self).first {
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: BookingListVC = BookingListVC.fromNib()
                nc.pushVC(targetVC)
            }
        } else {
            let targetVC: BookingListVC = BookingListVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }

    func loadWorkingScheduleVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: WorkingScheduleVC =  nc.findVCs(ofType: WorkingScheduleVC.self).first {
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: WorkingScheduleVC = WorkingScheduleVC.fromNib()
                nc.pushVC(targetVC)
            }
        } else {
            let targetVC: WorkingScheduleVC = WorkingScheduleVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }

    func loadMissingDaysVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: MissingDaysVC =  nc.findVCs(ofType: MissingDaysVC.self).first {
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: MissingDaysVC = MissingDaysVC.fromNib()
                nc.pushVC(targetVC)
            }
        } else {
            let targetVC: MissingDaysVC = MissingDaysVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }

    func loadMyNumberOfMassageVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: MassageListVC =  nc.findVCs(ofType: MassageListVC.self).first {
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: MassageListVC = MassageListVC.fromNib()
                nc.pushVC(targetVC)
            }
        } else {
            let targetVC: MassageListVC = MassageListVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }

    func loadMassageDetailVC(navigaionVC:UINavigationController? = nil, bookingDetail: BookingDetail) {
        if let nc = navigaionVC as? NC {
            if let targetVC: MassageDetailVC =  nc.findVCs(ofType: MassageDetailVC.self).first {
                targetVC.bookingDetail = bookingDetail
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: MassageDetailVC = MassageDetailVC.fromNib()
                targetVC.bookingDetail = bookingDetail
                nc.pushVC(targetVC)
            }
        } else {
            let targetVC: MassageDetailVC = MassageDetailVC.fromNib()
            targetVC.bookingDetail = bookingDetail
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }
    func loadAvailabilityVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: AvailabilityVC =  nc.findVCs(ofType: AvailabilityVC.self).first {
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: AvailabilityVC = AvailabilityVC.fromNib()
                nc.pushVC(targetVC)
            }
        } else {
            let targetVC: AvailabilityVC = AvailabilityVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }
    func loadAddCardVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: AddCardVC =  nc.findVCs(ofType: AddCardVC.self).first {
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: AddCardVC = AddCardVC.fromNib()
                nc.pushVC(targetVC)
            }
        } else {
            let targetVC: AddCardVC = AddCardVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }
    func loadPaymentReferenceVC(amount: Double, navigaionVC:UINavigationController? = nil, fromVC: BaseVC?) {
        if let nc = navigaionVC as? NC {
            if let targetVC: PaymentPreferenceVC =  nc.findVCs(ofType: PaymentPreferenceVC.self).first {
                targetVC.amount = amount
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: PaymentPreferenceVC = PaymentPreferenceVC.fromNib()
                targetVC.comeFromVC = fromVC
                targetVC.amount = amount
                nc.pushVC(targetVC)
            }
        } else {
            let targetVC: PaymentPreferenceVC = PaymentPreferenceVC.fromNib()
            targetVC.amount = amount
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }

    func loadScanVC(navigaionVC:UINavigationController? = nil, completion: (ScanVC) -> Void) {
        if let nc = navigaionVC as? NC {
            if let targetVC: ScanVC =  nc.findVCs(ofType: ScanVC.self).first {
                _ = nc.popToVc(targetVC)
                completion(targetVC)

            } else {
                let targetVC: ScanVC = ScanVC.fromNib()
                nc.pushVC(targetVC)
                completion(targetVC)
            }
        } else {
            let targetVC: ScanVC = ScanVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
            completion(targetVC)
        }
    }
}

