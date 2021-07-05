//
//  UserGiveReviewToStore.swift
//  ShoppingApp
//
//  Created by Jaydeep on ""4/11/19.
//  Copyright © 2""19 Jaydeep. All rights reserved.
//

import Foundation

//MARK: Request Models
class MenuWebService {
    static let getAllSuggestionAndComplaintsUrl: String = API_URL.SuggestionAndComplaints
    static let addSuggestionUrl: String = API_URL.AddSuggestion
    static let addComplaintUrl: String = API_URL.AddComplaints
    static let takeBreakUrl: String = API_URL.TakeBreak
    static let quitCollaborationUrl: String = API_URL.QuitCollaboration
    static let suspendCollaborationUrl: String = API_URL.SuspendCollaboration

    struct RequestAddSuggestion: Codable {
        var id: String = PreferenceHelper.shared.getUserId()
        var shop_id: String = appSingleton.user.shopId
        var suggestion: String = ""
    }
    struct RequestAddComplaint: Codable {
        var id: String = PreferenceHelper.shared.getUserId()
        var shop_id: String = appSingleton.user.shopId
        var complaint: String = ""
    }
    struct RequestQuitCollaboration: Codable {
        var id: String = PreferenceHelper.shared.getUserId()
        var shop_id: String = appSingleton.user.shopId
        var reason: String = ""
    }
    struct RequestSuspendCollaboration: Codable {
        var id: String = PreferenceHelper.shared.getUserId()
        var shop_id: String = appSingleton.user.shopId
        var reason: String = ""
    }
    struct RequestAllSuggestionAndComplaints: Codable {
        var id: String = PreferenceHelper.shared.getUserId()
        var shop_id: String = appSingleton.user.shopId
        var therapist_id: String = appSingleton.user.id
    }
    struct RequestTakeBreak: Codable {
        var id: String = PreferenceHelper.shared.getUserId()
        var shop_id: String = appSingleton.user.shopId
        var date: String = "1622851200000"
        var break_reason: String = "--"
        var shift_id: String = ""
        var from: String = ""
        var to: String = ""

    }
}

//MARK: Response Models
extension MenuWebService {
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
    var createdTime: String = ""
    var id: String = ""
    var receptionistId: String = ""
    var receptionistPhoto: String = ""
    var text: String = ""
    var therapistId: String = ""
    var therapistName: String = ""
    var therapistPhoto: String = ""
    var type: String = ""
    var receptionisName: String = ""



    init(fromDictionary dictionary: [String:Any]){
        self.createdTime = (dictionary["created_time"] as? String) ?? ""
        self.id = (dictionary["id"] as? String) ?? ""
        self.receptionistId = (dictionary["receptionist_id"] as? String) ?? ""
        self.receptionistPhoto = (dictionary["receptionist_photo"] as? String) ?? ""
        self.receptionisName = (dictionary["receptionist_name"] as? String) ?? ""
        self.text = (dictionary["text"] as? String) ?? ""
        self.therapistId = (dictionary["therapist_id"] as? String) ?? ""
        self.therapistName = (dictionary["therapist_name"] as? String) ?? ""
        self.therapistPhoto = (dictionary["therapist_photo"] as? String) ?? ""
        self.type = (dictionary["type"] as? String) ?? ""

    }

}

//MARK: Web Service Calls
extension MenuWebService {
    static func getAllSuggestionAdnComplaints(completionHandler: @escaping ((MenuWebService.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: Self.getAllSuggestionAndComplaintsUrl, methodName: AlamofireHelper.GET_METHOD, paramData: MenuWebService.RequestAllSuggestionAndComplaints.init().dictionary) { (data, dictionary, error) in
            let response = MenuWebService.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    static func requestAddSuggestion(params:MenuWebService.RequestAddSuggestion, completionHandler: @escaping ((MenuWebService.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: MenuWebService.addSuggestionUrl, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = MenuWebService.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }

    static func requestAddComplaint(params:MenuWebService.RequestAddComplaint, completionHandler: @escaping ((MenuWebService.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: MenuWebService.addComplaintUrl, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = MenuWebService.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }

    static func requestTakeBreak(params:MenuWebService.RequestTakeBreak, completionHandler: @escaping ((ResponseModel) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: Self.takeBreakUrl, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = ResponseModel.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    static func requestQuitCollaboration(params:MenuWebService.RequestQuitCollaboration, completionHandler: @escaping ((ResponseModel) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: Self.quitCollaborationUrl, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = ResponseModel.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    static func requestSuspendCollaboration(params:MenuWebService.RequestSuspendCollaboration, completionHandler: @escaping ((ResponseModel) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: Self.suspendCollaborationUrl, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = ResponseModel.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
}

