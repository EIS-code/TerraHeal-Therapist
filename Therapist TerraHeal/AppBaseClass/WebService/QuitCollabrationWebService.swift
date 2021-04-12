//
//  UserGiveReviewToStore.swift
//  ShoppingApp
//
//  Created by Jaydeep on ""4/11/19.
//  Copyright © 2""19 Jaydeep. All rights reserved.
//

import Foundation

//MARK: Request Models
class CollabrationWebService {
    static let quitCollabrationUrl: String = API_URL.QuitCollabration
    static let suspendCollabrationUrl: String = API_URL.SuspendCollaboration
    
    struct RequestQuitCollabration: Codable {
        var reason: String = ""
    }
    struct RequestSuspendCollabration: Codable {
        var reason: String = ""
    }

}
//MARK: Response Models
//MARK: Web Service Calls
extension CollabrationWebService {
    static func requestQuitCollabration(params:CollabrationWebService.RequestQuitCollabration, completionHandler: @escaping ((ResponseModel) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: Self.quitCollabrationUrl, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = ResponseModel.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    static func requestSuspendCollabration(params:CollabrationWebService.RequestSuspendCollabration, completionHandler: @escaping ((ResponseModel) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: Self.suspendCollabrationUrl, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = ResponseModel.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
}


