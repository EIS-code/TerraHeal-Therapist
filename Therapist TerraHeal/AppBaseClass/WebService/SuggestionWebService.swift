//
//  UserGiveReviewToStore.swift
//  ShoppingApp
//
//  Created by Jaydeep on ""4/11/19.
//  Copyright © 2""19 Jaydeep. All rights reserved.
//

import Foundation

//MARK: Request Models
class SuggestionWebService {
    static let getAllSuggestionUrl: String = API_URL.ForgotPassword
    static let addSuggestionUrl: String = API_URL.AddSuggestion
    struct RequestAddSuggestion: Codable {
        var suggestion: String = ""
    }
    struct RequestAllSuggestion: Codable {
        var suggestion: String = ""
    }
}

//MARK: Response Models
extension SuggestionWebService {
    class Response :  ResponseModel {
        var suggestionList: [Suggestion] = []
        override init(fromDictionary dictionary: [String:Any]) {
            super.init(fromDictionary: dictionary)
            suggestionList.removeAll()
            if let dataArray = dictionary["data"] as? [[String:Any]] {
                for data in dataArray {
                    suggestionList.append(Suggestion.init(fromDictionary: data))
                }
            }
            else if let data = dictionary["data"] as? [String:Any] {
                suggestionList.append(Suggestion.init(fromDictionary: data))
            }
        }
    }
}

class Suggestion {
    var id: String = ""
    var shopId: String = ""
    var suggestion: String = ""
    var therapistId: String = ""


        init(fromDictionary dictionary: [String:Any]){
            self.id = (dictionary["id"] as? String) ?? ""
            self.shopId = (dictionary["shop_id"] as? String) ?? ""
            self.suggestion = (dictionary["suggestion"] as? String) ?? ""
            self.therapistId = (dictionary["therapist_id"] as? String) ?? ""
        }

}
//MARK: Web Service Calls
extension SuggestionWebService {
   static func getAllSuggestion(params:SuggestionWebService.RequestAllSuggestion = SuggestionWebService.RequestAllSuggestion.init() , completionHandler: @escaping ((SuggestionWebService.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.ForgotPassword, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = SuggestionWebService.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    static func requestAddSuggestion(params:SuggestionWebService.RequestAddSuggestion, completionHandler: @escaping ((SuggestionWebService.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: SuggestionWebService.addSuggestionUrl, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = SuggestionWebService.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
}

