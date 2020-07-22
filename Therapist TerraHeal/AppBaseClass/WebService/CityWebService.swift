//
//  UserGiveReviewToStore.swift
//  ShoppingApp
//
//  Created by Jaydeep on ""4/11/19.
//  Copyright © 2""19 Jaydeep. All rights reserved.
//

import Foundation

//MARK: Request Models
enum Cities {
    
    struct RequestCitylist: Codable {
        var id: String = PreferenceHelper.shared.getUserId()
      //  var token: String = PreferenceHelper.shared.getSessionToken()
        var country_id: String = ""
    }
    
    
    class Response: ResponseModel {
        var cityList: [City] = []
        override init(fromDictionary dictionary: [String:Any]) {
            super.init(fromDictionary: dictionary)
            cityList.removeAll()
            if let dataArray = dictionary["data"] as? [[[String:Any]]] {
                for data in dataArray {
                    for city in data {
                        cityList.append(City.init(fromDictionary: city))
                    }
                }
            }
        }
    }
}

class City: Codable {
    
    var createdAt: String = ""
    var id: String = ""
    var provinceId: String = ""
    var name: String = ""
    var updatedAt: String = ""
    var isSelected:Bool = false
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
     init(fromDictionary dictionary: [String:Any]) {
        self.createdAt = (dictionary["created_at"] as? String) ?? ""
        self.id = (dictionary["id"] as? String) ?? ""
        self.provinceId = (dictionary["province_id"] as? String) ?? ""
        self.name = (dictionary["name"] as? String) ?? ""
        self.updatedAt = (dictionary["updated_at"] as? String) ?? ""
    }
    
    func toDictionary() -> [String:Any] {
        var dictionary = [String:Any]()
        dictionary["created_at"] = createdAt
        dictionary["id"] = id
        dictionary["name"] = name
        dictionary["province_id"] = provinceId
        dictionary["updated_at"] = updatedAt
        return dictionary
    }
    
    @objc required init(coder aDecoder: NSCoder)
    {
        self.createdAt = (aDecoder.decodeObject(forKey: "created_at") as? String) ?? ""
        self.id = (aDecoder.decodeObject(forKey: "id") as? String) ?? ""
        self.name = (aDecoder.decodeObject(forKey: "name") as? String) ?? ""
        self.provinceId = (aDecoder.decodeObject(forKey: "province_id") as? String) ?? ""
        self.updatedAt = (aDecoder.decodeObject(forKey: "updated_at") as? String) ?? ""
        
    }
    
    @objc func encode(with aCoder: NSCoder)
    {
        aCoder.encode(createdAt, forKey: "created_at")
        aCoder.encode(id, forKey: "id")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(provinceId, forKey: "province_id")
        aCoder.encode(updatedAt, forKey: "updated_at")
    }
    
    static func getDemoArray() -> [City] {
        var arrForCities: [City] = []
        arrForCities.removeAll()
        for i in 0...15 {
            
            let country: City = City.init(fromDictionary: [:])
            country.name = "City - \(i)"
            if i % 2 == 0 {
                country.name = "Abcd - \(i)"
            }
            arrForCities.append(country)
        }
        return arrForCities
    }
}
