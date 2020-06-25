//
//  Created by Jaydeep on 21/09/19.
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import Foundation
import Alamofire

typealias API_URL = AppWebApi.URL
typealias API_ERROR_CODE = AppWebApi.ErrorCode

//MARK: WEb Urls
class AppWebApi: NSObject {

    struct URL {

        private struct Domains {
            static let Dev = "http://35.180.253.133"
            static let Production = "http://35.180.253.133"
            static let Local = "http://35.180.253.133"

        }

        private  struct Routes {
            static let Client = "/api/therapist"
            static let Massage = "/api/massage"
            static let Therapy = "/api/therapy"
            static let Exception = "/api/error"

        }

        private  static let Domain = Domains.Production


        static var UserLogin: String {
            return Domain + Routes.Client  + "/signin"
        }
        static var UserLogout: String {
            return Domain + Routes.Client  + "/logout"
        }
        static var UserRegister: String {
            return Domain + Routes.Client + "/signup"
        }
        static var UserProfile: String {
            return Domain + Routes.Client + "/profile/update/" + PreferenceHelper.shared.getUserId()
        }
        static var UploadDocument: String {
            return Domain + Routes.Client + "/documents/" + PreferenceHelper.shared.getUserId()
        }

        static var VerifyEmail: String {
            return Domain + Routes.Client + "/verify/email/" + PreferenceHelper.shared.getUserId()
        }
        static var VerifyPhone: String {
            return Domain + Routes.Client + "/verify/mobile/" + PreferenceHelper.shared.getUserId()
        }
        static var VerifyEmailOTP: String {
            return Domain + Routes.Client + "/compare/otp/email/" + PreferenceHelper.shared.getUserId()
        }
        static var VerifyPhoneOTP: String {
            return Domain + Routes.Client + "/compare/otp/mobile/" + PreferenceHelper.shared.getUserId()
        }
        static var GetUserDetail:  String {
            return Domain + Routes.Client + "/get/" + PreferenceHelper.shared.getUserId()
        }
        static var CheckExeption: String {
            return Domain + Routes.Exception
        }

        static var GetMassageList: String {
            return Domain + Routes.Massage + "/get"
        }
        static var GetTherapyList: String {
            return Domain + Routes.Therapy + "/get"
        }

    }
}

//MARK: Known Error Codes

extension AppWebApi {

    struct ErrorCode {
        static let InvalidServerToken: String = "ERROR_12"
        static let DetailNotFound: String = "ERROR_13"
    }
}


extension AppWebApi {

    class func login(params:User.RequestLogin, completionHandler: @escaping ((User.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.UserLogin, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = User.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }

    class func getUserDetail(completionHandler: @escaping ((User.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.GetUserDetail, methodName: AlamofireHelper.GET_METHOD, paramData:[:]) { (data, dictionary, error) in
            let response = User.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }


    class func register(params:User.RequestRegister, completionHandler: @escaping ((User.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.UserRegister, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = User.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }

    class func getEmailOtp(params:User.RequestEmailOTP, completionHandler: @escaping ((User.ResponseVerification) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.VerifyEmail, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = User.ResponseVerification.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }

    class func getPhoneOtp(params:User.RequestPhoneOTP, completionHandler: @escaping ((User.ResponseVerification) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.VerifyPhone, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = User.ResponseVerification.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }

    class func verifyEmailOtp(params:User.RequestVerifyEmailOTP, completionHandler: @escaping ((User.ResponseVerification) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.VerifyEmailOTP, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = User.ResponseVerification.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }

    class func verifyPhoneOtp(params:User.RequestVerifyPhoneOTP, completionHandler: @escaping ((User.ResponseVerification) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.VerifyPhoneOTP, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = User.ResponseVerification.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }

    class func profile(params:User.RequestProfile, image:UploadDocumentDetail? = nil, paramName:String = "profile_photo", completionHandler: @escaping ((User.Response) -> Void)) {


        if let imageToUpload = image {
            AlamofireHelper().uploadDocumentToURL(urlString:AppWebApi.URL.UserProfile , paramData: params.dictionary, documents: [imageToUpload],paramName: paramName)  { (data, dictionary, error) in
                let response = User.Response.init(fromDictionary: dictionary)
                completionHandler(response)
            }
        } else {
            AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.UserProfile, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
                let response = User.Response.init(fromDictionary: dictionary)
                completionHandler(response)
            }
        }
    }


    class func uploadDocument(params:User.RequestUploadDocument, documents:[UploadDocumentDetail],paramName:String = "file", completionHandler: @escaping ((User.ResponseVerification) -> Void)) {
        AlamofireHelper().uploadDocumentToURL(urlString:AppWebApi.URL.UploadDocument , paramData: params.dictionary, documents: documents, paramName: paramName)  { (data, dictionary, error) in
            let response = User.ResponseVerification.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }



    class func exception(params:[String:String], completionHandler: @escaping ((User.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.CheckExeption, methodName: AlamofireHelper.GET_METHOD, paramData:[:]) { (data, dictionary, error) in
            let response = User.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }

    class func massageList(params:Massage.RequestMassages, completionHandler: @escaping ((Massage.ResponseMassageList) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.GetMassageList, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = Massage.ResponseMassageList.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }

    class func therapyList(params:Therapy.RequestTherapy, completionHandler: @escaping ((Therapy.ResponseTherapyList) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.GetTherapyList, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = Therapy.ResponseTherapyList.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }

}
