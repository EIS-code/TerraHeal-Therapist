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
            static let Client = "/api/user"
            static let Setting = "/api/user/setting"
            static let Exception = "/api/error"
            static let Massage = "/api/massage"
            static let Location = "/api/location"
            static let Therapy = "/api/therapy"
            static let Address = "/api/user/address"
            static let People = "/api/user/people"
            
            
            
        }
        
        private  static let Domain = Domains.Production
        
        
        static var UserLogin: String {
            return Domain + Routes.Client  + "/signin"
        }
        
        static var UserRegister: String {
            return Domain + Routes.Client + "/signup"
        }
        static var UserProfile: String {
            return Domain + Routes.Client + "/profile/update"
        }
        
        static var UserLogout: String {
            return Domain + Routes.Setting  + "/logout"
            
        }
        
        static var ChangePassword: String {
                   return Domain + Routes.Setting + "/update/password"
        }
       
        static var SettingDetail: String {
                   return Domain + Routes.Setting + "/get"
        }
        
        static var UpdateSettingDetail: String {
                   return Domain + Routes.Setting + "/save"
        }
      
        static var UploadDocument: String {
            return Domain + Routes.Client + "/documents/" + PreferenceHelper.shared.getUserId()
        }
        
        static var VerifyEmail: String {
            return Domain + Routes.Client + "/verify/email"
        }
        static var VerifyPhone: String {
            return Domain + Routes.Client + "/verify/mobile"
        }
        static var VerifyEmailOTP: String {
            return Domain + Routes.Client + "/compare/otp/email"
        }
        static var VerifyPhoneOTP: String {
            return Domain + Routes.Client + "/compare/otp/mobile"
        }
        static var CheckExeption: String {
            return Domain + Routes.Exception
        }
        static var GetUserDetail: String {
            return  Domain + Routes.Client + "/get/" + PreferenceHelper.shared.getUserId()
        }
        static var GetCountryList: String {
            return Domain + Routes.Location + "/get/country"
        }
        static var GetCityList: String {
            return  Domain + Routes.Location + "/get/city"
        }
        static var GetLocationList: String {
            return  Domain + Routes.Location + "/get/province"
        }
        static var GetMassagePreferenceList: String {
            return  Domain + Routes.Massage + "/preference"
        }
        static var SaveMassagePreferenceList: String {
            return  Domain + Routes.Massage + "/preference/save"
        }
        static var TherapistQuesionaryList: String {
            return  Domain + Routes.Therapy + "/questionnaire"
        }
        static var SaveTherapistQuesionaryList: String {
            return  Domain + Routes.Therapy + "/questionnaire/save"
        }
        //Address APIs
        static var GetAddressList: String {
            return  Domain + Routes.Address + "/get"
        }
        static var RemoveAddress: String {
            return  Domain + Routes.Address + "/remove"
        }
        static var UpdateAddress: String {
            return  Domain + Routes.Address + "/update"
        }
        static var AddAddress: String {
            return  Domain + Routes.Address + "/save"
        }
        //Manage People APIs
        static var GetPeopleList: String {
            return  Domain + Routes.People + "/get"
        }
        static var RemovePeople: String {
            return  Domain + Routes.People + "/remove"
        }
        static var UpdatePeople: String {
            return  Domain + Routes.People + "/update"
        }
        static var AddPeople: String {
            return  Domain + Routes.People + "/save"
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
    
    
    class func uploadDocument(params:User.RequestUploadDocument, documents:[UploadDocumentDetail],paramName:String = "file", completionHandler: @escaping ((User.Response) -> Void)) {
        AlamofireHelper().uploadDocumentToURL(urlString:AppWebApi.URL.UploadDocument , paramData: params.dictionary, documents: documents, paramName: paramName)  { (data, dictionary, error) in
            let response = User.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    
    class func exception(params:[String:String], completionHandler: @escaping ((User.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.CheckExeption, methodName: AlamofireHelper.GET_METHOD, paramData:[:]) { (data, dictionary, error) in
            let response = User.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    
    class func countryList(params:Countries.RequestCountrylist = Countries.RequestCountrylist(), completionHandler: @escaping ((Countries.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.GetCountryList, methodName: AlamofireHelper.GET_METHOD, paramData: [:]) { (data, dictionary, error) in
            let response = Countries.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    
    
    
    class func cityList(params:Cities.RequestCitylist, completionHandler: @escaping ((Cities.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.GetCityList, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = Cities.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    
   
   
    //MARK:  Address Related APIS
    
    class func addAddress(params:Addresses.RequestAddAddress, completionHandler: @escaping ((Addresses.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.AddAddress, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = Addresses.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    
    class func getAddress(params:Addresses.RequestAddresslist = Addresses.RequestAddresslist(), completionHandler: @escaping ((Addresses.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.GetAddressList, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = Addresses.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    
    
    class func updateAddress(params:Addresses.RequestUpdateAddress, completionHandler: @escaping ((Addresses.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.UpdateAddress, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = Addresses.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    class func removeAddress(params:Addresses.RequestDeleteAddress, completionHandler: @escaping ((Addresses.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.RemoveAddress, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = Addresses.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    
  
    
    //MARK:   Setting APIS
    class func getSettingDetail(params:SettingPreference.RequestSettingPrefenceList = SettingPreference.RequestSettingPrefenceList(), completionHandler: @escaping ((SettingPreference.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.SettingDetail, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = SettingPreference.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    
    class func updateSetting(params:SettingPreference.SaveSettingPrefence, completionHandler: @escaping ((SettingPreference.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.UpdateSettingDetail, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = SettingPreference.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    class func userLogout(params:User.RequestLogout = User.RequestLogout(), completionHandler: @escaping ((ResponseModel) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.UserLogout, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = ResponseModel.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    
    class func changePassword(params:User.RequestChangePassword, completionHandler: @escaping ((ResponseModel) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.ChangePassword, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = ResponseModel.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
}


