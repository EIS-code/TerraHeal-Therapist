//
//  VerificationWebService.swift
//  Therapist TerraHeal
//
//  Created by Jaydeep Vyas on 19/05/21.
//  Copyright © 2021 Evolution. All rights reserved.
//

import Foundation

//MARK: Request Models
class VerificationWebService {
    static let url: String = API_URL.ForgotPassword
    struct RequestPhoneOTP: Codable {
        var therapist_id: String = PreferenceHelper.shared.getUserId()
        var mobile: String = ""
        var device_token: String = PreferenceHelper.shared.getDeviceToken()
        var device_type: String = Constant.typeIOS
        var app_version: String = Bundle.appVesion
    }

    struct RequestVerifyPhoneOTP: Codable {
        var therapist_id: String = PreferenceHelper.shared.getUserId()
        var otp: String = ""
        var device_token: String = PreferenceHelper.shared.getDeviceToken()
        var device_type: String = Constant.typeIOS
        var app_version: String = Bundle.appVesion
    }
    struct RequestEmailOTP: Codable {
        var therapist_id: String = PreferenceHelper.shared.getUserId()
        var email: String = ""
        var device_token: String = PreferenceHelper.shared.getDeviceToken()
        var device_type: String = Constant.typeIOS
        var app_version: String = Bundle.appVesion
    }

    struct RequestVerifyEmailOTP: Codable {
        var therapist_id: String = PreferenceHelper.shared.getUserId()
        var otp: String = ""
        var device_token: String = PreferenceHelper.shared.getDeviceToken()
        var device_type: String = Constant.typeIOS
        var app_version: String = Bundle.appVesion
    }

}

//MARK: Response Models
extension VerificationWebService {
    class ResponseVerification :  ResponseModel {
        override init(fromDictionary dictionary: [String:Any]) {
            super.init(fromDictionary: dictionary)
        }
    }
}

//MARK: Web Service Calls
extension VerificationWebService {
    class func getEmailOtp(params:VerificationWebService.RequestEmailOTP, completionHandler: @escaping ((VerificationWebService.ResponseVerification) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.VerifyEmail, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = VerificationWebService.ResponseVerification.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    class func getPhoneOtp(params:VerificationWebService.RequestPhoneOTP, completionHandler: @escaping ((VerificationWebService.ResponseVerification) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.VerifyPhone, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = VerificationWebService.ResponseVerification.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    class func verifyEmailOtp(params:VerificationWebService.RequestVerifyEmailOTP, completionHandler: @escaping ((VerificationWebService.ResponseVerification) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.VerifyEmailOTP, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = VerificationWebService.ResponseVerification.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    class func verifyPhoneOtp(params:VerificationWebService.RequestVerifyPhoneOTP, completionHandler: @escaping ((VerificationWebService.ResponseVerification) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.VerifyPhoneOTP, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = VerificationWebService.ResponseVerification.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
}
