//
//  Singleton.swift
//  ShoppingApp
//
//  Created by Jaydeep on 05/11/19.
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import Foundation
let appSingleton = Singleton.shared

public class Singleton :NSObject {
    static let shared = Singleton()
    var user:UserWebService.UserData = UserWebService.UserData.init(fromDictionary: [:])
    var myMassagePreference: MyMassagePreference = MyMassagePreference.init()
    var currencySymbol:String = ""
    //var settting:Setting.Response = Setting.Response.init(fromDictionary: [:])
    var myLatitude: String = ""
    var myLongitude: String = ""
    var myAddress: String = ""
    private override init() {

    }
    func clear() {

    }

    class func saveInDb() {
        if let encoded = try? JSONEncoder().encode(appSingleton.user) {
            UserDefaults.standard.set(encoded, forKey: "kUser")
        }
    }
    class func loadFrombDB() {
        guard let savedPersonData = UserDefaults.standard.object(forKey: "kUser") as? Data else { return }
        guard let savedPerson = try? JSONDecoder().decode(UserWebService.UserData.self, from: savedPersonData) else { return }
        appSingleton.user = savedPerson
    }
}

class MyMassagePreference: NSObject {
    override init() {
        super.init()
    }
    var treatmentDescription: String = ""
    var problemsDescription: String = ""
    var pastSurgeryDescription: String = ""
    var allergiesDescription: String = ""
    var healthConditionDescription: String = ""
}
