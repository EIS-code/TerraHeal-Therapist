//
//  UserGiveReviewToStore.swift
//  ShoppingApp
//
//  Created by Jaydeep on ""4/11/19.
//  Copyright © 2""19 Jaydeep. All rights reserved.
//

import Foundation

//MARK: Request Models
class CountryWebService {
    static let url: String = API_URL.GetCountryList
    class Response: ResponseModel {
        var countryList: [Country] = []
        override init(fromDictionary dictionary: [String:Any]) {
            super.init(fromDictionary: dictionary)
            countryList.removeAll()
            if let dataArray = dictionary["data"] as? [[String:Any]] {
                for data in dataArray {
                    countryList.append(Country.init(fromDictionary: data))
                }
            }
        }
    }
    
    
}



class Country {
    
    var createdAt: String = ""
    var id: String = ""
    var iso3: String = ""
    var name: String = ""
    var shortName: String = ""
    var updatedAt: String = ""
    var isSelected: Bool = false
    
    /**s
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    
    init(fromDictionary dictionary: [String:Any]) {
        self.createdAt = (dictionary["created_at"] as? String) ?? ""
        self.id = (dictionary["id"] as? String) ?? ""
        self.iso3 = (dictionary["iso3"] as? String) ?? ""
        self.name = (dictionary["name"] as? String) ?? ""
        self.shortName = (dictionary["short_name"] as? String) ?? ""
        self.updatedAt = (dictionary["updated_at"] as? String) ?? ""
    }
}

//MARK: WebServiceCall
extension CountryWebService {
    static func getAllCountries(completionHandler: @escaping ((CountryWebService.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: Self.url, methodName: AlamofireHelper.GET_METHOD, paramData: [:]) { (data, dictionary, error) in
            let response = CountryWebService.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
}
