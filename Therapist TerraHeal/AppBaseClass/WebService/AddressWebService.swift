//
//  UserGiveReviewToStore.swift
//  ShoppingApp
//
//  Created by Jaydeep on ""4/11/19.
//  Copyright © 2""19 Jaydeep. All rights reserved.
//

import Foundation

//MARK: Request Models
enum Addresses {
    
    struct RequestAddresslist: Codable {
        var user_id: String = PreferenceHelper.shared.getUserId()
       // var token: String = PreferenceHelper.shared.getSessionToken()
    }
    struct RequestUpdateAddress: Codable {
        var user_id: String = PreferenceHelper.shared.getUserId()
        var address_line_1: String = ""
        var address_line_2: String = ""
        var city: String = ""
        var name: String = ""
        var id: String = ""
        var land_mark: String = ""
        var latitude: String = "22.30"
        var longitude: String = "70.80"
        var pin_code: String = ""
        var province: String = ""
        
    }
    struct RequestDeleteAddress: Codable {
        var user_id: String = PreferenceHelper.shared.getUserId()
        var id: String = ""
    }
    struct RequestAddAddress: Codable {
        var user_id: String = PreferenceHelper.shared.getUserId()
        var address_line_1: String = ""
        var address_line_2: String = ""
        var city: String = ""
        var name: String = ""
        var land_mark: String = ""
        var latitude: String = ""
        var longitude: String = ""
        var pin_code: String = ""
        var province: String = ""
        
    }
    
    
    class Response: ResponseModel {
        var addressList: [Address] = []
        var address: Address = Address.init(fromDictionary: [:])
        override init(fromDictionary dictionary: [String:Any]) {
            super.init(fromDictionary: dictionary)
            addressList.removeAll()
            if let dataArray = dictionary["data"] as? [[String:Any]] {
                for data in dataArray {
                        addressList.append(Address.init(fromDictionary: data))
                }
            } else if let dict = dictionary["data"] as? [String:Any] {
                self.address  = Address.init(fromDictionary: dict)
            }
        }
    }
}

class Address: ResponseModel {
    
    var addressLine1: String = ""
    var addressLine2: String = ""
    var city: String = ""
    var name: String = ""
    var id: String = ""
    var landMark: String = ""
    var latitude: String = ""
    var longitude: String = ""
    var pinCode: String = ""
    var province: String = ""
    var userId: String = ""
    var fullAddress: String = ""
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    override init(fromDictionary dictionary: [String:Any]) {
        super.init(fromDictionary: dictionary)
        self.addressLine1 = (dictionary["address_line_1"] as? String) ?? ""
        self.addressLine2 = (dictionary["address_line_2"] as? String) ?? ""
        self.city = (dictionary["city"] as? String) ?? ""
        self.name = (dictionary["name"] as? String) ?? ""
        self.id = (dictionary["id"] as? String) ?? ""
        self.landMark = (dictionary["land_mark"] as? String) ?? ""
        self.latitude = (dictionary["latitude"] as? String) ?? ""
        self.longitude = (dictionary["longitude"] as? String) ?? ""
        self.pinCode = (dictionary["pin_code"] as? String) ?? ""
        self.province = (dictionary["province"] as? String) ?? ""
        self.userId = (dictionary["user_id"] as? String) ?? ""
    }
    
    func toDictionary() -> [String:Any] {
        var dictionary = [String:Any]()
            dictionary["address_line_1"] = addressLine1
            dictionary["address_line_2"] = addressLine2
            dictionary["city"] = city
            dictionary["name"] = name
            dictionary["id"] = id
            dictionary["land_mark"] = landMark
            dictionary["latitude"] = latitude
            dictionary["longitude"] = longitude
            dictionary["pin_code"] = pinCode
            dictionary["province"] = province
            dictionary["user_id"] = userId
        return dictionary
    }
    
    func toUpdateRequest() -> Addresses.RequestUpdateAddress {
        var addressRequest = Addresses.RequestUpdateAddress()
        addressRequest.address_line_1 =  self.addressLine1
        addressRequest.address_line_2 = self.addressLine2
        addressRequest.city = self.city
        addressRequest.name = self.name
        addressRequest.id = self.id
        addressRequest.land_mark = self.landMark
        addressRequest.latitude = "22.30"//self.latitude
        addressRequest.longitude = "70.80"//self.longitude
        addressRequest.pin_code = self.pinCode
        addressRequest.province = self.province
        return addressRequest
    }
    func toAddRequest() -> Addresses.RequestAddAddress {
        var addressRequest = Addresses.RequestAddAddress()
        addressRequest.address_line_1 =  self.addressLine1
        addressRequest.address_line_2 = self.addressLine2
        addressRequest.city = self.city
        addressRequest.name = self.name
        addressRequest.land_mark = self.landMark
      addressRequest.latitude = "22.30"//self.latitude
        addressRequest.longitude = "70.80"//self.longitude
        addressRequest.pin_code = self.pinCode
        addressRequest.province = self.province
        return addressRequest
    }
}
