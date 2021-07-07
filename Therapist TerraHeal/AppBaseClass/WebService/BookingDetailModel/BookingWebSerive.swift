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
    static let allBookingListURL: String = API_URL.NumberOfBooking
    static let startSevice: String = API_URL.StartService
    static let endService: String = API_URL.FinishService
    static let bookingListPendingURL: String = API_URL.BookingListPending
    static let bookingListUpcomingURL: String = API_URL.BookingListUpcoming
    static let bookingListPastURL: String = API_URL.BookingListPast
    static let matchQRCode: String = API_URL.MatchQR

    struct RequestBookingList: Codable {
        var id: String = PreferenceHelper.shared.getUserId()
        var type: String = ""
        var massage_date: String = "1617926400000"/// Date().millisecondsSince1970.toString()
        var shop_id: String = appSingleton.user.shopId
        var user_id: String = ""
        var service_id: String = ""
        var booking_type: String = ""
        var session_type: String = ""
       
    }

    struct RequestBookingDetail: Codable {
        var id: String = PreferenceHelper.shared.getUserId()
        var shop_id: String = appSingleton.user.shopId
        var booking_info_id: String = ""
    }

    struct RequestStartService: Codable {
        var id: String = PreferenceHelper.shared.getUserId()
        var booking_massage_id: String = ""
        var start_time: String = ""
    }

    struct RequestEndService: Codable {
        var id: String = PreferenceHelper.shared.getUserId()
        var booking_massage_id: String = ""
        var end_time: String = ""
    }

    struct RequestBookingDetailWithDate: Codable {
        var id: String = PreferenceHelper.shared.getUserId()
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
    class ResponseMyBookingList: ResponseModel {
        var bookingList: [BookingDetail] = []
        override init(fromDictionary dictionary: [String:Any]) {
            super.init(fromDictionary: dictionary)
            bookingList.removeAll()
            if let dataArray = dictionary["data"] as? [[String:Any]] {
                for data in dataArray {
                    bookingList.append(BookingDetail.init(fromDictionary: data))
                }
            }
        }
    }
    class ResponseStartService: ResponseModel {
        var timeDetail: CreateStartService = CreateStartService.init(fromDictionary: [:])
        override init(fromDictionary dictionary: [String:Any]) {
            super.init(fromDictionary: dictionary)

            if let dataArray = dictionary["data"] as? [String:Any] {
                if let detail = dataArray["create"] as? [String:Any] {
                    self.timeDetail = CreateStartService.init(fromDictionary: detail)
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
            } else if let data = dictionary["data"] as? [String:Any] {
                self.bookingDetail = BookingDetail.init(fromDictionary: data)
            }
        }
    }
}

