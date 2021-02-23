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
            static let Dev = "http://35.180.202.175"
            static let Production = "http://35.180.202.175"
            static let Local = "http://35.180.202.175"
            
        }

        private  struct Routes {
            static let Client = "/therapist"
            static let Exception = "/api/error"
            static let Location = "/api/location"
        }
        
        private  static let Domain = Domains.Production
        
        
        static var UserLogin: String {
            return Domain + Routes.Client  + "/signin"
        }

        static var ForgotPassword: String {
            return Domain + Routes.Client  + "/signin/forgot"
        }

        static var UserProfile: String {
            return Domain + Routes.Client + "/profile/update"
        }
        
        static var UserLogout: String {
            return Domain + Routes.Client  + "/logout"
            
        }

        static var GetUserDetail: String {
            return  Domain + Routes.Client + "/profile/get"
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
        static var GetCalender: String {
            return  Domain + Routes.Client + "/calender/get"
        }
        static var GetCalenderDetails: String {
            return  Domain + Routes.Client + "/calender/booking/details"
        }
        static var GetNews: String {
            return  Domain + "/news/get"
        }
        static var ReadNews: String {
            return  Domain + "/news/read"
        }

        static var GetWorkingSchedule: String {
            return  Domain + Routes.Client  + "/my/working/schedule"
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
    
    class func login(params:UserWebService.RequestLogin, completionHandler: @escaping ((UserWebService.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.UserLogin, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = UserWebService.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }

    class func forgotPassword(params:UserWebService.RequestLogin, completionHandler: @escaping ((UserWebService.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.UserLogin, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = UserWebService.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }

    class func getUserDetail(completionHandler: @escaping ((UserWebService.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.GetUserDetail, methodName: AlamofireHelper.GET_METHOD, paramData:[:]) { (data, dictionary, error) in
            let response = UserWebService.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    

    
    class func exception(params:[String:String], completionHandler: @escaping ((UserWebService.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.CheckExeption, methodName: AlamofireHelper.GET_METHOD, paramData:[:]) { (data, dictionary, error) in
            let response = UserWebService.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }


    class func getNews(completionHandler: @escaping ((NewsWebService.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.GetNews, methodName: AlamofireHelper.GET_METHOD, paramData:[:]) { (data, dictionary, error) in
            let response = NewsWebService.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }

    class func getWorkingSchedule(params:WorkingScheduleWebService.RequestSchedule,completionHandler: @escaping ((WorkingScheduleWebService.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.GetWorkingSchedule, methodName: AlamofireHelper.POST_METHOD, paramData:params.dictionary) { (data, dictionary, error) in
            let response = WorkingScheduleWebService.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }

    class func readNews(params:NewsWebService.RequestReadNews, completionHandler: @escaping ((NewsWebService.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.ReadNews, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = NewsWebService.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }

    static func updateProfileDetail(params:UserWebService.RequestProfile,image:UploadDocumentDetail? = nil,document:UploadDocumentDetail? = nil, completionHandler: @escaping ((UserWebService.Response) -> Void)) {
        var arrForDocuments:[UploadDocumentDetail] = []

        if let imageToUpload = image {
            arrForDocuments.append(imageToUpload)
        }
        if let documentToUpload = document {
            arrForDocuments.append(documentToUpload)
        }
        if arrForDocuments.isEmpty {
            AlamofireHelper().getDataFrom(urlString: API_URL.UserProfile, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
                let response = UserWebService.Response.init(fromDictionary: dictionary)
                completionHandler(response)
            }
        } else {
            AlamofireHelper().uploadDocumentToURL(urlString: API_URL.UserProfile, paramData: params.dictionary, documents: arrForDocuments) { (data, dictionary, error) in
                let response = UserWebService.Response.init(fromDictionary: dictionary)
                completionHandler(response)
            }
        }
    }
    
    class func userLogout(params:UserWebService.RequestLogout = UserWebService.RequestLogout(), completionHandler: @escaping ((ResponseModel) -> Void)) {
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

   
}


