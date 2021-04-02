//
//  UserGiveReviewToStore.swift
//  ShoppingApp
//
//  Created by Jaydeep on ""4/11/19.
//  Copyright © 2""19 Jaydeep. All rights reserved.
//

import Foundation

//MARK: Request Models
class ExchangeWithOtherWebService {
    static let exchangeURL: String = API_URL.ExchangeWithOther
    static let therapistListURL: String = API_URL.GetTherapistList
    struct RequestToTherapistList: Codable {
        var name: String = ""
    }
}



//MARK: Response Models
extension ExchangeWithOtherWebService {
    class TherapistListResponse :  ResponseModel {
        var therapistList: [TherapistData] = []
        override init(fromDictionary dictionary: [String:Any]) {
            super.init(fromDictionary: dictionary)
            therapistList.removeAll()
            if let dataArray = dictionary["data"] as? [[String:Any]] {
                for data in dataArray {
                    therapistList.append(TherapistData.init(fromDictionary: data))
                }
            }
        }
    }
}

class TherapistData {
    var email: String = ""
    var id: String = ""
    var name: String = ""
    var profilePhoto: String = ""


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        self.email = (dictionary["email"] as? String) ?? ""
        self.id = (dictionary["id"] as? String) ?? ""
        self.name = (dictionary["name"] as? String) ?? ""
        self.profilePhoto = (dictionary["profile_photo"] as? String) ?? ""
    }


}

//MARK: WebServiceCall
extension ExchangeWithOtherWebService {
    static func requestToAbsent(params: AbsentDayWebService.RequestToAbsent ,completionHandler: @escaping ((ResponseModel) -> Void)) {

        AlamofireHelper().getDataFrom(urlString: Self.exchangeURL, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = ResponseModel.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    static func requestToGetTherapistList(params: ExchangeWithOtherWebService.RequestToTherapistList ,completionHandler: @escaping ((TherapistListResponse) -> Void)) {

        AlamofireHelper().getDataFrom(urlString: Self.therapistListURL, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = TherapistListResponse.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
}
