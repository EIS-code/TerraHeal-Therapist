//
//  BookingWebSerive.swift
//  Therapist TerraHeal
//
//  Created by Jaydeep Vyas on 03/12/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import Foundation



//MARK: Request Models
class BookingWebSerive {

    static let todayBookingListURL: String = API_URL.TodayBookingList
    static let pastBookingListURL: String = API_URL.PastBookingList
    static let futureBookingListURL: String = API_URL.FutureBookingList
    static let bookingDetailListURL: String = API_URL.BookingDetail
    static let startSevice: String = API_URL.StartService
    static let endService: String = API_URL.FinishService

    struct RequestTodayBookingList: Codable {
        var therapist_id: String = "3"// PreferenceHelper.shared.getUserId()
        var massage_date: String = Date().millisecondsSince1970.toString()
        var client_name: String = ""
        var booking_type: String = ""
        var session_id: String = ""
    }
    struct RequestPastBookingList: Codable {
        var therapist_id: String = "3"// PreferenceHelper.shared.getUserId()
        var massage_date: String = Date().millisecondsSince1970.toString()
        var client_name: String = ""
        var booking_type: String = ""
        var session_id: String = ""
    }
    struct RequestFutureBookingList: Codable {
        var therapist_id: String = "3"// PreferenceHelper.shared.getUserId()
        var massage_date: String = Date().millisecondsSince1970.toString()
        var client_name: String = ""
        var booking_type: String = ""
        var session_id: String = ""
    }

    struct RequestBookingDetail: Codable {
        var booking_info_id: String = ""
    }

    struct RequestStartService: Codable {
        var booking_massage_id: String = ""
        var start_time: String = ""
    }

    struct RequestEndService: Codable {
        var booking_massage_id: String = ""
        var end_time: String = ""
    }

    struct RequestBookingDetailWithDate: Codable {
        var booking_date: String = ""
    }



}
//MARK: Response model

extension BookingWebSerive {
    class ResponseBookingList: ResponseModel {
        var bookingList: [BookingData] = []
        override init(fromDictionary dictionary: [String:Any]) {
            super.init(fromDictionary: dictionary)
            bookingList.removeAll()
            if let dataArray = dictionary["data"] as? [[String:Any]] {
                for data in dataArray {
                    bookingList.append(BookingData.init(fromDictionary: data))
                }
            }
        }
    }

    class ResponseBookingDetail: ResponseModel {
        var bookingDetail: BookingDetail = BookingDetail.init(fromDictionary: [:])
        override init(fromDictionary dictionary: [String:Any]) {
            super.init(fromDictionary: dictionary)

            if let dataArray = dictionary["data"] as? [[String:Any]] {
                if let detail = dataArray.last {
                    self.bookingDetail = BookingDetail.init(fromDictionary: detail)
                }
            }
        }
    }
}

