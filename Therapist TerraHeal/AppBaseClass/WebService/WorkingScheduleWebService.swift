//
//  UserGiveReviewToStore.swift
//  ShoppingApp
//
//  Created by Jaydeep on ""4/11/19.
//  Copyright © 2""19 Jaydeep. All rights reserved.
//

import Foundation

//MARK: Request Models
class WorkingScheduleWebService {
    static let url: String = API_URL.GetWorkingSchedule
    struct RequestSchedule: Codable {
        var date: String = ""
    }
}

//MARK: Response Models
extension WorkingScheduleWebService {
    class Response :  ResponseModel {
        var workingList: [WorkingDate] = []
        override init(fromDictionary dictionary: [String:Any]) {
            super.init(fromDictionary: dictionary)
            workingList.removeAll()
            if let dataDict = dictionary["data"] as? [String:Any] {
                for (key, value) in dataDict {
                    if let dict = value as? [String:Any]  {
                        workingList.append(WorkingDate.init(fromDictionary: dict))
                    }
                }
                workingList.sort { (data1, data2) -> Bool in
                    return data1.date.toDouble < data2.date.toDouble
                }
            }
        }
    }


    class WorkingDate{
        var bookingId: String = ""
        var bookingInfoId: String = ""
        var date: String = ""
        var massageDate: String = ""
        var status: String = ""
        /**
         * Instantiate the instance using the passed dictionary values to set the properties values
         */
        init(fromDictionary dictionary: [String:Any]){
            self.bookingId = (dictionary["booking_id"] as? String) ?? ""
            self.bookingInfoId = (dictionary["booking_info_id"] as? String) ?? ""
            self.date = (dictionary["date"] as? String) ?? ""
            self.massageDate = (dictionary["massage_date"] as? String) ?? ""
            self.status = (dictionary["status"] as? String) ?? ""
        }
    }
}


//MARK: WebServiceCall
extension WorkingScheduleWebService {
    static func getWorkignSchedule(params: WorkingScheduleWebService.RequestSchedule ,completionHandler: @escaping ((WorkingScheduleWebService.Response) -> Void)) {
        AppWebApi.getWorkingSchedule(params: params) { (response) in
            completionHandler(response)
        }

    }
}

