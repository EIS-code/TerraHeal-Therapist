//
//  UserGiveReviewToStore.swift
//  ShoppingApp
//
//  Created by Jaydeep on ""4/11/19.
//  Copyright © 2""19 Jaydeep. All rights reserved.
//

import Foundation

class AvailabilityWebService {
    static let getAvailibilityUrl: String = API_URL.GetAvailability
    struct RequestGetAvailability: Codable {
        var user_id: String = PreferenceHelper.shared.getUserId()
        var date: String = "1617084784777"
    }

}

//MARK: Response Models
extension AvailabilityWebService {
    class Response :  ResponseModel {
        var availabilityList: [Availability] = []
        override init(fromDictionary dictionary: [String:Any]) {
            super.init(fromDictionary: dictionary)
            availabilityList.removeAll()
            if let dataArray = dictionary["data"] as? [[String:Any]] {
                for data in dataArray {
                    availabilityList.append(Availability.init(fromDictionary: data))
                }
            }
            else if let data = dictionary["data"] as? [String:Any] {
                availabilityList.append(Availability.init(fromDictionary: data))
            }
        }
    }
}

class Availability {
    var breaks : [Break]!
    var absentReason: String = ""
    var date: String = ""
    var endTime: String = ""
    var id: String = ""
    var isAbsent: String = ""
    var isWorking: String = ""
    var scheduleId: String = ""
    var startTime: String = ""


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        self.breaks = [Break]()
        if let breaksArray = dictionary["breaks"] as? [[String:Any]]{
            for dic in breaksArray{
                let value = Break(fromDictionary: dic)
                breaks.append(value)
            }
        }
        self.absentReason = (dictionary["absent_reason"] as? String) ?? ""
        self.date = (dictionary["date"] as? String) ?? ""
        self.endTime = (dictionary["end_time"] as? String) ?? ""
        self.id = (dictionary["id"] as? String) ?? ""
        self.isAbsent = (dictionary["is_absent"] as? String) ?? ""
        self.isWorking = (dictionary["is_working"] as? String) ?? ""
        self.scheduleId = (dictionary["schedule_id"] as? String) ?? ""
        self.startTime = (dictionary["start_time"] as? String) ?? ""
    }

}


class Break{

    var breakFor: String = ""
    var breakReason: String = ""
    var from: String = ""
    var id: String = ""
    var scheduleId: String = ""
    var scheduleTimeId: String = ""
    var to: String = ""


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        self.breakFor = (dictionary["break_for"] as? String) ?? ""
        self.breakReason = (dictionary["break_reason"] as? String) ?? ""
        self.from = (dictionary["from"] as? String) ?? ""
        self.id = (dictionary["id"] as? String) ?? ""
        self.scheduleId = (dictionary["schedule_id"] as? String) ?? ""
        self.scheduleTimeId = (dictionary["schedule_time_id"] as? String) ?? ""
        self.to = (dictionary["to"] as? String) ?? ""
    }

}
//MARK: Web Service Calls
extension AvailabilityWebService {
    static func getAvailabilities(params:AvailabilityWebService.RequestGetAvailability, completionHandler: @escaping ((AvailabilityWebService.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: Self.getAvailibilityUrl, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = AvailabilityWebService.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    
}

