//
//  UserGiveReviewToStore.swift
//  ShoppingApp
//
//  Created by Jaydeep on ""4/11/19.
//  Copyright © 2""19 Jaydeep. All rights reserved.
//

import Foundation

enum User {

    struct RequestProfile: Codable  {
        var id: String = PreferenceHelper.shared.getUserId()
        var token: String = PreferenceHelper.shared.getSessionToken()
        var device_token: String = PreferenceHelper.shared.getDeviceToken()
        var app_version: String = Bundle.appVesion
        var oauth_uid: String = ""
        var oauth_provider: String = LoginBy.Manual

        var name: String? = nil
        var email: String? = nil
        var phone: String? = nil
        var password: String? = nil

    }

    struct RequestLogout: Codable {
        var id: String = PreferenceHelper.shared.getUserId()
        var token: String = PreferenceHelper.shared.getSessionToken()
    }

    struct RequestUploadDocument: Codable {
        var id: String = PreferenceHelper.shared.getUserId()
        var type: String = "1"
        var token: String = PreferenceHelper.shared.getSessionToken()
    }
    struct RequestLogin: Codable {
        var email: String = ""
        var password: String = ""
        var device_token: String = PreferenceHelper.shared.getDeviceToken()
        var app_version: String = Bundle.appVesion
        var oauth_uid: String = ""
        var oauth_provider: String = LoginBy.Manual

    }

    struct RequestRegister: Codable {
        var name: String = ""
        var email: String = ""
        var password: String = ""
        var device_token: String = PreferenceHelper.shared.getDeviceToken()
        var app_version: String = Bundle.appVesion
        var oauth_uid: String = ""
        var oauth_provider: String = LoginBy.Manual

    }

    class Response :  Codable {
        var code : String = ""
        var data : [UserData]!
        var message : String!

        init(fromDictionary dictionary: [String:Any]) {
            self.code = (dictionary["code"] as? String) ?? ""
            self.message = (dictionary["msg"] as? String) ?? ""
            data = []
            if let dataArray = dictionary["data"] as? [[String:Any]] {
                for dic in dataArray {
                    let value = UserData.init(fromDictionary: dic)
                    data.append(value)
                }
            }
        }

        @objc required init(coder aDecoder: NSCoder) {
            code = (aDecoder.decodeObject(forKey: "code") as? String) ?? ""
            data = aDecoder.decodeObject(forKey :"data") as? [UserData]
            message = (aDecoder.decodeObject(forKey: "msg") as? String) ?? ""
        }

        @objc func encode(with aCoder: NSCoder) {
            aCoder.encode(code, forKey: "code")
            aCoder.encode(data, forKey: "data")
            aCoder.encode(message, forKey: "msg")
        }

        func toDictionary() -> [String:Any] {
            var dictionary = [String:Any]()
            dictionary["code"] = code
            var dictionaryElements = [[String:Any]]()
            for dataElement in data {
                dictionaryElements.append(dataElement.toDictionary())
            }
            dictionary["data"] = dictionaryElements
            dictionary["msg"] = message
            return dictionary
        }

    }

    class UserData: Codable {
        var createdAt : String = ""
        var dob : String = ""
        var email : String = ""
        var gender : String = ""
        var hobbies : String = ""
        var id : String = ""
        var isDeleted : String = ""
        var isFreelancer : String = ""
        var name : String = ""
        var paidPercentage : String = ""
        var password : String = ""
        var shopId : String = ""
        var shortDescription : String = ""
        var telNumber : String = ""
        var updatedAt : String = ""
        init(fromDictionary dictionary: [String:Any]){
            self.createdAt = (dictionary["created_at"] as? String) ??  ""
            self.dob = (dictionary["dob"] as? String) ??  ""
            self.email = (dictionary["email"] as? String) ??  ""
            self.gender = (dictionary["gender"] as? String) ??  ""
            self.hobbies = (dictionary["hobbies"] as? String) ??  ""
            self.id = (dictionary["id"] as? String) ??  ""
            self.isDeleted = (dictionary["is_deleted"] as? String) ??  ""
            self.isFreelancer = (dictionary["is_freelancer"] as? String) ??  ""
            self.name = (dictionary["name"] as? String) ??  ""
            self.paidPercentage = (dictionary["paid_percentage"] as? String) ??  ""
            self.password = (dictionary["password"] as? String) ??  ""
            self.shopId = (dictionary["shop_id"] as? String) ??  ""
            self.shortDescription = (dictionary["short_description"] as? String) ??  ""
            self.telNumber = (dictionary["tel_number"] as? String) ??  ""
            self.updatedAt = (dictionary["updated_at"] as? String) ??  ""
        }

