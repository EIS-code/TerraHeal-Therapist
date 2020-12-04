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
            static let Exception = "/api/error"
            static let Location = "/api/location"
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
            return Domain + Routes.Client  + "/logout"
            
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

        //MARK:- Booking Api
        static var TodayBookingList: String {
            return  Domain + Routes.Client + "/booking/list/today"
        }
        static var PastBookingList: String {
            return  Domain + Routes.Client + "/booking/list/past"
        }
        static var FutureBookingList: String {
            return  Domain + Routes.Client + "/booking/list/future"
        }
        static var BookingDetail: String {
            return  Domain + Routes.Client + "/booking"
        }

        //MARK: Exception
        static var CheckExeption: String {
            return Domain + Routes.Exception
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
    

    
    class func exception(params:[String:String], completionHandler: @escaping ((User.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.CheckExeption, methodName: AlamofireHelper.GET_METHOD, paramData:[:]) { (data, dictionary, error) in
            let response = User.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }


    class func profile(params:User.RequestProfile, image:UploadDocumentDetail? = nil, paramName:String = "profile_photo", completionHandler: @escaping ((User.Response) -> Void)) {
        if let imageToUpload = image {
            AlamofireHelper().uploadDocumentToURL(urlString:API_URL.UserProfile , paramData: params.dictionary, documents: [imageToUpload],paramName: paramName)  { (data, dictionary, error) in
                let response = User.Response.init(fromDictionary: dictionary)
                completionHandler(response)
            }
        }
        else {
            AlamofireHelper().getDataFrom(urlString: API_URL.UserProfile, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
                let response = User.Response.init(fromDictionary: dictionary)
                completionHandler(response)        }
        }
    }
    
    class func userLogout(params:User.RequestLogout = User.RequestLogout(), completionHandler: @escaping ((ResponseModel) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.UserLogout, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = ResponseModel.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }

    class func countryList(params:Countries.RequestCountrylist = Countries.RequestCountrylist(), completionHandler: @escaping ((Countries.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.GetCountryList, methodName: AlamofireHelper.GET_METHOD, paramData: [:]) { (data, dictionary, error) in
            let response = Countries.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }

    class func cityList(params:Cities.RequestCitylist, completionHandler: @escaping ((Cities.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.GetCityList, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = Cities.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }

    class func todayBookingList(params:BookingWebSerive.RequestTodayBookingList = BookingWebSerive.RequestTodayBookingList.init(), completionHandler: @escaping ((BookingWebSerive.ResponseBookingList) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.PastBookingList, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = BookingWebSerive.ResponseBookingList.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    class func pastBookingList(params:BookingWebSerive.RequestPastBookingList = BookingWebSerive.RequestPastBookingList.init(), completionHandler: @escaping ((BookingWebSerive.ResponseBookingList) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.PastBookingList, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = BookingWebSerive.ResponseBookingList.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    class func futureBookingList(params:BookingWebSerive.RequestTodayBookingList = BookingWebSerive.RequestTodayBookingList.init(), completionHandler: @escaping ((BookingWebSerive.ResponseBookingList) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.FutureBookingList, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = BookingWebSerive.ResponseBookingList.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }

    class func getBookingDetail(params:BookingWebSerive.RequestBookingDetail = BookingWebSerive.RequestBookingDetail.init(), completionHandler: @escaping ((BookingWebSerive.ResponseBookingDetail) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.BookingDetail, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = BookingWebSerive.ResponseBookingDetail.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
}


