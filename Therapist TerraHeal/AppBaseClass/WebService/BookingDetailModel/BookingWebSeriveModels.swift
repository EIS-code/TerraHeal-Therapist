
import Foundation

enum ServiceStatus: String {
    case Pending = "0"
    case onGoing = "1"
    case Completed = "2"
}


class CreateStartService {
    var actual_total_time = ""
    var booking_massage_id = ""
    var end_time = ""
    var id = ""
    var shop_id = ""
    var start_time = ""
    init(fromDictionary dictionary: [String:Any]){
        self.actual_total_time = (dictionary["actual_total_time"] as? String) ?? ""
        self.booking_massage_id = (dictionary["booking_massage_id"] as? String) ?? ""
        self.end_time = (dictionary["end_time"] as? String) ?? ""
        self.id = (dictionary["id"] as? String) ?? ""
        self.shop_id = (dictionary["shop_id"] as? String) ?? ""
        self.start_time = (dictionary["start_time"] as? String) ?? ""

    }
}

class BookingData {
    var bookingDateTime: String = ""
    var bookingId: String = ""
    var bookingInfoId: String = ""
    var bookingMassageId: String = ""
    var bookingType: String = ""
    var bookingTypeValue: String = ""
    var bringTableFuton: String = ""
    var copyWithId: String = ""
    var isDone: String = ""
    var massageDate: String = ""
    var massageTime: String = ""
    var serviceId: String = ""
    var servicePricingId: String = ""
    var serviceStatus: String = ""
    var serviceName: String = ""
    var sessionId: String = ""
    var sessionName: String = ""
    var shopId: String = ""
    var specialNotes: String = ""
    var tableFutonQuantity: String = ""
    var therapistId: String = ""
    var therapistName: String = ""
    var userId: String = ""
    var userName: String = ""
    var userPeopleId: String = ""

    var isSelected: Bool = false

