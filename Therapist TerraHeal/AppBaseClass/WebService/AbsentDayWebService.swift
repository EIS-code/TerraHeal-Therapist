//
//  UserGiveReviewToStore.swift
//  ShoppingApp
//
//  Created by Jaydeep on ""4/11/19.
//  Copyright © 2""19 Jaydeep. All rights reserved.
//

import Foundation

//MARK: Request Models
class AbsentDayWebService {
    static let url: String = API_URL.Absent
    struct RequestToAbsent: Codable {
        var id: String = PreferenceHelper.shared.getUserId()
        var date: String = ""
        var absent_reason: String = ""
    }
}

//MARK: WebServiceCall
extension AbsentDayWebService {
    static func requestToAbsent(params: AbsentDayWebService.RequestToAbsent ,completionHandler: @escaping ((ResponseModel) -> Void)) {
        
        AlamofireHelper().getDataFrom(urlString: Self.url, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = ResponseModel.init(fromDictionary: dictionary)
            completionHandler(response)
        }

    }
}

