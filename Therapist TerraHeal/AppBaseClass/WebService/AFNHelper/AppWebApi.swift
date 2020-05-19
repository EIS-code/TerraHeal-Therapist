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
            return Domain + Routes.Client + "/update"
        }
        static var UploadDocument: String {
            return Domain + Routes.Client + "/documents/" + PreferenceHelper.shared.getUserId()
        }
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

    class func register(params:User.RequestRegister, completionHandler: @escaping ((User.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.UserRegister, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = User.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }

    class func profile(params:User.RequestProfile, completionHandler: @escaping ((User.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.UserRegister, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = User.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }

    class func uploadDocument(params:User.RequestUploadDocument, documents:[String:Any], completionHandler: @escaping ((User.Response) -> Void)) {
        AlamofireHelper().uploadDocumentToURL(urlString:AppWebApi.URL.UploadDocument , paramData: params.dictionary, documents: documents)  { (data, dictionary, error) in
            print(dictionary)
        }
    }

    class func exception(params:[String:String], completionHandler: @escaping ((User.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.CheckExeption, methodName: AlamofireHelper.GET_METHOD, paramData:[:]) { (data, dictionary, error) in
            let response = User.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
}
/*

    class func userRegister(params:Register.Request, image:UIImage?,completionHandler: @escaping ((User.Response) -> Void)) {

        Loader.showLoading()
        if let uploadImage = image {
            AlamofireHelper().getResponseFromURL(url: AppWebApi.URL.UserRegister , paramData: params.dictionary, image: uploadImage){ (data, dictionary, error) in
                DispatchQueue.main.async {
                    Loader.hideLoading()
                    let response = User.Response.init(fromDictionary: dictionary)
                    if error != nil {
                        response.errorMessage = [error!]
                    }

                    completionHandler(response)
                }
            }
        } else {
        AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.UserRegister, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            DispatchQueue.main.async {
                Loader.hideLoading()
                let response = User.Response.init(fromDictionary: dictionary)
                if error != nil {
                    response.errorMessage = [error!]
                }

                completionHandler(response)
            }
            }
        }

    }

    class func updateProfile(params:User.RequestProfile,image:UIImage?, completionHandler: @escaping ((User.Response) -> Void)) {

        Loader.showLoading()
        if let uploadImage = image {
            AlamofireHelper().getResponseFromURL(url: AppWebApi.URL.UpdateProfile , paramData: params.dictionary, image: uploadImage){ (data, dictionary, error) in
                DispatchQueue.main.async {
                    Loader.hideLoading()
                    let response = User.Response.init(fromDictionary: dictionary)
                    if error != nil {
                        response.errorMessage = [error!]
                    }

                    completionHandler(response)
                }
            }
        } else {
            AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.UpdateProfile, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
                DispatchQueue.main.async {
                    Loader.hideLoading()
                    let response = User.Response.init(fromDictionary: dictionary)
                    if error != nil {
                        response.errorMessage = [error!]
                    }

                    completionHandler(response)
                }
            }
        }


    }

    class func userGetAllRequest(params:RequestList.Get, completionHandler: @escaping ((RequestList.Response) -> Void)) {

        Loader.showLoading()
        AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.ReqestList, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            DispatchQueue.main.async {
                Loader.hideLoading()
                let response = RequestList.Response.init(fromDictionary: dictionary)
                if error != nil {
                    response.errorMessage = [error!]
                }

                completionHandler(response)
            }
        }

    }

    
    class func userGetAllMessages(params:MessageApi.GetRequest, completionHandler: @escaping ((MessageApi.GetResponse) -> Void)) {

        AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.GetMessages, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            DispatchQueue.main.async {

                let response = MessageApi.GetResponse.init(fromDictionary: dictionary)
                if error != nil {
                    response.errorMessage = [error!]
                }

                completionHandler(response)
            }
        }

    }

    class func userGetNewMessages(params:MessageApi.GetRequest, completionHandler: @escaping ((MessageApi.GetResponse) -> Void)) {

        AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.GetNewMessages, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            DispatchQueue.main.async {
                let response = MessageApi.GetResponse.init(fromDictionary: dictionary)
                if error != nil {
                    response.errorMessage = [error!]
                }

                completionHandler(response)
            }
        }

    }
    class func sendMessage(params:MessageApi.SendRequest, completionHandler: @escaping ((ResponseModel) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.SendMessage, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = ResponseModel.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }

    class func getAllTrailers(params:TrailerList.Request, completionHandler: @escaping ((TrailerList.Response) -> Void)) {

        Loader.showLoading()
        AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.TrailerList, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            DispatchQueue.main.async {
                Loader.hideLoading()
                let response = TrailerList.Response.init(fromDictionary: dictionary)
                if error != nil {
                    response.errorMessage = [error!]
                }

                completionHandler(response)
            }
        }

    }

    class func getAllCities(params:CityService.Request, completionHandler: @escaping ((CityService.Response) -> Void)) {

        Loader.showLoading()
        AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.CityService, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            DispatchQueue.main.async {
                Loader.hideLoading()
                let response = CityService.Response.init(fromDictionary: dictionary)
                if error != nil {
                    response.errorMessage = [error!]
                }

                completionHandler(response)
            }
        }

    }

    class func userSettingDetail(params:[String:Any] = [:], completionHandler: @escaping ((Setting.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.GetSettingDetail, methodName: AlamofireHelper.POST_METHOD, paramData: [:]) { (data, dictionary, error) in
            let response = Setting.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    class func userLogout(params:[String:Any] = User.RequestLogout().dictionary, completionHandler: @escaping ((ResponseModel) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.UserLogout, methodName: AlamofireHelper.POST_METHOD, paramData: params) { (data, dictionary, error) in
            let response = ResponseModel.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }

    class func getBulkDayList(params:BulkDayListItem.Request, completionHandler: @escaping ((BulkDayListItem.Response) -> Void)) {

        Loader.showLoading()
        AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.BulkDayList, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            DispatchQueue.main.async {
                Loader.hideLoading()
                let response = BulkDayListItem.Response.init(fromDictionary: dictionary)
                if error != nil {
                    response.errorMessage = [error!]
                }

                completionHandler(response)
            }
        }

    }

    class func createRequest(params:RequestList.Create, image:UIImage?, completionHandler: @escaping ((RequestList.Response) -> Void)) {
        Loader.showLoading()
        if let uploadImage = image {
            AlamofireHelper().getResponseFromURL(url: AppWebApi.URL.CreateRequest , paramData: params.dictionary, image: uploadImage){ (data, dictionary, error) in
                DispatchQueue.main.async {
                    Loader.hideLoading()
                    let response = RequestList.Response.init(fromDictionary: dictionary)
                    if error != nil {
                        response.errorMessage = [error!]
                    }

                    completionHandler(response)
                }
            }

        } else {

            AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.CreateRequest, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
                DispatchQueue.main.async {
                    Loader.hideLoading()
                    let response = RequestList.Response.init(fromDictionary: dictionary)
                    if error != nil {
                        response.errorMessage = [error!]
                    }

                    completionHandler(response)
                }
            }
        }



    }

    class func createGuestRequest(params:RequestList.CreateGuestRequest, image:UIImage?, completionHandler: @escaping ((RequestList.Response) -> Void)) {
        Loader.showLoading()
        if let uploadImage = image {
            AlamofireHelper().getResponseFromURL(url: AppWebApi.URL.GuestCheckout , paramData: params.dictionary, image: uploadImage){ (data, dictionary, error) in
                DispatchQueue.main.async {
                    Loader.hideLoading()
                    let response = RequestList.Response.init(fromDictionary: dictionary)
                    if error != nil {
                        response.errorMessage = [error!]
                    }

                    completionHandler(response)
                }
            }

        } else {

            AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.GuestCheckout, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
                DispatchQueue.main.async {
                    Loader.hideLoading()
                    let response = RequestList.Response.init(fromDictionary: dictionary)
                    if error != nil {
                        response.errorMessage = [error!]
                    }

                    completionHandler(response)
                }
            }
        }



    }
    //Payment Related Apis
    class func getAllCard(params:CardApi.GetRequest = CardApi.GetRequest(), completionHandler: @escaping ((CardApi.GetResponse) -> Void)) {

        Loader.showLoading()
        AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.GetCard, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            DispatchQueue.main.async {
                Loader.hideLoading()
                let response = CardApi.GetResponse.init(fromDictionary: dictionary)
                if error != nil {
                    response.errorMessage = [error!]
                }

                completionHandler(response)
            }
        }

    }
    class func addCard(params:CardApi.AddRequest = CardApi.AddRequest(), completionHandler: @escaping ((CardApi.AddResponse) -> Void)) {

        Loader.showLoading()
        AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.AddCard, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            DispatchQueue.main.async {
                Loader.hideLoading()
                let response = CardApi.AddResponse.init(fromDictionary: dictionary)
                if error != nil {
                    response.errorMessage = [error!]
                }

                completionHandler(response)
            }
        }

    }
    class func deleteCard(params:CardApi.DeleteRequest = CardApi.DeleteRequest(), completionHandler: @escaping ((CardApi.DeleteResponse) -> Void)) {

        Loader.showLoading()
        AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.DeleteCard, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            DispatchQueue.main.async {
                Loader.hideLoading()
                let response = CardApi.DeleteResponse.init(fromDictionary: dictionary)
                if error != nil {
                    response.errorMessage = [error!]
                }

                completionHandler(response)
            }
        }

    }
    class func forgotPassword(params:ForgotPassword.Request, completionHandler: @escaping ((ForgotPassword.Response) -> Void)) {

        Loader.showLoading()
        AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.ForgotPassword, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            DispatchQueue.main.async {
                Loader.hideLoading()
                let response = ForgotPassword.Response.init(fromDictionary: dictionary)
                if error != nil {
                    response.errorMessage = [error!]
                }

                completionHandler(response)
            }
        }

    }


    //Address Related Apis
    class func getAllAddress(params:AddressApi.GetRequest = AddressApi.GetRequest(), completionHandler: @escaping ((AddressApi.GetResponse) -> Void)) {

        Loader.showLoading()
        AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.GetAddress, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            DispatchQueue.main.async {
                Loader.hideLoading()
                let response = AddressApi.GetResponse.init(fromDictionary: dictionary)
                if error != nil {
                    response.errorMessage = [error!]
                }

                completionHandler(response)
            }
        }

    }
    class func addAddress(params:AddressApi.AddRequest = AddressApi.AddRequest(), completionHandler: @escaping ((AddressApi.AddResponse) -> Void)) {

        Loader.showLoading()
        AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.AddAddress, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            DispatchQueue.main.async {
                Loader.hideLoading()
                let response = AddressApi.AddResponse.init(fromDictionary: dictionary)
                if error != nil {
                    response.errorMessage = [error!]
                }

                completionHandler(response)
            }
        }

    }
    class func deleteAddress(params:AddressApi.DeleteRequest = AddressApi.DeleteRequest(), completionHandler: @escaping ((AddressApi.DeleteResponse) -> Void)) {

        Loader.showLoading()
        AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.DeleteAddress, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            DispatchQueue.main.async {
                Loader.hideLoading()
                let response = AddressApi.DeleteResponse.init(fromDictionary: dictionary)
                if error != nil {
                    response.errorMessage = [error!]
                }

                completionHandler(response)
            }
        }
    }

    class func getTimeAvailbility(params:TimeApi.GetRequest, completionHandler: @escaping ((TimeApi.GetResponse) -> Void)) {

        Loader.showLoading()
        AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.CheckTimeAvailability, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            DispatchQueue.main.async {
                Loader.hideLoading()
                let response = TimeApi.GetResponse.init(fromDictionary: dictionary)
                if error != nil {
                    response.errorMessage = [error!]
                }

                completionHandler(response)
            }
        }

    }
}



*/