        @objc required init(coder aDecoder: NSCoder) {
            self.createdAt = (aDecoder.decodeObject(forKey: "created_at") as? String) ?? ""
            self.dob = (aDecoder.decodeObject(forKey: "dob") as? String) ?? ""
            self.email = (aDecoder.decodeObject(forKey: "email") as? String) ?? ""
            self.gender = (aDecoder.decodeObject(forKey: "gender") as? String) ?? ""
            self.hobbies = (aDecoder.decodeObject(forKey: "hobbies") as? String) ?? ""
            self.id = (aDecoder.decodeObject(forKey: "id") as? String) ?? ""
            self.isDeleted = (aDecoder.decodeObject(forKey: "is_deleted") as? String) ?? ""
            self.isFreelancer = (aDecoder.decodeObject(forKey: "is_freelancer") as? String) ?? ""
            self.name = (aDecoder.decodeObject(forKey: "name") as? String) ?? ""
            self.paidPercentage = (aDecoder.decodeObject(forKey: "paid_percentage") as? String) ?? ""
            self.password = (aDecoder.decodeObject(forKey: "password") as? String) ?? ""
            self.shopId = (aDecoder.decodeObject(forKey: "shop_id") as? String) ?? ""
            self.shortDescription = (aDecoder.decodeObject(forKey: "short_description") as? String) ?? ""
            self.telNumber = (aDecoder.decodeObject(forKey: "tel_number") as? String) ?? ""
            self.updatedAt = (aDecoder.decodeObject(forKey: "updated_at") as? String) ?? ""

        }

        @objc func encode(with aCoder: NSCoder) {
            aCoder.encode(createdAt, forKey: "created_at")
            aCoder.encode(dob, forKey: "dob")
            aCoder.encode(email, forKey: "email")
            aCoder.encode(gender, forKey: "gender")
            aCoder.encode(hobbies, forKey: "hobbies")
            aCoder.encode(id, forKey: "id")
            aCoder.encode(isDeleted, forKey: "is_deleted")
            aCoder.encode(isFreelancer, forKey: "is_freelancer")
            aCoder.encode(name, forKey: "name")
            aCoder.encode(paidPercentage, forKey: "paid_percentage")
            aCoder.encode(password, forKey: "password")
            aCoder.encode(shopId, forKey: "shop_id")
            aCoder.encode(shortDescription, forKey: "short_description")
            aCoder.encode(telNumber, forKey: "tel_number")
            aCoder.encode(updatedAt, forKey: "updated_at")
        }

        func toDictionary() -> [String:Any] {
            var dictionary = [String:Any]()
            dictionary["created_at"] = createdAt
            dictionary["dob"] = dob
            dictionary["email"] = email
            dictionary["gender"] = gender
            dictionary["hobbies"] = hobbies
            dictionary["id"] = id
            dictionary["is_deleted"] = isDeleted
            dictionary["is_freelancer"] = isFreelancer
            dictionary["name"] = name
            dictionary["paid_percentage"] = paidPercentage
            dictionary["password"] = password
            dictionary["shop_id"] = shopId
            dictionary["short_description"] = shortDescription
            dictionary["tel_number"] = telNumber
            dictionary["updated_at"] = updatedAt
            return dictionary
        }
    }
}

