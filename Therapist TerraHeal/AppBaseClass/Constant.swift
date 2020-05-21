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
struct Gender {
    static let Male  = "m"
    static let Female  = "f"
    static let Other  = "t"
}

struct LoginBy {
    static let Social  = "1"
    static let Manual  = "0"
}

struct FontSymbol {
    static let arrow = "→"
    static let check = "✓"
}

struct DateFormat {
    static let DD_MM_YYYY = "dd/MM/YYYY"
    static let DOB = "YYYY-MM-dd"
    static let check = "✓"
}

struct UploadDocumentDetail {
    var id: String  = ""
    var name: String  = ""
    var image: UIImage? = nil
    var data: Data? = nil
    var isCompleted: Bool  = false
}

struct DocumentType {
    static let addressProof: String  = "1"
    static let identityProof: String  = "2"
    static let insuranceProof: String = "3"
}
 
