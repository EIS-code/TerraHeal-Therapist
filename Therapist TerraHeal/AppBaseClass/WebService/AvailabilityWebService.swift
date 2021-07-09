//
//  UserGiveReviewToStore.swift
//  ShoppingApp
//
//  Created by Jaydeep on ""4/11/19.
//  Copyright © 2""19 Jaydeep. All rights reserved.
//

import Foundation

class AvailabilityWebService {
    static let getAvailibilityUrl: String = API_URL.GetAvailability
    struct RequestGetAvailability: Codable {
        var id: String = PreferenceHelper.shared.getUserId()
        var date: String = ""
    }

}

//MARK: Response Models
extension AvailabilityWebService {
    class Response :  ResponseModel {
        var availabilityData: AvailabilityData = AvailabilityData.init(fromDictionary: [:])
        var availabilityList: [AvailabilityData] = []
        override init(fromDictionary dictionary: [String:Any]) {
            super.init(fromDictionary: dictionary)
            if let dataArray = dictionary["data"] as? [[String:Any]] {
                for dataDict in dataArray {
                    availabilityData = AvailabilityData.init(fromDictionary: dataDict)
                    availabilityList.append(availabilityData)
                }
            }
            else if let data = dictionary["data"] as? [String:Any] {
                availabilityData = AvailabilityData.init(fromDictionary: data)
                availabilityList.append(availabilityData)
            }
        }
    }
}

class AvailabilityData {
    var featuredImage: String = ""
    var shiftDate: String = ""
    var shifts: [Shift] = []
    var shopId: String = ""
    var shopName: String = ""
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        self.featuredImage = (dictionary["featured_image"] as? String) ?? ""
        self.shiftDate = (dictionary["shift_date"] as? String) ?? ""
        self.shifts = [Shift]()
        if let shiftsArray = dictionary["shifts"] as? [[String:Any]]{
            for dic in shiftsArray{
                let value = Shift(fromDictionary: dic)
                shifts.append(value)
            }
        }
        self.shopId = (dictionary["shop_id"] as? String) ?? ""
        self.shopName = (dictionary["shop_name"] as? String) ?? ""

    }

}


//MARK: Web Service Calls
extension AvailabilityWebService {
    static func getAvailabilities(params:AvailabilityWebService.RequestGetAvailability, completionHandler: @escaping ((AvailabilityWebService.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: Self.getAvailibilityUrl, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = AvailabilityWebService.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    
}

