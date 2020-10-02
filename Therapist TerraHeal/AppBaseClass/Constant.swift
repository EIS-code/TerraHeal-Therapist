//
//  Created by Jaydeep on 21/09/19.
//  Copyright © 2019 Jaydeep. All rights reserved.
//
import Foundation
import UIKit


class Constant: NSObject {
    static let typeIOS: String = "ios"
    static let AppName: String = "Terra Heals"

    static let True: String = "1"
    static let False: String = "0"

}

class MessageCode: NSObject {
    static let success: String = "200"
    static let validationError: String = "401"
    static let exception: String = "401"
}

class CommonSize: NSObject {
    struct Button {
        static let cellButton: CGFloat = 35
        static let standard: CGFloat = 48
        static let standardWidth: CGFloat = 160
        static let standardLargeWidth: CGFloat = 200
        static let back: CGFloat = 32
        static let cancel: CGFloat = 44
        static let forwardButton: CGFloat = 40
    }
    struct TextField {
        static let standard: CGFloat = 48
        static let back: CGFloat = 48
        static let cancel: CGFloat = 48
    }

    struct Padding {
        static let left: CGFloat = 48
        static let right: CGFloat = 48
        static let top: CGFloat = 48
        static let bottom: CGFloat = 48
    }
    static let typeIOS: String = "ios"
    static let AppName: String = "Terra Heals"

    static let True: String = "1"
    static let False: String = "0"

}

enum Gender: String {
    case Male  = "m"
    case Female  = "f"
    case Other  = "Other"
    func name()-> String {
        switch self {
        // Use Internationalization, as appropriate.
        case .Male: return "GENDER_MALE".localized()
        case .Female: return "GENDER_FEMALE".localized()
        default: return "GENDER_NO_PREFERENCE".localized()
        }
    }
}



enum AccessoryType: String {
    case None  = "0"
    case Table  = "1"
    case Futon  = "2"
}


enum Pressure: String {
    case Soft  = "soft"
    case Medium  = "medium"
    case Strong  = "strong"
    case ExStrong  = "extra strong"
    case Other  = "other"
    func name()-> String {
        switch self {
            // Use Internationalization, as appropriate.
        case .Soft: return "MASSAGE_PRESSURE_TYPE_1".localized()
        case .Medium: return "MASSAGE_PRESSURE_TYPE_2".localized()
        case .Strong: return "MASSAGE_PRESSURE_TYPE_3".localized()
        case .ExStrong: return "MASSAGE_PRESSURE_TYPE_4".localized()
        default: return "Unknown"
        }
    }
}


struct Google {
    static let Key = "AIzaSyBSc9WayQOORGQpEecPbFOnUnBOPiuFeRg"


}
struct LoginBy {
    static let Social  = "1"
    static let Manual  = "0"
}

enum BookingType: String {
    case MassageCenter  = "0"
    case AtHotelOrRoom  = "1"
    func name()-> String {
        switch self {
        case .MassageCenter: return "MY_BOOKING_TYPE_AT_MASSAGE_CENTER".localized()
        case .AtHotelOrRoom: return "MY_BOOKING_TYPE_AT_HOME_OR_HOTEL".localized()
        //default: return "Unknown"
        }
    }



   /* func getImage()-> String {
        switch self {
        case .MassageCenter: return ImageAsset.BookingType.center
        case .AtHotelOrRoom: return ImageAsset.BookingType.hotel
        //default: return "Unknown"
        }
    }*/
    
    func getParameterId() -> String {
        switch self {
        case .MassageCenter: return "0"
        case .AtHotelOrRoom: return "1"
        //default: return "Unknown"
        }
    }
}


struct DateFormat {

    static let BookingDateSelection = "dd MMM yyyy"
    static let BookingTimeSelection = "HH:mm"
    static let ReviewBookingDateDisplay = "HH:mm | EEE, dd MMM yyyy"
    static let WEB = "yyyy-MM-ddThh:mm:HH.0000Z"
    static let GiftVoucher = "EEE, MMM dd, yyyy"
    static let DD_MM_YYYY = "dd/MM/YYYY"
    static let DOB = "dd MMM yyyy"
    static let MyBookingCollapseDate = "dd MMM yyyy hh:mm"
}


