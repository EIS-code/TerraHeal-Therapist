//
//  UserGiveReviewToStore.swift
//  ShoppingApp
//
//  Created by Jaydeep on ""4/11/19.
//  Copyright © 2""19 Jaydeep. All rights reserved.
//

import Foundation

//MARK: Request Models
enum User {

    struct RequestProfile: Codable  {
        var user_id: String = PreferenceHelper.shared.getUserId()
       // var token: String = PreferenceHelper.shared.getSessionToken()
        var device_token: String = PreferenceHelper.shared.getDeviceToken()
        var app_version: String = Bundle.appVesion
        var oauth_uid: String = ""
        var oauth_provider: String = LoginBy.Manual

        
        var name: String? = nil
        var surname: String? = nil
        var id_passport: String? = nil
        var nif: String? = nil
        var email: String? = nil
        var phone: String? = nil
        var dob: String? = nil
        var country_id:String? = nil
        var city_id:String? = nil
        var password: String? = nil
        var gender: String? = nil
        var emergency_tel_number: String? = nil
        var emergency_tel_number_code: String? = nil
        var tel_number: String? = nil
        var tel_number_code: String? = nil
        
   }

    struct RequestLogout: Codable {
        var user_id: String = PreferenceHelper.shared.getUserId()
       // var token: String = PreferenceHelper.shared.getSessionToken()
    }

    struct RequestUploadDocument: Codable {
        var id: String = PreferenceHelper.shared.getUserId()
        var type: String = "1"
      //  var token: String = PreferenceHelper.shared.getSessionToken()
    }

    struct RequestChangePassword: Codable {
        var user_id: String = PreferenceHelper.shared.getUserId()
      //  var token: String = PreferenceHelper.shared.getSessionToken()
        var old_password: String = ""
        var new_password: String = ""
    }

    
    struct RequestLogin: Codable {
        var email: String = ""
        var password: String = ""
        var device_token: String = PreferenceHelper.shared.getDeviceToken()
        var device_type: String = Constant.typeIOS
        var app_version: String = Bundle.appVesion
        var oauth_uid: String = ""
        var oauth_provider: String = LoginBy.Manual

    }

    struct RequestRegister: Codable {
        var name: String = ""
        var email: String = ""
        var password: String = ""
        var referral_code:  String = ""
        var tel_number:  String = ""
        var tel_number_code: String = ""
        var device_token: String = PreferenceHelper.shared.getDeviceToken()
        var device_type: String = Constant.typeIOS
        var app_version: String = Bundle.appVesion
        var oauth_uid: String = ""
        var oauth_provider: String = LoginBy.Manual
    }

    struct RequestEmailOTP: Codable {
        var user_id: String = PreferenceHelper.shared.getUserId()
        var email: String = ""
        var device_token: String = PreferenceHelper.shared.getDeviceToken()
        var device_type: String = Constant.typeIOS
        var app_version: String = Bundle.appVesion
    }

    struct RequestVerifyEmailOTP: Codable {
        var user_id: String = PreferenceHelper.shared.getUserId()
        var otp: String = ""
        var device_token: String = PreferenceHelper.shared.getDeviceToken()
        var device_type: String = Constant.typeIOS
        var app_version: String = Bundle.appVesion
    }

    struct RequestPhoneOTP: Codable {
        var user_id: String = PreferenceHelper.shared.getUserId()
        var mobile: String = ""
        var device_token: String = PreferenceHelper.shared.getDeviceToken()
        var device_type: String = Constant.typeIOS
        var app_version: String = Bundle.appVesion
    }

    struct RequestVerifyPhoneOTP: Codable {
        var user_id: String = PreferenceHelper.shared.getUserId()
        var otp: String = ""
        var device_token: String = PreferenceHelper.shared.getDeviceToken()
        var device_type: String = Constant.typeIOS
        var app_version: String = Bundle.appVesion
    }



}

//MARK: Response Models
extension User {

    class ResponseVerification :  ResponseModel {

        var data : Any? = nil

        override init(fromDictionary dictionary: [String:Any]) {
            super.init(fromDictionary: dictionary)
           
            data = dictionary["data"] as? [String:Any]
        }

    }

