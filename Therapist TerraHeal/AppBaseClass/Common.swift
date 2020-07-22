//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import Foundation
import UIKit

class Common: NSObject {

    static let screenRect: CGRect = UIScreen.main.bounds
    static let screenScale: CGFloat = UIScreen.main.scale
    static let screenH568: Bool = Common.screenRect.height <= 568.0
    static let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

    static let nCd: NotificationCenter = NotificationCenter.default
    static let defaultNtf: Notification = Notification(name: Notification.Name("defaultNtf"))
    static let locationUpdateNtfNm: Notification.Name = Notification.Name(rawValue: "locationUpdateNtfNm")
    static let locationFailNtfNm: Notification.Name = Notification.Name(rawValue: "locationFailNtfNm")

    static func showAlert(message:String) {
        let alert: CustomAlert = CustomAlert.fromNib()
        alert.initialize(message: message)
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert] in
            alert?.dismiss();
        }
    }

    static func showServerValidationAlert(message:String) {
        if message.isEmpty() {
            return;
        }
        let alert: CustomAlert = CustomAlert.fromNib()
        alert.initialize(message: message)
        alert.lblMessage.textColor = UIColor.red
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert] in
            alert?.dismiss();
        }
    }

    static func showSucessAlert(message:String) {
        if message.isEmpty() {
            return;
        }
        let alert: CustomAlert = CustomAlert.fromNib()
        alert.initialize(message: message)
        alert.lblMessage.textColor = UIColor.green
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert] in
            alert?.dismiss();
        }
    }
    
}




