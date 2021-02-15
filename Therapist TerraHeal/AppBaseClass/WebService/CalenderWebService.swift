//
//  UserGiveReviewToStore.swift
//  ShoppingApp
//
//  Created by Jaydeep on ""4/11/19.
//  Copyright © 2""19 Jaydeep. All rights reserved.
//

import Foundation

//MARK: Request Models
class CalenderWebService {
    static let url: String = API_URL.GetCalender
    struct RequestGetCalender: Codable {
        var email: String = ""
    }
}

//MARK: Response Models
extension CalenderWebService {
    class Response :  ResponseModel {
        var bookingList: [CalenderData] = []
        override init(fromDictionary dictionary: [String:Any]) {
            super.init(fromDictionary: dictionary)
            bookingList.removeAll()
            if let dataArray = dictionary["data"] as? [[String:Any]] {
                for data in dataArray {
                    bookingList.append(CalenderData.init(fromDictionary: data))
                }
            }
        }
    }

    class CalenderData{
        var bookingInfoId: String = ""
        var massageDate: String = ""
        var massageTime: String = ""
        var time:String = ""
        /**
         * Instantiate the instance using the passed dictionary values to set the properties values
         */
        init(fromDictionary dictionary: [String:Any]){
            self.bookingInfoId = (dictionary["booking_info_id"] as? String) ?? ""
            self.massageDate = (dictionary["massage_date"] as? String) ?? ""
            self.massageTime = (dictionary["massage_time"] as? String) ?? ""
            self.time = (dictionary["time"] as? String) ?? ""
        }

    }
}


//MARK: WebServiceCall
extension CalenderWebService {
    static func callCalenderEvents(params:CalenderWebService.RequestGetCalender, completionHandler: @escaping ((CalenderWebService.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: CalenderWebService.url, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = CalenderWebService.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
}

