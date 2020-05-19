//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import Foundation
import UIKit
// import JDFramework

class Common: NSObject {

    static let screenRect: CGRect = UIScreen.main.bounds
    static let screenScale: CGFloat = UIScreen.main.scale
    static let screenH568: Bool = Common.screenRect.height <= 568.0
    static let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

    static func showAlert(message:String) {
        if message.isEmpty() {
            return;
        }
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




