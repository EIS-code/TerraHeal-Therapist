//
//  UserGiveReviewToStore.swift
//  ShoppingApp
//
//  Created by Jaydeep on ""4/11/19.
//  Copyright © 2""19 Jaydeep. All rights reserved.
//

import Foundation

//MARK: Request Models
class CityWebService {
    static let url: String = API_URL.GetCityList
    struct RequestCityList: Codable {
        var country_id: String = ""
    }
    class Response: ResponseModel {
        var cityList: [City] = []
        override init(fromDictionary dictionary: [String:Any]) {
            super.init(fromDictionary: dictionary)
            cityList.removeAll()
            if let dataArray = dictionary["data"] as? [[String:Any]] {
                for data in dataArray {
                    cityList.append(City.init(fromDictionary: data))
                }
            }
        }
    }


}

class City: Codable {
    
    var id: String = ""
    var provinceId: String = ""
    var name: String = ""
    var isSelected:Bool = false
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
     init(fromDictionary dictionary: [String:Any]) {
        self.id = (dictionary["id"] as? String) ?? ""
        self.provinceId = (dictionary["province_id"] as? String) ?? ""
        self.name = (dictionary["name"] as? String) ?? ""
    }
}
//MARK: WebServiceCall
extension CityWebService {
    static func getAllCities(params:CityWebService.RequestCityList, completionHandler: @escaping ((CityWebService.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: Self.url, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = CityWebService.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
}
