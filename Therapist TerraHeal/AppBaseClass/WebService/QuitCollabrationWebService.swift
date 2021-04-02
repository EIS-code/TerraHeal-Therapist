//
//  UserGiveReviewToStore.swift
//  ShoppingApp
//
//  Created by Jaydeep on ""4/11/19.
//  Copyright © 2""19 Jaydeep. All rights reserved.
//

import Foundation

//MARK: Request Models
class QuitCollabrationWebService {
    static let quitCollabrationUrl: String = API_URL.QuitCollabration
    struct RequestQuitCollabration: Codable {
        var reason: String = ""
    }
}
//MARK: Response Models
//MARK: Web Service Calls
extension QuitCollabrationWebService {
    static func requestQuitCollabration(params:QuitCollabrationWebService.RequestQuitCollabration, completionHandler: @escaping ((ResponseModel) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: Self.quitCollabrationUrl, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = ResponseModel.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
}


