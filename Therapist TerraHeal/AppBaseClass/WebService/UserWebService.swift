//
//  UserGiveReviewToStore.swift
//  ShoppingApp
//
//  Created by Jaydeep on ""4/11/19.
//  Copyright © 2""19 Jaydeep. All rights reserved.
//

import Foundation

//MARK: Request Models
class UserWebService {

    private var apiService : AppWebApi!
    struct RequestLogout: Codable {
        var user_id: String = PreferenceHelper.shared.getUserId()
        // var token: String = PreferenceHelper.shared.getSessionToken()
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
}

//MARK: Response Models
extension UserWebService {
    class Response :  ResponseModel {
        var data: UserData = UserData.init(fromDictionary: [:])
        override init(fromDictionary dictionary: [String:Any]) {
            super.init(fromDictionary: dictionary)
            data = UserData.init(fromDictionary: [:])
            if let dictData = dictionary["data"] as? [String:Any] {
                self.data = UserData.init(fromDictionary: dictData)
            }
        }
    }
    class UserData: Codable {
        var appVersion: String = ""
        var avatar: String = ""
        var avatarOriginal: String = ""
        var deviceToken: String = ""
        var deviceType: String = ""
        var dob: String = ""
        var email: String = ""
        var gender: String = ""
        var hobbies: String = ""
        var id: String = ""
        var isDocumentVerified: String = ""
        var isEmailVerified: String = ""
        var isFreelancer: String = ""
        var isMobileVerified: String = ""
        var name: String = ""
        var oauthProvider: String = ""
        var oauthUid: String = ""
        var paidPercentage: String = ""
        var profilePhoto: String = ""
        var selectedMassages : [SelectedMassage]!
        var selectedTherapies : [SelectedTherapy]!
        var shopId: String = ""
        var shortDescription: String = ""
        var telNumber: String = ""

        init(fromDictionary dictionary: [String:Any]){
            self.appVersion = (dictionary["app_version"] as? String) ?? ""
            self.avatar = (dictionary["avatar"] as? String) ?? ""
            self.avatarOriginal = (dictionary["avatar_original"] as? String) ?? ""
            self.deviceToken = (dictionary["device_token"] as? String) ?? ""
            self.deviceType = (dictionary["device_type"] as? String) ?? ""
            self.dob = (dictionary["dob"] as? String) ?? ""
            self.email = (dictionary["email"] as? String) ?? ""
            self.gender = (dictionary["gender"] as? String) ?? ""
            self.hobbies = (dictionary["hobbies"] as? String) ?? ""
            self.id = (dictionary["id"] as? String) ?? ""
            self.isDocumentVerified = (dictionary["is_document_verified"] as? String) ?? ""
            self.isEmailVerified = (dictionary["is_email_verified"] as? String) ?? ""
            self.isFreelancer = (dictionary["is_freelancer"] as? String) ?? ""
            self.isMobileVerified = (dictionary["is_mobile_verified"] as? String) ?? ""
            self.name = (dictionary["name"] as? String) ?? ""
            self.oauthProvider = (dictionary["oauth_provider"] as? String) ?? ""
            self.oauthUid = (dictionary["oauth_uid"] as? String) ?? ""
            self.paidPercentage = (dictionary["paid_percentage"] as? String) ?? ""
            self.profilePhoto = (dictionary["profile_photo"] as? String) ?? ""

            selectedMassages = [SelectedMassage]()
                if let selectedMassagesArray = dictionary["selected_massages"] as? [[String:Any]]{
                    for dic in selectedMassagesArray{
                        let value = SelectedMassage(fromDictionary: dic)
                        selectedMassages.append(value)
                    }
                }
                selectedTherapies = [SelectedTherapy]()
                if let selectedTherapiesArray = dictionary["selected_therapies"] as? [[String:Any]]{
                    for dic in selectedTherapiesArray{
                        let value = SelectedTherapy(fromDictionary: dic)
                        selectedTherapies.append(value)
                    }
                }
            self.shopId = (dictionary["shop_id"] as? String) ?? ""
            self.shortDescription = (dictionary["short_description"] as? String) ?? ""
            self.telNumber = (dictionary["tel_number"] as? String) ?? ""
            }


    }
    class SelectedTherapy: Codable {

        var id: String = ""
        var therapistId: String = ""
        var therapyId: String = ""

        init(fromDictionary dictionary: [String:Any]){
            self.id = (dictionary["id"] as? String) ?? ""
            self.therapistId = (dictionary["therapist_id"] as? String) ?? ""
            self.therapyId = (dictionary["therapy_id"] as? String) ?? ""
        }

    }
    class SelectedMassage: Codable{

        var id: String = ""
        var massageId: String = ""
        var therapistId: String = ""

        init(fromDictionary dictionary: [String:Any]){
            self.id = (dictionary["id"] as? String) ?? ""
            self.massageId = (dictionary["massage_id"] as? String) ?? ""
            self.therapistId = (dictionary["therapist_id"] as? String) ?? ""
        }

    }

}

