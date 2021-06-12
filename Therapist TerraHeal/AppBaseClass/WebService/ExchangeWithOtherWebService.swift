//
//  UserGiveReviewToStore.swift
//  ShoppingApp
//
//  Created by Jaydeep on ""4/11/19.
//  Copyright © 2""19 Jaydeep. All rights reserved.
//

import Foundation

//MARK: Request Models
class ExchangeWithOtherWebService {
    static let exchangeURL: String = API_URL.ExchangeWithOther
    static let exchangeRequestListURL: String = API_URL.ExcahngeRequestList
    static let acceptRequestListURL: String = API_URL.AcceptExcahngeRequest
    static let rejectRequestListURL: String = API_URL.RejectExcahngeRequest
    static let therapistListURL: String = API_URL.GetTherapistList
    static let therapistShiftListURL: String = API_URL.GetAllTherapistShift



    struct RequestToTherapistList: Codable {
        var id: String = PreferenceHelper.shared.getUserId()
        var name: String = ""
    }
    struct RequestToExchangeOffer: Codable {
        let date: String?
        let therapist_id :String?
        let shop_id: String?
        let shift_id: String?
        let with_shift_id :String?
        let with_therapist_id: String?
        init(from data: RequestExchangeShift) {
            self.date = data.date
            self.therapist_id = data.therapist_id
            self.shop_id = data.shop_id
            self.shift_id = data.shift_id
            self.with_shift_id = data.with_shift_id
            self.with_therapist_id = data.with_therapist_id
        }
    }

    struct RequestToExchangeOfferList: Codable {
        var therapist_id: String = "2"//PreferenceHelper.shared.getUserId()
        var shop_id: String = appSingleton.user.shopId
    }

    struct RequestToChangeStatus: Codable {
        var exchange_shift_id: String = PreferenceHelper.shared.getUserId()
    }

    struct RequestAllTherapistShift: Codable {
        var date: String = "1620432000000"
        var shop_id: String = appSingleton.user.shopId
    }

}



//MARK: Response Models
extension ExchangeWithOtherWebService {
    class TherapistListResponse :  ResponseModel {
        var therapistList: [TherapistData] = []
        override init(fromDictionary dictionary: [String:Any]) {
            super.init(fromDictionary: dictionary)
            therapistList.removeAll()
            if let dataArray = dictionary["data"] as? [[String:Any]] {
                for data in dataArray {
                    therapistList.append(TherapistData.init(fromDictionary: data))
                }
            }
        }
    }

    class RequestListResponse :  ResponseModel {
        var data: [ExchangeShiftData] = []
        override init(fromDictionary dictionary: [String:Any]) {
            super.init(fromDictionary: dictionary)
            data.removeAll()
            if let dataArray = dictionary["data"] as? [[String:Any]] {
                for dict in dataArray {
                    data.append(ExchangeShiftData.init(fromDictionary: dict))
                }
            }
        }
    }
    class RequestTherapistShiftListResponse :  ResponseModel {
        var data: [TherapistShiftData] = []
        override init(fromDictionary dictionary: [String:Any]) {
            super.init(fromDictionary: dictionary)
            data.removeAll()
            if let dataArray = dictionary["data"] as? [[String:Any]] {
                for dict in dataArray {
                    data.append(TherapistShiftData.init(fromDictionary: dict))
                }
            }
        }
    }
}



