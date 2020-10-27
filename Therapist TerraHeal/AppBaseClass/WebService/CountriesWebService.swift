//
//  UserGiveReviewToStore.swift
//  ShoppingApp
//
//  Created by Jaydeep on ""4/11/19.
//  Copyright © 2""19 Jaydeep. All rights reserved.
//

import Foundation

//MARK: Request Models
enum Countries {
    
    struct RequestCountrylist: Codable {
        var id: String = PreferenceHelper.shared.getUserId()
       // var token: String = PreferenceHelper.shared.getSessionToken()
    }
    
    
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



class Country: Codable {
    
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
    
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        dictionary["created_at"] = createdAt
        dictionary["id"] = id
        dictionary["iso3"] = iso3
        dictionary["name"] = name
        dictionary["short_name"] = shortName
        dictionary["updated_at"] = updatedAt
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        self.createdAt = (aDecoder.decodeObject(forKey: "created_at") as? String) ?? ""
        self.id = (aDecoder.decodeObject(forKey: "id") as? String) ?? ""
        self.iso3 = (aDecoder.decodeObject(forKey: "iso3") as? String) ?? ""
        self.name = (aDecoder.decodeObject(forKey: "name") as? String) ?? ""
        self.shortName = (aDecoder.decodeObject(forKey: "short_name") as? String) ?? ""
        self.updatedAt = (aDecoder.decodeObject(forKey: "updated_at") as? String) ?? ""
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
            aCoder.encode(createdAt, forKey: "created_at")
            aCoder.encode(id, forKey: "id")
            aCoder.encode(iso3, forKey: "iso3")
            aCoder.encode(name, forKey: "name")
            aCoder.encode(shortName, forKey: "short_name")
            aCoder.encode(updatedAt, forKey: "updated_at")
        
    }
    static func getDemoArray() -> [Country] {
        var arrForCountries: [Country] = []
        arrForCountries.removeAll()
        for i in 0...15 {
            
            let country: Country = Country.init(fromDictionary: [:])
            country.name = "Coutry - \(i)"
            if i % 2 == 0 {
                country.name = "Abcd - \(i)"
            }
            arrForCountries.append(country)
        }
        return arrForCountries
    }


}
