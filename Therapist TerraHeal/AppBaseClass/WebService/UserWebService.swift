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
        var id: String = PreferenceHelper.shared.getUserId()
       // var token: String = PreferenceHelper.shared.getSessionToken()
        var device_token: String = PreferenceHelper.shared.getDeviceToken()
        var app_version: String = Bundle.appVesion
        var oauth_uid: String = ""
        var oauth_provider: String = LoginBy.Manual

        var name: String? = nil
        var email: String? = nil
        var phone: String? = nil
        var dob: String? = nil
        var password: String? = nil
        var gender: String? = nil
        var tel_number: String? = nil
        var hobbies: String? = nil
        var short_description: String? = nil
        var selected_therapies: [String] = []
        var selected_massages: [String] = []
        var paid_percentage: String? = nil
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
        var device_type: String = Constant.typeIOS
        var app_version: String = Bundle.appVesion
        var oauth_uid: String = ""
        var oauth_provider: String = LoginBy.Manual

    }

    struct RequestRegister: Codable {
        var name: String = ""
        var email: String = ""
        var password: String = ""
        var device_token: String = PreferenceHelper.shared.getDeviceToken()
        var device_type: String = Constant.typeIOS
        var app_version: String = Bundle.appVesion
        var oauth_uid: String = ""
        var oauth_provider: String = LoginBy.Manual
    }

    struct RequestEmailOTP: Codable {
        var email: String = ""
        var device_token: String = PreferenceHelper.shared.getDeviceToken()
        var device_type: String = Constant.typeIOS
        var app_version: String = Bundle.appVesion
    }

    struct RequestVerifyEmailOTP: Codable {
        var otp: String = ""
        var device_token: String = PreferenceHelper.shared.getDeviceToken()
        var device_type: String = Constant.typeIOS
        var app_version: String = Bundle.appVesion
    }

    struct RequestPhoneOTP: Codable {
        var mobile: String = ""
        var device_token: String = PreferenceHelper.shared.getDeviceToken()
        var device_type: String = Constant.typeIOS
        var app_version: String = Bundle.appVesion
    }

    struct RequestVerifyPhoneOTP: Codable {
        var otp: String = ""
        var device_token: String = PreferenceHelper.shared.getDeviceToken()
        var device_type: String = Constant.typeIOS
        var app_version: String = Bundle.appVesion
    }



}

//MARK: Response Models
extension User {

    class ResponseVerification:  ResponseModel {

        var data: Any? = nil

        override init(fromDictionary dictionary: [String:Any]) {
            super.init(fromDictionary: dictionary)
            data = dictionary["data"] as? [String:Any]
        }

    }

    class Response:  Codable {
        var code: String = ""
        var data: [UserData]!
        var message: String = ""

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
            else if let dataArray = dictionary["data"] as? [String:Any] {
                    let value = UserData.init(fromDictionary: dataArray)
                    data.append(value)
            }
        }

        @objc required init(coder aDecoder: NSCoder) {
            code = (aDecoder.decodeObject(forKey: "code") as? String) ?? ""
            data = aDecoder.decodeObject(forKey:"data") as? [UserData]
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
        var createdAt: String = ""
        var dob: String = ""
        var email: String = ""
        var gender: String = ""
        var hobbies: String = ""
        var id: String = ""
        var isDeleted: String = ""
        var isFreelancer: String = ""
        var name: String = ""
        var paidPercentage: String = ""
        var password: String = ""
        var shopId: String = ""
        var shortDescription: String = ""
        var telNumber: String = ""
        var updatedAt: String = ""
        var isMobileVerified: String = ""
        var isEmailVerified: String = ""
        var isDocumentVerified: String = ""
        var isPaymentDetailAdded: String = ""
        var selectedMassages: [String] = []
        var selectedTherapies: [String] = []

        var selected_massages: [SelectedMassage] = []
        var selected_therapies: [SelectedTherapies] = []


        init(fromDictionary dictionary: [String:Any]) {
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
            self.isMobileVerified = (dictionary["is_mobile_verified"] as? String) ??  ""
            self.isEmailVerified = (dictionary["is_email_verified"] as? String) ??  ""
            self.isDocumentVerified = (dictionary["is_document_verified"] as? String) ??  ""
            self.updatedAt = (dictionary["updated_at"] as? String) ??  ""

            if let selectedMsgs = dictionary["selected_massages"] as? [[String:Any]] {
                for data in selectedMsgs {
                    let item = SelectedMassage.init(fromDictionary: data)
                    self.selected_massages.append(item)
                    self.selectedMassages.append(item.massageId)
                }
            }
            if let selectedMsgs = dictionary["selected_therapies"] as? [[String:Any]] {
                for data in selectedMsgs {
                    let item = SelectedTherapies.init(fromDictionary: data)
                    self.selected_therapies.append(item)
                    self.selectedTherapies.append(item.therapyId)
                }
            }
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
            self.isMobileVerified = (aDecoder.decodeObject(forKey: "is_mobile_verified") as? String) ?? ""
            self.isEmailVerified = (aDecoder.decodeObject(forKey: "is_email_verified") as? String) ?? ""
            self.isDocumentVerified = (aDecoder.decodeObject(forKey: "is_document_verified") as? String) ?? ""
            self.selectedMassages = (aDecoder.decodeObject(forKey: "selected_massages") as? [String]) ?? []
            self.selectedTherapies = (aDecoder.decodeObject(forKey: "selected_therapies") as? [String]) ?? []
            self.selected_massages = (aDecoder.decodeObject(forKey: "selected_massages") as? [SelectedMassage]) ?? []
            self.selected_therapies = (aDecoder.decodeObject(forKey: "selected_therapies") as? [SelectedTherapies]) ?? []
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
            aCoder.encode(isMobileVerified, forKey: "is_mobile_verified")
            aCoder.encode(isEmailVerified, forKey: "is_email_verified")
            aCoder.encode(isDocumentVerified, forKey: "is_document_verified")
            aCoder.encode(selectedMassages, forKey: "selected_massages")
            aCoder.encode(selectedTherapies, forKey: "selected_therapies")
            aCoder.encode(selected_massages, forKey: "selected_massages")
            aCoder.encode(selected_therapies, forKey: "selected_therapies")

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
            dictionary["is_mobile_verified"] = isMobileVerified
            dictionary["is_email_verified"] = isEmailVerified
            dictionary["is_document_verified"] = isDocumentVerified
            dictionary["selected_massages"] = selectedMassages
            dictionary["selected_therapies"] = selectedTherapies

            return dictionary
        }

        func isContactVerified() -> Bool {
            return self.isMobileVerified.toBool && self.isEmailVerified.toBool
        }
        func isProfileVerified() -> Bool {
            return !self.dob.isEmpty()
        }
        func isPaymentDetailCompleted() -> Bool {
            return self.isPaymentDetailAdded.toBool
        }


    }