    class Response :  Codable {
        var code : String = ""
        var data : UserData
        var message : String = ""

        init(fromDictionary dictionary: [String:Any]) {
            self.code = (dictionary["code"] as? String) ?? ""
            self.message = (dictionary["msg"] as? String) ?? ""
            data = UserData.init(fromDictionary: [:])
            if let dictData = dictionary["data"] as? [String:Any] {
                self.data = UserData.init(fromDictionary: dictData)
            }
        }

        @objc required init(coder aDecoder: NSCoder) {
            code = (aDecoder.decodeObject(forKey: "code") as? String) ?? ""
            data = aDecoder.decodeObject(forKey :"data") as? UserData ?? UserData.init(fromDictionary: [:])
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
            dictionary["data"] = data.toDictionary()
            dictionary["msg"] = message
            return dictionary
        }

    }

    class UserData: Codable {
        var address : String = ""
        var appVersion : String = ""
        var avatar : String = ""
        var avatarOriginal : String = ""
        var city : City = City(fromDictionary: [:])
        var cityId : String = ""
        var country : Country = Country(fromDictionary: [:])
        var countryId : String = ""
        var createdAt : String = ""
        var deviceToken : String = ""
        var deviceType : String = ""
        var dob : String = ""
        var email : String = ""
        var emergencyTelNumber : String = ""
        var emergencyTelNumberCode : String = ""
        var gender : String = ""
        var id : String = ""
        var idPassport : String = ""
        var isDeleted : String = ""
        var isDocumentVerified : String = ""
        var isEmailVerified : String = ""
        var isMobileVerified : String = ""
        var name : String = ""
        var nif : String = ""
        var oauthProvider : String = ""
        var oauthUid : String = ""
        var profilePhoto : String = ""
        var referralCode : String = ""
        var shopId : String = ""
        var surname : String = ""
        var telNumber : String = ""
        var telNumberCode : String = ""
        var updatedAt : String = ""

        
        init(fromDictionary dictionary: [String:Any]) {
            self.address = (dictionary["address"] as? String) ?? ""
            self.appVersion = (dictionary["app_version"] as? String) ?? ""
            self.avatar = (dictionary["avatar"] as? String) ?? ""
            self.avatarOriginal = (dictionary["avatar_original"] as? String) ?? ""
            self.countryId = (dictionary["country_id"] as? String) ?? ""
            self.createdAt = (dictionary["created_at"] as? String) ?? ""
            self.deviceToken = (dictionary["device_token"] as? String) ?? ""
            self.deviceType = (dictionary["device_type"] as? String) ?? ""
            self.dob = (dictionary["dob"] as? String) ?? ""
            self.email = (dictionary["email"] as? String) ?? ""
            self.emergencyTelNumber = (dictionary["emergency_tel_number"] as? String) ?? ""
            self.emergencyTelNumberCode = (dictionary["emergency_tel_number_code"] as? String) ?? ""
            self.gender = (dictionary["gender"] as? String) ?? ""
            self.id = (dictionary["id"] as? String) ?? ""
            self.idPassport = (dictionary["id_passport"] as? String) ?? ""
            self.isDeleted = (dictionary["is_deleted"] as? String) ?? ""
            self.isDocumentVerified = (dictionary["is_document_verified"] as? String) ?? ""
            self.isEmailVerified = (dictionary["is_email_verified"] as? String) ?? ""
            self.isMobileVerified = (dictionary["is_mobile_verified"] as? String) ?? ""
            self.name = (dictionary["name"] as? String) ?? ""
            self.nif = (dictionary["nif"] as? String) ?? ""
            self.oauthProvider = (dictionary["oauth_provider"] as? String) ?? ""
            self.oauthUid = (dictionary["oauth_uid"] as? String) ?? ""
            self.profilePhoto = (dictionary["profile_photo"] as? String) ?? ""
            self.referralCode = (dictionary["referral_code"] as? String) ?? ""
            self.shopId = (dictionary["shop_id"] as? String) ?? ""
            self.surname = (dictionary["surname"] as? String) ?? ""
            self.telNumber = (dictionary["tel_number"] as? String) ?? ""
            self.telNumberCode = (dictionary["tel_number_code"] as? String) ?? ""
            self.updatedAt = (dictionary["updated_at"] as? String) ?? ""
            self.cityId = (dictionary["city_id"] as? String) ?? ""
            
            if let cityData = dictionary["city"] as? [String:Any]{
                city = City(fromDictionary: cityData)
            }
            
            if let countryData = dictionary["country"] as? [String:Any]{
                country = Country(fromDictionary: countryData)
            }
            
        }

