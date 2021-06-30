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
    case MassageCenter  = "1"
    case AtHotelOrRoom  = "2"
    func name()-> String {
        switch self {
        case .MassageCenter: return "MY_BOOKING_TYPE_AT_MASSAGE_CENTER".localized()
        case .AtHotelOrRoom: return "MY_BOOKING_TYPE_AT_HOME_OR_HOTEL".localized()
        }
    }
    func getImage()-> String {
        switch self {
        case .MassageCenter: return ImageAsset.BookingType.center
        case .AtHotelOrRoom: return ImageAsset.BookingType.hotel
        }
    }
    init?(rawValue: String) {
        switch rawValue {
        case "1":
            self = .MassageCenter
        default:
            self = .AtHotelOrRoom
        }
    }
    func getParameterId() -> String {
        switch self {
        case .MassageCenter: return "1"
        case .AtHotelOrRoom: return "2"
        }
    }
}


enum DocumentType: String {
    case AddressProof  = "1"
    case IdentityProofFront  = "2"
    case IdentityProofBack = "3"
    case Insurance = "4"
    case FreelancerFinancialDocument = "5"
    case Certificates = "6"
    case CV = "7"
    case ReferenceLatter = "8"
    case PersonalExperience = "9"
    case Others = "10"

    func name() -> String {
        switch self {
        case .AddressProof:
            return "DOC_TYPE_ADDRESS_PROOF".localized()
        case .IdentityProofFront:
            return "DOC_TYPE_IDENTITY_PROOF_FRONT".localized()
        case .IdentityProofBack:
            return "DOC_TYPE_IDENTITY_PROOF_BACK".localized()
        case .Insurance:
            return "DOC_TYPE_INSURANCE".localized()
        case .FreelancerFinancialDocument:
            return "DOC_TYPE_FREELANCER_FINANCIAL_DOCUMENT".localized()
        case .Certificates:
            return "DOC_TYPE_CERTIFICATES".localized()
        case .CV:
            return "DOC_TYPE_CV".localized()
        case .ReferenceLatter:
            return "DOC_TYPE_REFERENCE_LATTER".localized()
        case .PersonalExperience:
            return "DOC_TYPE_PERSONAL_EXPERIENCE".localized()
        case .Others:
            return "DOC_TYPE_OTHERS".localized()
        }
    }
    func paramName() -> String {
        switch self {
        case .AddressProof:
            return "".localized()
        case .IdentityProofFront:
            return "document_id_passport_front"
        case .IdentityProofBack:
            return "document_id_passport_back"
        case .Insurance:
            return "document_insurance"
        case .FreelancerFinancialDocument:
            return "document_freelancer_financial_document"
        case .Certificates:
            return "document_certificates[]"
        case .CV:
            return "document_cv".localized()
        case .ReferenceLatter:
            return "document_reference_letter"
        case .PersonalExperience:
            return "document_personal_experience[]"
        case .Others:
            return "document_others[]"
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