    class SelectedMassage: Codable {

        var createdAt: String = ""
        var id: String = ""
        var massageId: String = ""
        var therapistId: String = ""
        var updatedAt: String = ""

        init(fromDictionary dictionary: [String:Any]){
            self.createdAt = (dictionary["created_at"] as? String) ?? ""
            self.id = (dictionary["id"] as? String) ?? ""
            self.massageId = (dictionary["massage_id"] as? String) ?? ""
            self.therapistId = (dictionary["therapist_id"] as? String) ?? ""
            self.updatedAt = (dictionary["updated_at"] as? String) ?? ""
        }
        @objc required init(coder aDecoder: NSCoder) {
            self.createdAt = (aDecoder.decodeObject(forKey: "created_at") as? String) ?? ""
            self.id = (aDecoder.decodeObject(forKey: "id") as? String) ?? ""
            self.massageId = (aDecoder.decodeObject(forKey: "massage_id") as? String) ?? ""
            self.therapistId = (aDecoder.decodeObject(forKey: "therapist_id") as? String) ?? ""
            self.updatedAt = (aDecoder.decodeObject(forKey: "updated_at") as? String) ?? ""
        }
        @objc func encode(with aCoder: NSCoder) {
            aCoder.encode(createdAt, forKey: "created_at")
            aCoder.encode(id, forKey: "id")
            aCoder.encode(massageId, forKey: "massage_id")
            aCoder.encode(therapistId, forKey: "therapist_id")
            aCoder.encode(updatedAt, forKey: "updated_at")
        }
        func toDictionary() -> [String:Any] {
            var dictionary = [String:Any]()
            dictionary["created_at"] = createdAt
            dictionary["massage_id"] = massageId
            dictionary["therapist_id"] = therapistId
            dictionary["updated_at"] = updatedAt
            dictionary["id"] = id
            return dictionary
        }

    }
    class SelectedTherapies: Codable {

        var createdAt: String = ""
        var id: String = ""
        var therapyId: String = ""
        var therapistId: String = ""
        var updatedAt: String = ""

        init(fromDictionary dictionary: [String:Any]){
            self.createdAt = (dictionary["created_at"] as? String) ?? ""
            self.id = (dictionary["id"] as? String) ?? ""
            self.therapyId = (dictionary["therapy_id"] as? String) ?? ""
            self.therapistId = (dictionary["therapist_id"] as? String) ?? ""
            self.updatedAt = (dictionary["updated_at"] as? String) ?? ""
        }
        @objc required init(coder aDecoder: NSCoder) {
            self.createdAt = (aDecoder.decodeObject(forKey: "created_at") as? String) ?? ""
            self.id = (aDecoder.decodeObject(forKey: "id") as? String) ?? ""
            self.therapyId = (aDecoder.decodeObject(forKey: "therapy_id") as? String) ?? ""
            self.therapistId = (aDecoder.decodeObject(forKey: "therapist_id") as? String) ?? ""
            self.updatedAt = (aDecoder.decodeObject(forKey: "updated_at") as? String) ?? ""
        }
        @objc func encode(with aCoder: NSCoder) {
            aCoder.encode(createdAt, forKey: "created_at")
            aCoder.encode(id, forKey: "id")
            aCoder.encode(therapyId, forKey: "therapy_id")
            aCoder.encode(therapistId, forKey: "therapist_id")
            aCoder.encode(updatedAt, forKey: "updated_at")
        }
        func toDictionary() -> [String:Any] {
            var dictionary = [String:Any]()
            dictionary["created_at"] = createdAt
            dictionary["therapy_id"] = therapyId
            dictionary["therapist_id"] = therapistId
            dictionary["updated_at"] = updatedAt
            dictionary["id"] = id
            return dictionary
        }

    }


}