        func getDob() ->  String {
            return Date.milliSecToDate(milliseconds: appSingleton.user.dob.toDouble, format: DateFormat.DOB)
        }
        @objc required init(coder aDecoder: NSCoder) {
            self.address = (aDecoder.decodeObject(forKey: "address") as? String) ?? ""
            self.appVersion = (aDecoder.decodeObject(forKey: "app_version") as? String) ?? ""
            self.avatar = (aDecoder.decodeObject(forKey: "avatar") as? String) ?? ""
            self.avatarOriginal = (aDecoder.decodeObject(forKey: "avatar_original") as? String) ?? ""
            self.city = (aDecoder.decodeObject(forKey: "city") as? City) ?? City(fromDictionary: [:])
            self.cityId = (aDecoder.decodeObject(forKey: "city_id") as? String) ?? ""
            self.country = (aDecoder.decodeObject(forKey: "country") as? Country) ?? Country(fromDictionary: [:])
            self.countryId = (aDecoder.decodeObject(forKey: "country_id") as? String) ?? ""
            self.createdAt = (aDecoder.decodeObject(forKey: "created_at") as? String) ?? ""
            self.deviceToken = (aDecoder.decodeObject(forKey: "device_token") as? String) ?? ""
            self.deviceType = (aDecoder.decodeObject(forKey: "device_type") as? String) ?? ""
            self.dob = (aDecoder.decodeObject(forKey: "dob") as? String) ?? ""
            self.email = (aDecoder.decodeObject(forKey: "email") as? String) ?? ""
            self.emergencyTelNumber = (aDecoder.decodeObject(forKey: "emergency_tel_number") as? String) ?? ""
            self.emergencyTelNumberCode = (aDecoder.decodeObject(forKey: "emergency_tel_number_code") as? String) ?? ""
            self.gender = (aDecoder.decodeObject(forKey: "gender") as? String) ?? ""
            self.id = (aDecoder.decodeObject(forKey: "id") as? String) ?? ""
            self.idPassport = (aDecoder.decodeObject(forKey: "id_passport") as? String) ?? ""
            self.isDeleted = (aDecoder.decodeObject(forKey: "is_deleted") as? String) ?? ""
            self.isDocumentVerified = (aDecoder.decodeObject(forKey: "is_document_verified") as? String) ?? ""
            self.isEmailVerified = (aDecoder.decodeObject(forKey: "is_email_verified") as? String) ?? ""
            self.isMobileVerified = (aDecoder.decodeObject(forKey: "is_mobile_verified") as? String) ?? ""
            self.name = (aDecoder.decodeObject(forKey: "name") as? String) ?? ""
            self.nif = (aDecoder.decodeObject(forKey: "nif") as? String) ?? ""
            self.oauthProvider = (aDecoder.decodeObject(forKey: "oauth_provider") as? String) ?? ""
            self.oauthUid = (aDecoder.decodeObject(forKey: "oauth_uid") as? String) ?? ""
            self.profilePhoto = (aDecoder.decodeObject(forKey: "profile_photo") as? String) ?? ""
            self.referralCode = (aDecoder.decodeObject(forKey: "referral_code") as? String) ?? ""
            self.shopId = (aDecoder.decodeObject(forKey: "shop_id") as? String) ?? ""
            self.surname = (aDecoder.decodeObject(forKey: "surname") as? String) ?? ""
            self.telNumber = (aDecoder.decodeObject(forKey: "tel_number") as? String) ?? ""
            self.telNumberCode = (aDecoder.decodeObject(forKey: "tel_number_code") as? String) ?? ""
            self.updatedAt = (aDecoder.decodeObject(forKey: "updated_at") as? String) ?? ""

        }

