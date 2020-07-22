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


struct DateFormat {
    
    static let BookingDateSelection = "dd MMM yyyy"
    static let BookingTimeSelection = "HH:mm"
    static let ReviewBookingDateDisplay = "HH:mm | EEE, dd MMM yyyy"
    static let DD_MM_YYYY = "dd/MM/YYYY"
    static let DOB = "dd MMM yyyy"
    static let check = "✓"
}


