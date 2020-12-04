//
//  BookingWebSerive.swift
//  Therapist TerraHeal
//
//  Created by Jaydeep Vyas on 03/12/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import Foundation



//MARK: Request Models
enum BookingWebSerive {

    struct RequestTodayBookingList: Codable {
        var therapist_id: String = "3"//PreferenceHelper.shared.getUserId()
        var massage_date: String = "1599523200000"//Date().millisecondsSince1970.toString()
        var client_name: String = "JD"
        var booking_type: String = "2"
        var session_id: String = "0"
    }
    struct RequestPastBookingList: Codable {
        var therapist_id: String = "3"//PreferenceHelper.shared.getUserId()
        var massage_date: String = "1599523200000"//Date().millisecondsSince1970.toString()
        var client_name: String = "JD"
        var booking_type: String = "2"
        var session_id: String = "0"
    }
    struct RequestFutureBookingList: Codable {
        var therapist_id: String = PreferenceHelper.shared.getUserId()
        var massage_date: String = Date().millisecondsSince1970.toString()
        var client_name: String = "JD"
        var booking_type: String = "2"
        var session_id: String = "0"
    }
    struct RequestBookingDetail: Codable {
        var booking_info_id: String = ""
    }



    class ResponseBookingList: ResponseModel {
        var bookingList: [BookingInfo] = []
        override init(fromDictionary dictionary: [String:Any]) {
            super.init(fromDictionary: dictionary)
            bookingList.removeAll()
            if let dataArray = dictionary["data"] as? [[String:Any]] {
                for data in dataArray {
                    bookingList.append(BookingInfo.init(fromDictionary: data))
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

    class BookingDetail {

        var bookingInfoId: String = ""
        var focusArea: String = ""
        var genderPreference: String = ""
        var injuries: String = ""
        var massageDate: String = ""
        var massageStartTime: String = ""
        var massageEndTime: String = ""
        var notes: String = ""
        var pressurePreference: String = ""
        var serviceName: String = ""
        var sessionType: String = ""
        var tableFutonQuantity: String = ""
        var bookingType: String = ""
        var clientName: String = ""
        var rooomId: String = "01"
        /**
         * Instantiate the instance using the passed dictionary values to set the properties values
         */
        init(fromDictionary dictionary: [String:Any]){
            self.bookingInfoId = (dictionary["booking_info_id"] as? String) ?? ""
            self.clientName = (dictionary["client_name"] as? String) ?? ""
            self.bookingType = (dictionary["booking_type"] as? String) ?? ""
            self.focusArea = (dictionary["focus_area"] as? String) ?? ""
            self.genderPreference = (dictionary["gender_preference"] as? String) ?? ""
            self.injuries = (dictionary["injuries"] as? String) ?? ""
            self.massageDate = (dictionary["massage_date"] as? String) ?? ""
            self.massageStartTime = (dictionary["massage_start_time"] as? String) ?? ""
            self.massageEndTime = (dictionary["massage_end_time"] as? String) ?? ""
            self.notes = (dictionary["notes"] as? String) ?? ""
            self.pressurePreference = (dictionary["pressure_preference"] as? String) ?? ""
            self.serviceName = (dictionary["service_name"] as? String) ?? ""
            self.sessionType = (dictionary["session_type"] as? String) ?? ""
            self.tableFutonQuantity = (dictionary["table_futon_quantity"] as? String) ?? ""
        }


    }

    class BookingInfo{

        var bookingInfoId: String = ""
        var massageDate: String = ""
        var massageTime: String = ""

        init(fromDictionary dictionary: [String:Any]){
            self.bookingInfoId = (dictionary["booking_info_id"] as? String) ?? ""
            self.massageDate = (dictionary["massage_date"] as? String) ?? ""
            self.massageTime = (dictionary["massage_time"] as? String) ?? ""
        }

        func toBookingModel() -> MyBookingTblDetail{
            let newDate = Date.init(milliseconds: self.massageDate.toDouble)
            return MyBookingTblDetail.init(id:self.bookingInfoId , title: newDate.toString(format: "dd MMM yyy hh:mm"), isSelected: false)
        }

    }
}


