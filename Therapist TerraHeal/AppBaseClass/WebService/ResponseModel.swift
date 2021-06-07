//
//  ResponseModel.swift
//  Therapist TerraHeal
//
//  Created by Jaydeep on 18/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import Foundation

struct RequestCommon: Codable {
    var id: String = PreferenceHelper.shared.getUserId()
    var shop_id: String = appSingleton.user.shopId

}

class ResponseModel: NSObject {

    var success: String!
    var code: String!
    var message: String!
    var errorMessage: [String] = []
    var json: [String:Any] = [:]
    init(fromDictionary dictionary: [String:Any]){
        code = (dictionary["code"] as? String) ?? ""
        success = (dictionary["success"] as? String) ?? ""
        message = (dictionary["msg"] as? String) ?? ""
        if let arrForErrors = dictionary["msg"] as? [Any] {
            if let intError = arrForErrors as? [Int] {
                errorMessage = [(intError.first?.toString()) ?? ""]
            }
            else if let  strError = arrForErrors as? [String] {
                errorMessage = strError
            }

        }
        else {
            errorMessage = []
        }

        if message.isEmpty {
            if errorMessage.isEmpty {
                message = code
            } else {
                message = errorMessage.joined(separator: "\n")
            }
        }
    }

    class func isSuccess(response:ResponseModel, withSuccessToast:Bool = false, andErrorToast:Bool = true) -> Bool {


        if response.code == MessageCode.success {
            if withSuccessToast {
                DispatchQueue.main.async { /*[unowned isSuccess] in*/
                    Common.showSucessAlert(message: response.message)
                }
            }
            return true;
        }
        else if response.code == MessageCode.validationError{
            if andErrorToast {
                DispatchQueue.main.async {
                        Common.showServerValidationAlert(message: response.message)
                }
            }
            return false;
        }
        else {
            DispatchQueue.main.async {
                        Common.showAlert(message: response.message)
            }
            return false;
        }
    }
}
