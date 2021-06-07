//
//  UserGiveReviewToStore.swift
//  ShoppingApp
//
//  Created by Jaydeep on ""4/11/19.
//  Copyright © 2""19 Jaydeep. All rights reserved.
//

import Foundation

//MARK: Request Models
enum SettingPreference {
    
    struct RequestSettingPrefenceList: Codable {
        var id: String = PreferenceHelper.shared.getUserId()
    }
    
    
    struct SaveSettingPrefence: Codable {
        var id: String = PreferenceHelper.shared.getUserId()
        var language_code: String? = nil
        var notification: String? = nil
        var unit: String? = nil
        var currency_code: String? = nil
    }
    
    //MARK: Response
    class Response: ResponseModel {
        var settingDetail: Setting = Setting.init(fromDictionary: [:])
        override init(fromDictionary dictionary: [String:Any]) {
            super.init(fromDictionary: dictionary)
            if let dataArray = dictionary["data"] as? [String:Any] {
                self.settingDetail = Setting.init(fromDictionary: dataArray)
            }
        }
    }
}

class Setting: ResponseModel {
    
    var currencyCode: String = ""
    var languageCode: String = ""
    var notification: String = ""
    var privacy: String = ""
    var terms: String = ""
    var unit: String = ""
    
    override init(fromDictionary dictionary: [String:Any]) {
        super.init(fromDictionary: dictionary)
        self.currencyCode = (dictionary["currency_code"] as? String) ?? ""
        self.languageCode = (dictionary["language_code"] as? String) ?? ""
        self.notification = (dictionary["notification"] as? String) ?? ""
        self.privacy = (dictionary["privacy"] as? String) ?? ""
        self.terms = (dictionary["terms"] as? String) ?? ""
        self.unit = (dictionary["unit"] as? String) ?? ""
    }
    
}
