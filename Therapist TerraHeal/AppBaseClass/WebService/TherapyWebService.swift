//
//  UserGiveReviewToStore.swift
//  ShoppingApp
//
//  Created by Jaydeep on ""4/11/19.
//  Copyright © 2""19 Jaydeep. All rights reserved.
//

import Foundation

//MARK: Request Models

typealias TherapyDetail = Therapy.TherapyData

enum Therapy {

    struct RequestTherapy: Codable  {
        var id: String = PreferenceHelper.shared.getUserId()
        // var token: String = PreferenceHelper.shared.getSessionToken()
        var device_token: String = PreferenceHelper.shared.getDeviceToken()
        var app_version: String = Bundle.appVesion
        var oauth_uid: String = ""
        var oauth_provider: String = LoginBy.Manual
        var q: String = ""
    }
}
class WorkData {
    var createdAt: String = ""
    var id: String = ""
    var image: String = ""
    var name: String = ""
    var updatedAt: String = ""
    var isSelected:  Bool = false
    init(fromDictionary dictionary: [String:Any]){
        self.createdAt = (dictionary["created_at"] as? String) ?? ""
        self.id = (dictionary["id"] as? String) ?? ""
        self.image = (dictionary["image"] as? String) ?? ""
        self.name = (dictionary["name"] as? String) ?? ""
        self.updatedAt = (dictionary["updated_at"] as? String) ?? ""
    }
}

//MARK: Response Models
extension Therapy {

    class ResponseTherapyList:  ResponseModel {
        var data: [TherapyData] = []
        override init(fromDictionary dictionary: [String:Any]) {
            super.init(fromDictionary: dictionary)
            data = [TherapyData]()
            if let dataArray = dictionary["data"] as? [[String:Any]]{
                for dic in dataArray{
                    let value = TherapyData(fromDictionary: dic)
                    data.append(value)
                }
            }
        }

    }

    class TherapyData: ResponseModel {
        var createdAt: String = ""
        var id: String = ""
        var image: String = ""
        var name: String = ""
        var updatedAt: String = ""
        var timing: [Timing] = []
        var isSelected:  Bool = false
        override init(fromDictionary dictionary: [String:Any]){
            super.init(fromDictionary: dictionary)
            self.createdAt = (dictionary["created_at"] as? String) ?? ""
            self.id = (dictionary["id"] as? String) ?? ""
            self.image = (dictionary["image"] as? String) ?? ""
            self.name = (dictionary["name"] as? String) ?? ""
            self.updatedAt = (dictionary["updated_at"] as? String) ?? ""

            timing = [Timing]()
            if let timingArray = dictionary["timing"] as? [[String:Any]]{
                for dic in timingArray{
                    let value = Timing(fromDictionary: dic)
                    timing.append(value)
                }
            }
        }
        func toWorkData() -> WorkData {
            let workData = WorkData.init(fromDictionary: [:])
            workData.createdAt = self.createdAt
            workData.id = self.id
            workData.image = self.image
            workData.name = self.name
            workData.updatedAt = self.updatedAt
            return workData
        }
    }

    class Timing {

        var createdAt: String = ""
        var id: String = ""
        var massageId: String = ""
        var pricing: [Pricing] = []
        var time: String = ""
        var updatedAt: String = ""

        init(fromDictionary dictionary: [String:Any]){
            self.createdAt = (dictionary["created_at"] as? String) ?? ""
            self.id = (dictionary["id"] as? String) ?? ""
            self.massageId = (dictionary["massage_id"] as? String) ?? ""
            self.pricing = [Pricing]()
            if let pricingArray = dictionary["pricing"] as? [[String:Any]]{
                for dic in pricingArray{
                    let value = Pricing(fromDictionary: dic)
                    pricing.append(value)
                }
            }
            time = (dictionary["time"] as? String) ?? ""
            updatedAt = (dictionary["updated_at"] as? String) ?? ""
        }
    }

    class Pricing{

        var cost: String = ""
        var createdAt: String = ""
        var id: String = ""
        var massageId: String = ""
        var massageTimingId: String = ""
        var price: String = ""
        var updatedAt: String = ""

        init(fromDictionary dictionary: [String:Any]){
            self.cost = (dictionary["cost"] as? String) ?? ""
            self.createdAt = (dictionary["created_at"] as? String) ?? ""
            self.id = (dictionary["id"] as? String) ?? ""
            self.massageId = (dictionary["massage_id"] as? String) ?? ""
            self.massageTimingId = (dictionary["massage_timing_id"] as? String) ?? ""
            self.price = (dictionary["price"] as? String) ?? ""
            self.updatedAt = (dictionary["updated_at"] as? String) ?? ""
        }

    }


}