//MARK: WebServiceCall
extension ExchangeWithOtherWebService {
    static func requestToExchangeOffer(params: ExchangeWithOtherWebService.RequestToExchangeOffer ,completionHandler: @escaping ((ResponseModel) -> Void)) {

        AlamofireHelper().getDataFrom(urlString: Self.exchangeURL, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = ResponseModel.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    static func requestToGetTherapistList(params: ExchangeWithOtherWebService.RequestToTherapistList ,completionHandler: @escaping ((TherapistListResponse) -> Void)) {

        AlamofireHelper().getDataFrom(urlString: Self.therapistListURL, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = TherapistListResponse.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }

    static func requestToGetExchangeOffers(params: ExchangeWithOtherWebService.RequestToExchangeOfferList = ExchangeWithOtherWebService.RequestToExchangeOfferList.init() ,completionHandler: @escaping ((RequestListResponse) -> Void)) {

        AlamofireHelper().getDataFrom(urlString: Self.exchangeRequestListURL, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = RequestListResponse.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }

    static func requestToAcceptExchangeOffer(params: ExchangeWithOtherWebService.RequestToChangeStatus ,completionHandler: @escaping ((ResponseModel) -> Void)) {

        AlamofireHelper().getDataFrom(urlString: Self.acceptRequestListURL, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = ResponseModel.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    static func requestToRejectExchangeOffer(params: ExchangeWithOtherWebService.RequestToChangeStatus ,completionHandler: @escaping ((ResponseModel) -> Void)) {

        AlamofireHelper().getDataFrom(urlString: Self.rejectRequestListURL, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = ResponseModel.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }

    static func requestToGetTherapistShiftList(params: ExchangeWithOtherWebService.RequestAllTherapistShift ,completionHandler: @escaping ((RequestTherapistShiftListResponse) -> Void)) {

        AlamofireHelper().getDataFrom(urlString: Self.therapistShiftListURL, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = RequestTherapistShiftListResponse.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
}

//MARK: Models

class TherapistData {
    var email: String = ""
    var id: String = ""
    var name: String = ""
    var profilePhoto: String = ""


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        self.email = (dictionary["email"] as? String) ?? ""
        self.id = (dictionary["id"] as? String) ?? ""
        self.name = (dictionary["name"] as? String) ?? ""
        self.profilePhoto = (dictionary["profile_photo"] as? String) ?? ""
    }


}

class TherapistShiftData {
    var date: String = ""
    var name: String = ""
    var profilePhoto: String = ""
    var surname: String = ""
    var therapistId: String = ""
    var shifts: [Shift] = []
    var isSelected:Bool = false

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        self.date = (dictionary["date"] as? String) ?? ""
        self.name = (dictionary["name"] as? String) ?? ""
        self.profilePhoto = (dictionary["profile_photo"] as? String) ?? ""
        self.shifts = [Shift]()
        if let shiftsArray = dictionary["shifts"] as? [[String:Any]]{
            for dic in shiftsArray{
                let value = Shift(fromDictionary: dic)
                self.shifts.append(value)
            }
        }
        self.surname = (dictionary["surname"] as? String) ?? ""
        self.therapistId = (dictionary["therapist_id"] as? String) ?? ""
    }


}
class ExchangeShiftData {
    var date: String = ""
    var shopId: String = ""
    var status: String = ""
    var withShift: ExchangeShift = ExchangeShift.init(fromDictionary: [:])
    var yourShift: ExchangeShift = ExchangeShift.init(fromDictionary: [:])


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        self.date = (dictionary["date"] as? String) ?? ""
        self.shopId = (dictionary["shop_id"] as? String) ?? ""
        self.status = (dictionary["status"] as? String) ?? ""
        if let withShiftData = dictionary["with_shift"] as? [String:Any]{
            self.withShift = ExchangeShift(fromDictionary: withShiftData)
        }
        if let yourShiftData = dictionary["your_shift"] as? [String:Any]{
            self.yourShift = ExchangeShift(fromDictionary: yourShiftData)
        }
    }

}


class ExchangeShift{
    var from: String = ""
    var shiftId: String = ""
    var therapistId: String = ""
    var therapistName: String = ""
    var therapistSurname: String = ""
    var to: String = ""

    var shiftStartTime: String = ""
    var shiftEndTime: String = ""

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        self.from = (dictionary["from"] as? String) ?? ""
        self.shiftId = (dictionary["shift_id"] as? String) ?? ""
        self.therapistId = (dictionary["therapist_id"] as? String) ?? ""
        self.therapistName = (dictionary["therapist_name"] as? String) ?? ""
        self.therapistSurname = (dictionary["therapist_surname"] as? String) ?? ""
        self.to = (dictionary["to"] as? String) ?? ""
        self.setStartTime()
        self.setEndTime()
    }

    func setStartTime() {
        let date = Date.init(milliseconds: self.from.toDouble)
        self.shiftStartTime = date.toString(format: "hh:MM")
    }
    func setEndTime() {
        let date = Date.init(milliseconds: self.to.toDouble)
        self.shiftEndTime = date.toString(format: "hh:MM")
    }

}

class Shift {

    var date: String = ""
    var from: String = ""
    var shiftId: String = ""
    var shopId: String = ""
    var to: String = ""
    var isSelected:Bool = false
    init(fromDictionary dictionary: [String:Any]){
        self.date = (dictionary["date"] as? String) ?? ""
        self.from = (dictionary["from"] as? String) ?? ""
        self.shiftId = (dictionary["shift_id"] as? String) ?? ""
        self.shopId = (dictionary["shop_id"] as? String) ?? ""
        self.to = (dictionary["to"] as? String) ?? ""
    }
}

struct RequestExchangeShift {
       var date: String? = nil
       var therapist_id :String? = nil
       var shop_id: String? = nil
       var shift_id: String? = nil
       var with_shift_id :String? = nil
       var with_therapist_id: String? = nil

    init(data:ShiftContainerCellDetail) {
        self.date = data.date
        self.therapist_id = PreferenceHelper.shared.getUserId()
        self.shop_id = data.id
        for subShift in data.shifts {
            if subShift.isSelected {
                self.shift_id = subShift.shiftID
            }
        }
    }

    mutating func exchangeShiftData(data:ShiftContainerCellDetail) {
        self.with_therapist_id = data.id
        for subShift in data.shifts {
            if subShift.isSelected {
                self.with_shift_id = subShift.shiftID
            }
        }
    }
}
