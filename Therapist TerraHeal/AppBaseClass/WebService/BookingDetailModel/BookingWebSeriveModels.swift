
import Foundation


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
    var isSelected: Bool = false
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
        let newDate = Date.init(milliseconds: self.bookingInfos.first!.massageDate.toDouble)
        return MyBookingTblDetail.init(id:self.bookingInfoId , title: newDate.toString(format: "dd MMM yyy hh:mm"), isSelected: false)
    }
}
class BookingDetail {
    var bookingInfoId: String = ""
    var bookingType: String = ""
    var clientAge: String = ""
    var clientGender: String = ""
    var clientName: String = ""
    var focusArea: String = ""
    var genderPreference: String = ""
    var injuries: String = ""
    var massageDate: String = ""
    var massageDayName: String = ""
    var massageDuration: String = ""
    var massageEndTime: String = ""
    var massageStartTime: String = ""
    var notes: String = ""
    var pressurePreference: String = ""
    var serviceName: String = ""
    var sessionType: String = ""
    var shopAddress: String = ""
    var shopName: String = ""
    var tableFutonQuantity: String = ""
    var isSelected: Bool = false
    var bookingMassageId: String = ""


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        self.bookingInfoId = (dictionary["booking_info_id"] as? String) ?? ""
        self.bookingType = (dictionary["booking_type"] as? String) ?? ""
        self.clientAge = (dictionary["client_age"] as? String) ?? ""
        self.clientGender = (dictionary["client_gender"] as? String) ?? ""
        self.clientName = (dictionary["client_name"] as? String) ?? ""
        self.focusArea = (dictionary["focus_area"] as? String) ?? ""
        self.genderPreference = (dictionary["gender_preference"] as? String) ?? ""
        self.injuries = (dictionary["injuries"] as? String) ?? ""
        self.massageDate = (dictionary["massage_date"] as? String) ?? ""
        self.massageDayName = (dictionary["massage_day_name"] as? String) ?? ""
        self.massageDuration = (dictionary["massage_duration"] as? String) ?? ""
        self.massageEndTime = (dictionary["massage_end_time"] as? String) ?? ""
        self.massageStartTime = (dictionary["massage_start_time"] as? String) ?? ""
        self.notes = (dictionary["notes"] as? String) ?? ""
        self.pressurePreference = (dictionary["pressure_preference"] as? String) ?? ""
        self.serviceName = (dictionary["service_name"] as? String) ?? ""
        self.sessionType = (dictionary["session_type"] as? String) ?? ""
        self.shopAddress = (dictionary["shop_address"] as? String) ?? ""
        self.shopName = (dictionary["shop_name"] as? String) ?? ""
        self.tableFutonQuantity = (dictionary["table_futon_quantity"] as? String) ?? ""
        self.bookingMassageId = (dictionary["booking_massage_id"] as? String) ?? ""
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


class MyBookingUserPeople{

    var age: String = ""
    var gender: String = ""
    var id: String = ""
    var name: String = ""
    var bookingMassages: [MyBookingMassage] = [MyBookingMassage.init(),MyBookingMassage.init(),MyBookingMassage.init()]

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        self.age = (dictionary["age"] as? String) ?? ""
        self.gender = (dictionary["gender"] as? String) ?? ""
        self.id = (dictionary["id"] as? String) ?? ""
        self.name = (dictionary["name"] as? String) ?? ""
        bookingMassages = [MyBookingMassage]()
        if let bookingMassagesArray = dictionary["booking_massages"] as? [[String:Any]]{
            for dic in bookingMassagesArray{
                let value = MyBookingMassage(fromDictionary: dic)
                bookingMassages.append(value)
            }
        }
    }

}
class MyBookingMassage{

    var name : String = "thai yoga massage"
    var price : String = "200"
    var time : String = "90"
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init() {
    }
    init(fromDictionary dictionary: [String:Any]){
        self.name = (dictionary["name"] as? String) ?? ""
        self.price = (dictionary["price"] as? String) ?? ""
        self.time = (dictionary["time"] as? String) ?? ""
    }

}