    func getServiceStatus() -> ServiceStatus {
        return ServiceStatus.init(rawValue: self.serviceStatus) ?? .Pending
    }
    init(fromDictionary dictionary: [String:Any]){
        self.bookingDateTime = (dictionary["booking_date_time"] as? String) ?? ""
        self.bookingId = (dictionary["booking_id"] as? String) ?? ""
        self.bookingInfoId = (dictionary["booking_info_id"] as? String) ?? ""
        self.bookingMassageId = (dictionary["booking_massage_id"] as? String) ?? ""
        self.bookingType = (dictionary["booking_type"] as? String) ?? ""
        self.bookingTypeValue = (dictionary["booking_type_value"] as? String) ?? ""
        self.bringTableFuton = (dictionary["bring_table_futon"] as? String) ?? ""
        self.copyWithId = (dictionary["copy_with_id"] as? String) ?? ""
        self.isDone = (dictionary["is_done"] as? String) ?? ""
        self.massageDate = (dictionary["massage_date"] as? String) ?? ""
        self.massageTime = (dictionary["massage_time"] as? String) ?? ""
        self.serviceName = (dictionary["service_name"] as? String) ?? (dictionary["service_english_name"] as? String) ?? ""
        self.serviceId = (dictionary["service_id"] as? String) ?? ""
        self.servicePricingId = (dictionary["service_pricing_id"] as? String) ?? ""
        self.serviceStatus = (dictionary["service_status"] as? String) ?? ""
        self.sessionId = (dictionary["session_id"] as? String) ?? ""
        self.shopId = (dictionary["shop_id"] as? String) ?? ""
        self.specialNotes = (dictionary["special_notes"] as? String) ?? ""
        self.tableFutonQuantity = (dictionary["table_futon_quantity"] as? String) ?? ""
        self.therapistId = (dictionary["therapist_id"] as? String) ?? ""
        self.therapistName = (dictionary["therapist_name"] as? String) ?? ""
        self.userId = (dictionary["user_id"] as? String) ?? ""
        self.userName = (dictionary["user_name"] as? String) ?? ""
        self.userPeopleId = (dictionary["user_people_id"] as? String) ?? ""
        if self.bookingType.isEmpty() {
            self.bookingType = (dictionary["booking_type"] as? String) ?? ""
        }

    }
    func toBookingModel(filterType: SubFilterType) -> MyBookingTblDetail{
        let bookingType = BookingType.init(rawValue: self.bookingType)
        switch filterType {
        case .BookingType:
            return MyBookingTblDetail.init(id:self.bookingInfoId , title: bookingType!.name(), bookingType: bookingType!, isSelected: false)
        case .Date:
            let newDate = Date.init(milliseconds: self.massageDate.toDouble)
            return MyBookingTblDetail.init(id:self.bookingInfoId , title: newDate.toString(format: "dd MMM yyy hh:mm"), bookingType: bookingType!,isSelected: false)
        case .ClientName:
            return MyBookingTblDetail.init(id:self.bookingInfoId , title: self.userName, bookingType: bookingType!, isSelected: false)
        case .Massages:
            return MyBookingTblDetail.init(id:self.bookingInfoId , title: self.serviceName, bookingType: bookingType!, isSelected: false)
        case .Therapies:
            return MyBookingTblDetail.init(id:self.bookingInfoId , title: self.serviceName, bookingType: bookingType!, isSelected: false)
        case .SessionType:
            return MyBookingTblDetail.init(id:self.bookingInfoId , title: self.sessionId, bookingType: bookingType!, isSelected: false)
        }

    }
}
class BookingDetail {
    var isSelected: Bool = false
    var actualEndTime: String = ""
    var actualStartTime: String = ""
    var bookPlatform: String = ""
    var bookingId: String = ""
    var bookingInfoId: String = ""
    var bookingMassageId: String = ""
    var bookingTypeValue: String = ""
    var cancelType: String = ""
    var cancelledReason: String = ""
    var clientAge: String = ""
    var clientGender: String = ""
    var clientId: String = ""
    var clientName: String = ""
    var focusArea: String = ""
    var genderPreference: String = ""
    var injuries: String = ""
    var isCancelled: String = ""
    var isConfirm: String = ""
    var isDone: String = ""
    var massageDate: String = ""
    var massageDayName: String = ""
    var massageDuration: String = ""
    var massageEndTime: String = ""
    var massageStartTime: String = ""
    var notes: String = ""
    var observation: String = ""
    var pressurePreference: String = ""
    var price: String = ""
    var qrCodePath: String = ""
    var roomName: String = ""
    var roomId: String = ""
    var serviceName: String = ""
    var servicePricingId: String = ""
    var serviceStatus: String = ""
    var serviceType: String = ""
    var sessionId: String = ""
    var sessionType: String = ""
    var shopAddress: String = ""
    var shopId: String = ""
    var shopName: String = ""
    var tableFutonQuantity: String = ""
    var therapistName: String = ""
    var therapistId: String = ""
    var totalBeds: String = ""
    var userPeopleId: String = ""
    var userPeopleName: String = ""
    func getServiceStatus() -> ServiceStatus {
        return ServiceStatus.init(rawValue: self.serviceStatus) ?? .Pending
    }
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        self.actualEndTime = (dictionary["actual_end_time"] as? String) ?? ""
        self.actualStartTime = (dictionary["actual_start_time"] as? String) ?? ""
        self.bookPlatform = (dictionary["book_platform"] as? String) ?? ""
        self.bookingId = (dictionary["booking_id"] as? String) ?? ""
        self.bookingInfoId = (dictionary["booking_info_id"] as? String) ?? ""
        self.bookingMassageId = (dictionary["booking_massage_id"] as? String) ?? ""
        self.bookingTypeValue = (dictionary["booking_type_value"] as? String) ?? ""
        self.cancelType = (dictionary["cancel_type"] as? String) ?? ""
        self.cancelledReason = (dictionary["cancelled_reason"] as? String) ?? ""
        self.clientAge = (dictionary["client_age"] as? String) ?? ""
        self.clientGender = (dictionary["client_gender"] as? String) ?? ""
        self.clientId = (dictionary["client_id"] as? String) ?? ""
        self.clientName = (dictionary["client_name"] as? String) ?? ""
        self.focusArea = (dictionary["focus_area"] as? String) ?? ""
        self.genderPreference = (dictionary["genderPreference"] as? String) ?? ""
        self.injuries = (dictionary["injuries"] as? String) ?? ""
        self.isCancelled = (dictionary["is_cancelled"] as? String) ?? ""
        self.isConfirm = (dictionary["is_confirm"] as? String) ?? ""
        self.isDone = (dictionary["is_done"] as? String) ?? ""
        self.massageDate = (dictionary["massage_date"] as? String) ?? ""
        self.massageDayName = (dictionary["massage_day_name"] as? String) ?? ""
        self.massageDuration = (dictionary["massage_duration"] as? String) ?? ""
        self.massageEndTime = (dictionary["massage_end_time"] as? String) ?? ""
        self.massageStartTime = (dictionary["massage_start_time"] as? String) ?? ""
        self.notes = (dictionary["notes"] as? String) ?? ""
        self.observation = (dictionary["observation"] as? String) ?? ""
        self.pressurePreference = (dictionary["pressure_preference"] as? String) ?? ""
        self.price = (dictionary["price"] as? String) ?? ""
        self.qrCodePath = (dictionary["qr_code_path"] as? String) ?? ""
        self.roomName = (dictionary["roomName"] as? String) ?? ""
        self.roomId = (dictionary["room_id"] as? String) ?? ""
        self.serviceName = (dictionary["service_name"] as? String) ?? ""
        self.servicePricingId = (dictionary["service_pricing_id"] as? String) ?? ""
        self.serviceStatus = (dictionary["service_status"] as? String) ?? ""
        self.serviceType = (dictionary["service_type"] as? String) ?? ""
        self.sessionId = (dictionary["sessionId"] as? String) ?? ""
        self.sessionType = (dictionary["session_type"] as? String) ?? ""
        self.shopAddress = (dictionary["shop_address"] as? String) ?? ""
        self.shopId = (dictionary["shop_id"] as? String) ?? ""
        self.shopName = (dictionary["shop_name"] as? String) ?? ""
        self.tableFutonQuantity = (dictionary["table_futon_quantity"] as? String) ?? ""
        self.therapistName = (dictionary["therapistName"] as? String) ?? ""
        self.therapistId = (dictionary["therapist_id"] as? String) ?? ""
        self.totalBeds = (dictionary["totalBeds"] as? String) ?? ""
        self.userPeopleId = (dictionary["user_people_id"] as? String) ?? ""
        self.userPeopleName = (dictionary["user_people_name"] as? String) ?? ""
    }
    func getBookType() -> BookingType {
        let bookingType = BookingType.init(rawValue: self.bookingTypeValue) ?? .MassageCenter
        return bookingType
    }
    func toBookingModel() -> MyBookingTblDetail{
        let bookingType = BookingType.init(rawValue: self.bookingTypeValue)
        let newDate = Date.init(milliseconds: self.massageDate.toDouble)
        return MyBookingTblDetail.init(id:self.bookingInfoId , title: newDate.toString(format: "dd MMM yyy hh:mm"), bookingType: bookingType!,isSelected: false)
    }
}


