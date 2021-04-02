//
//  UserGiveReviewToStore.swift
//  ShoppingApp
//
//  Created by Jaydeep on ""4/11/19.
//  Copyright © 2""19 Jaydeep. All rights reserved.
//

import Foundation

//MARK: Request Models
class LanguageWebService {
    static let url: String = API_URL.GetLanguageList
    struct RequestSelectLanguage: Codable {
        var language_id: String = ""
        var language_type: String = ""
    }
}

//MARK: Response Models
extension LanguageWebService {
    class Response :  ResponseModel {
        var languageList: [LanguageData] = []
        override init(fromDictionary dictionary: [String:Any]) {
            super.init(fromDictionary: dictionary)
            languageList.removeAll()
            if let dataArray = dictionary["data"] as? [[String:Any]] {
                for data in dataArray {
                    languageList.append(LanguageData.init(fromDictionary: data))
                }
            }
        }
    }

    class LanguageData{
        var id: String = ""
        var name: String = ""
        var isSelected: Bool = false
        /**
         * Instantiate the instance using the passed dictionary values to set the properties values
         */
        init(fromDictionary dictionary: [String:Any]){
            self.id = (dictionary["id"] as? String) ?? ""
            self.name = (dictionary["name"] as? String) ?? ""
        }

    }
}


//MARK: WebServiceCall
extension LanguageWebService {
    static func getAllLanguage(completionHandler: @escaping ((LanguageWebService.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: Self.url, methodName: AlamofireHelper.GET_METHOD, paramData: [:]) { (data, dictionary, error) in
            let response = LanguageWebService.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    static func selectLanguage(params:LanguageWebService.RequestSelectLanguage, completionHandler: @escaping ((UserWebService.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.UserProfile, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = UserWebService.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
}

