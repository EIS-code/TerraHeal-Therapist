//
//  UserGiveReviewToStore.swift
//  ShoppingApp
//
//  Created by Jaydeep on ""4/11/19.
//  Copyright © 2""19 Jaydeep. All rights reserved.
//

import Foundation

//MARK: Request Models
class MissingDayWebService {
    static let url: String = API_URL.GetMissingDays
    struct RequestSchedule: Codable {
        var id: String = PreferenceHelper.shared.getUserId()
        var date: String = ""
    }
}

//MARK: Response Models
extension MissingDayWebService {
    class Response :  ResponseModel {
        var workingList: [WorkingDate] = []
        override init(fromDictionary dictionary: [String:Any]) {
            super.init(fromDictionary: dictionary)
            workingList.removeAll()
            if let dataArray = dictionary["data"] as? [[String:Any]] {
                for dataDict in dataArray {
                    workingList.append(WorkingDate.init(fromDictionary: dataDict))
                }
                workingList.sort { (data1, data2) -> Bool in
                    return data1.date.toDouble < data2.date.toDouble
                }
            }
        }
    }


    class WorkingDate{
        var absentReason: String = ""
        var date: String = ""
        var id: String = ""
        var isAbsent: String = ""
        var isWorking: String = ""
        /**
         * Instantiate the instance using the passed dictionary values to set the properties values
         */
        init(fromDictionary dictionary: [String:Any]){
            self.absentReason = (dictionary["absent_reason"] as? String) ?? ""
            self.date = (dictionary["date"] as? String) ?? ""
            self.id = (dictionary["id"] as? String) ?? ""
            self.isAbsent = (dictionary["is_absent"] as? String) ?? ""
            self.isWorking = (dictionary["is_working"] as? String) ?? ""
        }
    }
}


//MARK: WebServiceCall
extension MissingDayWebService {
    static func getMissingDays(params: MissingDayWebService.RequestSchedule ,completionHandler: @escaping ((MissingDayWebService.Response) -> Void)) {
        
        AlamofireHelper().getDataFrom(urlString: Self.url, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = MissingDayWebService.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }

    }
}

