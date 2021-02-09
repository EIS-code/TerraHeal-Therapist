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

    struct RequestTodayBookingList: Codable {
        var therapist_id: String = "3"//PreferenceHelper.shared.getUserId()
        var massage_date: String = "1599523200000"//Date().millisecondsSince1970.toString()
        var client_name: String = "JD"
        var booking_type: String = ""
        var session_id: String = ""
    }
    struct RequestPastBookingList: Codable {
        var therapist_id: String = "3"//PreferenceHelper.shared.getUserId()
        var massage_date: String = ""//Date().millisecondsSince1970.toString()
        var client_name: String = ""
        var booking_type: String = ""
        var session_id: String = ""
    }
    struct RequestFutureBookingList: Codable {
        var therapist_id: String = PreferenceHelper.shared.getUserId()
        var massage_date: String = Date().millisecondsSince1970.toString()
        var client_name: String = "JD"
        var booking_type: String = ""
        var session_id: String = ""
    }

    struct RequestBookingDetail: Codable {
        var booking_info_id: String = ""
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

extension BookingWebSerive {
    class BookingData {
        var bookingInfos : [BookingInfo] = []
        var bookingDateTime: String = ""
        var bookingType: String = ""
        var bringTableFuton: String = ""
        var copyWithId: String = ""
        var id: String = ""
        var sessionId: String = ""
        var shopId: String = ""
        var specialNotes: String = ""
        var tableFutonQuantity: String = ""
        var userId: String = ""
        var bookingInfoId: String = ""
        /**
         * Instantiate the instance using the passed dictionary values to set the properties values
         */
        init(fromDictionary dictionary: [String:Any]){
            self.bookingDateTime = (dictionary["booking_date_time"] as? String) ?? ""
            self.bookingType = (dictionary["booking_type"] as? String) ?? ""
            self.bringTableFuton = (dictionary["bring_table_futon"] as? String) ?? ""
            self.copyWithId = (dictionary["copy_with_id"] as? String) ?? ""
            self.id = (dictionary["id"] as? String) ?? ""
            self.sessionId = (dictionary["session_id"] as? String) ?? ""
            self.shopId = (dictionary["shop_id"] as? String) ?? ""
            self.specialNotes = (dictionary["special_notes"] as? String) ?? ""
            self.tableFutonQuantity = (dictionary["table_futon_quantity"] as? String) ?? ""
            self.userId = (dictionary["user_id"] as? String) ?? ""
            self.bookingInfos.removeAll()
            if let bookingInfosArray = dictionary["booking_infos"] as? [[String:Any]]{
                for dic in bookingInfosArray{
                    let value = BookingInfo(fromDictionary: dic)
                    bookingInfos.append(value)
                }
            }

        }

        func toBookingModel() -> MyBookingTblDetail{
            let newDate = Date.init(milliseconds: self.bookingDateTime.toDouble)
            return MyBookingTblDetail.init(id:self.bookingInfoId , title: newDate.toString(format: "dd MMM yyy hh:mm"), isSelected: false)
        }
    }
    class BookingDetail {
            var bookingInfoId: String = ""
            var bookingType: String = ""
            var clientName: String = ""
            var focusArea: String = ""
            var genderPreference: String = ""
            var injuries: String = ""
            var massageDate: String = ""
            var massageEndTime: String = ""
            var massageStartTime: String = ""
            var notes: String = ""
            var pressurePreference: String = ""
            var serviceName: String = ""
            var sessionType: String = ""
            var tableFutonQuantity: String = ""
        /**
             * Instantiate the instance using the passed dictionary values to set the properties values
             */
            init(fromDictionary dictionary: [String:Any]){
                self.bookingInfoId = (dictionary["booking_info_id"] as? String) ?? ""
                self.bookingType = (dictionary["booking_type"] as? String) ?? ""
                self.clientName = (dictionary["client_name"] as? String) ?? ""
                self.focusArea = (dictionary["focus_area"] as? String) ?? ""
                self.genderPreference = (dictionary["gender_preference"] as? String) ?? ""
                self.injuries = (dictionary["injuries"] as? String) ?? ""
                self.massageDate = (dictionary["massage_date"] as? String) ?? ""
                self.massageEndTime = (dictionary["massage_end_time"] as? String) ?? ""
                self.massageStartTime = (dictionary["massage_start_time"] as? String) ?? ""
                self.notes = (dictionary["notes"] as? String) ?? ""
                self.pressurePreference = (dictionary["pressure_preference"] as? String) ?? ""
                self.serviceName = (dictionary["service_name"] as? String) ?? ""
                self.sessionType = (dictionary["session_type"] as? String) ?? ""
                self.tableFutonQuantity = (dictionary["table_futon_quantity"] as? String) ?? ""
            }

    }
    class BookingInfo{

        var bookingId: String = ""
        var bookingInfoId: String = ""
        var massageDate: String = ""
        var massageTime: String = ""
        var userPeopleId: String = ""


        init(fromDictionary dictionary: [String:Any]){
            self.bookingId = (dictionary["booking_id"] as? String) ?? ""
            self.bookingInfoId = (dictionary["booking_info_id"] as? String) ?? ""
            self.massageDate = (dictionary["massage_date"] as? String) ?? ""
            self.massageTime = (dictionary["massage_time"] as? String) ?? ""
            self.userPeopleId = (dictionary["user_people_id"] as? String) ?? ""
        }

        func toBookingModel() -> MyBookingTblDetail{
            let newDate = Date.init(milliseconds: self.massageDate.toDouble)
            return MyBookingTblDetail.init(id:self.bookingInfoId , title: newDate.toString(format: "dd MMM yyy hh:mm"), isSelected: false)
        }

    }
}



//MARK: Web Service Calls

extension BookingWebSerive {
    class func todayBookingList(params:BookingWebSerive.RequestTodayBookingList = BookingWebSerive.RequestTodayBookingList.init(), completionHandler: @escaping ((BookingWebSerive.ResponseBookingList) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.PastBookingList, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = BookingWebSerive.ResponseBookingList.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    class func pastBookingList(params:BookingWebSerive.RequestPastBookingList = BookingWebSerive.RequestPastBookingList.init(), completionHandler: @escaping ((BookingWebSerive.ResponseBookingList) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.PastBookingList, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = BookingWebSerive.ResponseBookingList.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    class func futureBookingList(params:BookingWebSerive.RequestTodayBookingList = BookingWebSerive.RequestTodayBookingList.init(), completionHandler: @escaping ((BookingWebSerive.ResponseBookingList) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.FutureBookingList, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = BookingWebSerive.ResponseBookingList.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }

    class func getBookingDetail(params:BookingWebSerive.RequestBookingDetail = BookingWebSerive.RequestBookingDetail.init(), completionHandler: @escaping ((BookingWebSerive.ResponseBookingDetail) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.BookingDetail, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = BookingWebSerive.ResponseBookingDetail.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
}
