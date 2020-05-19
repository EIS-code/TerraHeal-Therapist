//
//  Created by Jaydeep on 21/09/19.
//  Copyright © 2019 Jaydeep. All rights reserved.
//
import Foundation

class Constant: NSObject {
    static let typeIOS: String = "ios"
    static let AppName: String = "Terra Heals"

}

class MessageCode: NSObject {
    static let success: String = "200"
    static let validationError: String = "401"
    static let exception: String = "401"

}
struct Gender {
    static let Male  = "0"
    static let Female  = "1"
    static let Other  = "2"
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
    static let check = "✓"
}
