//
//  UserGiveReviewToStore.swift
//  ShoppingApp
//
//  Created by Jaydeep on ""4/11/19.
//  Copyright © 2""19 Jaydeep. All rights reserved.
//

import Foundation

//MARK: Request Models
class ForgotWebService {
    static let url: String = API_URL.ForgotPassword
    struct RequestForgotPassword: Codable {
        var email: String = ""
    }
}

//MARK: Response Models
extension ForgotWebService {
    class Response :  ResponseModel {
        override init(fromDictionary dictionary: [String:Any]) {
            super.init(fromDictionary: dictionary)
        }
    }
}

//MARK: WebServiceCall
extension ForgotWebService {
    func callForgotPassword(params:ForgotWebService.RequestForgotPassword, completionHandler: @escaping ((ForgotWebService.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.ForgotPassword, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = ForgotWebService.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
}

