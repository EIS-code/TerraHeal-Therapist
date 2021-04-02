//
//  UserGiveReviewToStore.swift
//  ShoppingApp
//
//  Created by Jaydeep on ""4/11/19.
//  Copyright © 2""19 Jaydeep. All rights reserved.
//

import Foundation

//MARK: Request Models
class SuggestionAndComplaintWebService {
    static let getAllSuggestionAndComplaintsUrl: String = API_URL.SuggestionAndComplaints
    static let addSuggestionUrl: String = API_URL.AddSuggestion
    static let addComplaintUrl: String = API_URL.AddComplaints
    struct RequestAddSuggestion: Codable {
        var suggestion: String = ""
    }
    struct RequestAddComplaint: Codable {
        var complaint: String = ""
    }
    struct RequestAllSuggestionAndComplaints: Codable {
        var shop_id: String = appSingleton.user.shopId
        var therapist_id: String = appSingleton.user.id
    }
}

//MARK: Response Models
extension SuggestionAndComplaintWebService {
    class Response :  ResponseModel {
        var suggestionAndComplaintList: [SuggestionAndComplaint] = []
        override init(fromDictionary dictionary: [String:Any]) {
            super.init(fromDictionary: dictionary)
            suggestionAndComplaintList.removeAll()
            if let dataArray = dictionary["data"] as? [[String:Any]] {
                for data in dataArray {
                    suggestionAndComplaintList.append(SuggestionAndComplaint.init(fromDictionary: data))
                }
            }
            else if let data = dictionary["data"] as? [String:Any] {
                suggestionAndComplaintList.append(SuggestionAndComplaint.init(fromDictionary: data))
            }
        }
    }
}

class SuggestionAndComplaint {
    var id: String = ""
    var shopId: String = ""
    var suggestion: String = ""
    var complaint: String  = ""
    var therapistId: String = ""


    init(fromDictionary dictionary: [String:Any]){
        self.id = (dictionary["id"] as? String) ?? ""
        self.shopId = (dictionary["shop_id"] as? String) ?? ""
        self.suggestion = (dictionary["suggestion"] as? String) ?? ""
        self.complaint = (dictionary["complaint"] as? String) ?? ""
        self.therapistId = (dictionary["therapist_id"] as? String) ?? ""
    }

}
//MARK: Web Service Calls
extension SuggestionAndComplaintWebService {
    static func getAllSuggestionAdnComplaints(completionHandler: @escaping ((SuggestionAndComplaintWebService.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: Self.getAllSuggestionAndComplaintsUrl, methodName: AlamofireHelper.POST_METHOD, paramData: SuggestionAndComplaintWebService.RequestAllSuggestionAndComplaints.init().dictionary) { (data, dictionary, error) in
            let response = SuggestionAndComplaintWebService.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    static func requestAddSuggestion(params:SuggestionAndComplaintWebService.RequestAddSuggestion, completionHandler: @escaping ((SuggestionAndComplaintWebService.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: SuggestionAndComplaintWebService.addSuggestionUrl, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = SuggestionAndComplaintWebService.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }

    static func requestAddComplaint(params:SuggestionAndComplaintWebService.RequestAddComplaint, completionHandler: @escaping ((SuggestionAndComplaintWebService.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: SuggestionAndComplaintWebService.addComplaintUrl, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = SuggestionAndComplaintWebService.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
}