        @objc func encode(with aCoder: NSCoder) {
                aCoder.encode(address, forKey: "address")
                aCoder.encode(appVersion, forKey: "app_version")
                aCoder.encode(avatar, forKey: "avatar")
                aCoder.encode(avatarOriginal, forKey: "avatar_original")
                aCoder.encode(city, forKey: "city")
                aCoder.encode(cityId, forKey: "city_id")
                aCoder.encode(country, forKey: "country")
                aCoder.encode(countryId, forKey: "country_id")
                aCoder.encode(createdAt, forKey: "created_at")
                aCoder.encode(deviceToken, forKey: "device_token")
                aCoder.encode(deviceType, forKey: "device_type")
                aCoder.encode(dob, forKey: "dob")
                aCoder.encode(email, forKey: "email")
                aCoder.encode(emergencyTelNumber, forKey: "emergency_tel_number")
                aCoder.encode(emergencyTelNumberCode, forKey: "emergency_tel_number_code")
                aCoder.encode(gender, forKey: "gender")
                aCoder.encode(id, forKey: "id")
                aCoder.encode(idPassport, forKey: "id_passport")
                aCoder.encode(isDeleted, forKey: "is_deleted")
                aCoder.encode(isDocumentVerified, forKey: "is_document_verified")
                aCoder.encode(isEmailVerified, forKey: "is_email_verified")
                aCoder.encode(isMobileVerified, forKey: "is_mobile_verified")
                aCoder.encode(name, forKey: "name")
                aCoder.encode(nif, forKey: "nif")
                aCoder.encode(oauthProvider, forKey: "oauth_provider")
                aCoder.encode(oauthUid, forKey: "oauth_uid")
                aCoder.encode(profilePhoto, forKey: "profile_photo")
                aCoder.encode(referralCode, forKey: "referral_code")
                aCoder.encode(shopId, forKey: "shop_id")
                aCoder.encode(surname, forKey: "surname")
                aCoder.encode(telNumber, forKey: "tel_number")
                aCoder.encode(telNumberCode, forKey: "tel_number_code")
                aCoder.encode(updatedAt, forKey: "updated_at")
        }

        func toDictionary() -> [String:Any] {
                var dictionary = [String:Any]()
                dictionary["address"] = address
                dictionary["app_version"] = appVersion
                dictionary["avatar"] = avatar
                dictionary["avatar_original"] = avatarOriginal
                dictionary["city"] = city.toDictionary()
                dictionary["city_id"] = cityId
                dictionary["country"] = country.toDictionary()
                dictionary["country_id"] = countryId
                dictionary["created_at"] = createdAt
                dictionary["device_token"] = deviceToken
                dictionary["device_type"] = deviceType
                dictionary["dob"] = dob
                dictionary["email"] = email
                dictionary["emergency_tel_number"] = emergencyTelNumber
                dictionary["emergency_tel_number_code"] = emergencyTelNumberCode
                dictionary["gender"] = gender
                dictionary["id"] = id
                dictionary["id_passport"] = idPassport
                dictionary["is_deleted"] = isDeleted
                dictionary["is_document_verified"] = isDocumentVerified
                dictionary["is_email_verified"] = isEmailVerified
                dictionary["is_mobile_verified"] = isMobileVerified
                dictionary["name"] = name
                dictionary["nif"] = nif
                dictionary["oauth_provider"] = oauthProvider
                dictionary["oauth_uid"] = oauthUid
                dictionary["profile_photo"] = profilePhoto
                dictionary["referral_code"] = referralCode
                dictionary["shop_id"] = shopId
                dictionary["surname"] = surname
                dictionary["tel_number"] = telNumber
                dictionary["tel_number_code"] = telNumberCode
                dictionary["updated_at"] = updatedAt
                return dictionary
        }

        func isContactVerified() -> Bool {
            return self.isMobileVerified.toBool && self.isEmailVerified.toBool
        }
        
        func getGenderName() -> String {
            return Gender.init(rawValue: self.gender)?.name() ?? Gender.Male.name()
        }
        
    }

}

