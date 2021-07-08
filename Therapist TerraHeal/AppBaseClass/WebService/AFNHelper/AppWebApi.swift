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
        
        
        static let UserLogin: String = Domain + Routes.Client  + "/signin"
        static let ForgotPassword: String = Domain + Routes.Client  + "/signin/forgot"
        static let FreeSlot: String = Domain + "/shops/freeSlots/get"
        static let AddFreeSlot: String = Domain + Routes.Client  + "/my/availability/add/free/spots"
        static let SuggestionAndComplaints: String = Domain + Routes.Client  + "/complaintsSuggestion"
        static let GetSessionTypes: String = Domain + Routes.Client  + "/getSessionTypes"
        static let UserProfile: String = Domain + Routes.Client + "/profile/update"
        static let RemoveDocument: String = Domain + Routes.Client + "/profile/document/remove"
        static let UserLogout: String = Domain + Routes.Client  + "/logout"
        static let GetUserDetail: String = Domain + Routes.Client + "/profile/get"
        static let GetCountryList: String = Domain + Routes.Client + "/getCountries"
        static let GetCityList: String = Domain + Routes.Client + "/getCities"
        static let GetLanguageList: String = Domain + Routes.Client + "/getLanguages"
        static let GetClientList: String = Domain + Routes.Client + "/searchClients"
        static let BookingListPast: String = Domain + Routes.Client + "/booking/list/pasts"
        static let BookingListPending: String = Domain + Routes.Client + "/booking/list/pending"
        static let BookingListUpcoming: String = Domain + Routes.Client + "/booking/list/upcoming"
        static let TodayBookingList: String = Domain + Routes.Client + "/booking/list/today"
        static let PastBookingList: String = Domain + Routes.Client + "/booking/list/past"
        static let FutureBookingList: String = Domain + Routes.Client + "/booking/list/future"
        static let BookingDetail: String = Domain + Routes.Client + "/booking"
        static let NumberOfBooking: String = Domain + Routes.Client + "/booking/all"
        static let GetCalender: String = Domain + Routes.Client + "/calender/get"
        static let GetCalenderDetails: String = Domain + Routes.Client + "/calender/booking/details"
        static let GetNews: String = Domain + Routes.Client + "/news/get"
        static let ReadNews: String = Domain + Routes.Client  + "/news/read"
        static let GetWorkingSchedule: String = Domain + Routes.Client  + "/my/working/schedule"
        static let GetAllSuggestion: String = Domain + Routes.Client  + "/signin/forgot"
        static let AddSuggestion: String = Domain + Routes.Client  + "/suggestion"
        static let GetAllComplaints: String = Domain + Routes.Client  + "/signin/forgot"
        static let GetAllRatings: String = Domain + Routes.Client  + "/my/ratings"
        static let SaveRating: String = Domain + Routes.Client  + "/rating/user/save"
        static let AddComplaints: String = Domain + Routes.Client  + "/complaint"
        static let StartService: String = Domain + Routes.Client  + "/booking/massage/start"
        static let FinishService: String = Domain + Routes.Client  + "/booking/massage/end"
        static let TakeBreak: String = Domain + Routes.Client  + "/my/break"
        static let QuitCollaboration: String = Domain + Routes.Client  + "/my/collaboration/quit"
        static let GetMissingDays: String = Domain + Routes.Client  + "/my/missing/days"
        static let Absent: String = Domain + Routes.Client  + "/my/availability/absent/store"
        static let ExchangeWithOther: String = Domain + Routes.Client  + "/my/exchange"
        static let GetTherapistList: String = Domain + Routes.Client  + "/get"
        static let GetServiceList: String = Domain + Routes.Client  + "/service"
        static let GetAvailability: String = Domain + Routes.Client  + "/my/availability/get"
        static let SuspendCollaboration: String = Domain + Routes.Client  + "/my/collaboration/suspend"
        static let MatchQR: String = Domain + "/user"  + "/match/qr"
        static let VerifyEmail: String = Domain + Routes.Client + "/verify/email"
        static let VerifyPhone: String = Domain + Routes.Client + "/verify/mobile"
        static let VerifyEmailOTP: String = Domain + Routes.Client + "/compare/otp/email"
        static let VerifyPhoneOTP: String = Domain + Routes.Client + "/compare/otp/mobile"

        //Mark: Exchange API
        static let ExcahngeRequestList = Domain + Routes.Client + "/my/exchange/shifts/list"
        static let AcceptExcahngeRequest = Domain + Routes.Client + "/my/exchange/shifts/approve"
        static let RejectExcahngeRequest = Domain + Routes.Client + "/my/exchange/shifts/reject"
        static let GetAllTherapistShift = Domain + Routes.Client +  "/shifts/get"
        static let CheckExeption: String = Domain + Routes.Exception
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

    class func  getUserDetail(completionHandler: @escaping ((UserWebService.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.GetUserDetail, methodName: AlamofireHelper.POST_METHOD, paramData:["id":PreferenceHelper.shared.getUserId()]) { (data, dictionary, error) in
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
        AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.GetNews, methodName: AlamofireHelper.POST_METHOD, paramData:RequestCommon.init().dictionary) { (data, dictionary, error) in
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

    static func updateProfileDetail(params:UserWebService.RequestProfile,image:UploadDocumentDetail? = nil, completionHandler: @escaping ((UserWebService.Response) -> Void)) {
        var arrForDocuments:[UploadDocumentDetail] = []

        if let imageToUpload = image {
            arrForDocuments.append(imageToUpload)
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
    static func updateMassages(params:UserWebService.RequestUpdateMassage, completionHandler: @escaping ((UserWebService.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.UserProfile, methodName: AlamofireHelper.POST_METHOD, paramData: params.toDictionary()) { (data, dictionary, error) in
            let response = UserWebService.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }

    static func updateDocuments(params:UserWebService.RequestProfile = UserWebService.RequestProfile.init(),documents:[UploadDocumentDetail], completionHandler: @escaping ((UserWebService.Response) -> Void)) {
        let arrForDocuments:[UploadDocumentDetail] = documents


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
    class func removeDocument(params:UserWebService.RequestRemoveDocument, completionHandler: @escaping ((ResponseModel) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.RemoveDocument, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = ResponseModel.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }

    
    class func therapistList(params:CityWebService.RequestCityList, completionHandler: @escaping ((CityWebService.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.GetCityList, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = CityWebService.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
}


