//
//  UserGiveReviewToStore.swift
//  ShoppingApp
//
//  Created by Jaydeep on ""4/11/19.
//  Copyright © 2""19 Jaydeep. All rights reserved.
//

import Foundation

enum RatingType: Int {
    case Punctuality = 0
    case Behavior = 1
    case SexualIssue = 2
    case Hygiene = 3
    case LeftBadGood = 4
    case PaymentIssue = 5

    func getText() -> String {
        switch self {
        case .Punctuality:
            return "RATE_TYPE_PUNCTUALITY".localized()
        case .Behavior:
            return "RATE_TYPE_BEHAVIOR".localized()
        case .SexualIssue:
            return "RATE_TYPE_SEXUAL_ISSUE".localized()
        case .Hygiene:
            return "RATE_TYPE_HYGIENE".localized()
        case .LeftBadGood:
            return "RATE_TYPE_LEFT_BAD_GOOD".localized()
        case .PaymentIssue:
            return "RATE_TYPE_PAYMENT_ISSUE".localized()
        }
    }

}
//MARK: Request Models
class RatingWebService {
    static let getAllRatingUrl: String = API_URL.GetAllRatings
    static let saveRatingUrl: String = API_URL.SaveRating
    struct RequestAddRating: Codable {
        var id: String = PreferenceHelper.shared.getUserId()
        var user_id: String = appSingleton.currentService.userPeopleId
        var punctuality: Double = 0.0
        var behavior: Double = 0.0
        var sexualIssue: Double = 0.0
        var hygiene: Double = 0.0
        var leftBadGood: Double = 0.0
        var paymentIssue: Double = 0.0

        func toDictionary() -> [String:String] {
            var dicnationary : [String:String] = [:]
            if punctuality != 0.0 {
                dicnationary["rating[0]"] = self.punctuality.toString()
            }
            if behavior != 0.0 {
                dicnationary["rating[1]"] = self.behavior.toString()
            }
            if sexualIssue != 0.0 {
                dicnationary["rating[2]"] = self.sexualIssue.toString()
            }
            if hygiene != 0.0 {
                dicnationary["rating[3]"] = self.hygiene.toString()
            }
            if leftBadGood != 0.0 {
                dicnationary["rating[4]"] = self.leftBadGood.toString()
            }
            if paymentIssue != 0.0 {
                dicnationary["rating[5]"] = self.paymentIssue.toString()
            }
            dicnationary["user_id"] = self.user_id
            return dicnationary
        }
    }
}

//MARK: Response Models
extension RatingWebService {
    class Response :  ResponseModel {
        var ratingList: [RatingData] = []
        override init(fromDictionary dictionary: [String:Any]) {
            super.init(fromDictionary: dictionary)
            ratingList.removeAll()
            if let dataArray = dictionary["data"] as? [[String:Any]] {
                for data in dataArray {
                    ratingList.append(RatingData.init(fromDictionary: data))
                }
            }
            else if let data = dictionary["data"] as? [String:Any] {
                ratingList.append(RatingData.init(fromDictionary: data))
            }
        }
    }
}

class RatingData {
    var averageRating: String = ""
    var briefDescription: String = ""
    var question: String = ""
    var questionId: String = ""


    init(fromDictionary dictionary: [String:Any]){
        self.averageRating = (dictionary["average_rating"] as? String) ?? ""
        self.briefDescription = (dictionary["brief_description"] as? String) ?? ""
        self.question = (dictionary["question"] as? String) ?? ""
        self.questionId = (dictionary["question_id"] as? String) ?? ""

    }

}
//MARK: Web Service Calls
extension RatingWebService {
    static func getAllRating( completionHandler: @escaping ((RatingWebService.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: RatingWebService.getAllRatingUrl, methodName: AlamofireHelper.POST_METHOD, paramData: RequestCommon.init().dictionary) { (data, dictionary, error) in
            let response = RatingWebService.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }

    static func saveRating(params:RatingWebService.RequestAddRating, completionHandler: @escaping ((RatingWebService.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: RatingWebService.saveRatingUrl, methodName: AlamofireHelper.POST_METHOD, paramData: params.toDictionary()) { (data, dictionary, error) in
            let response = RatingWebService.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    
}

