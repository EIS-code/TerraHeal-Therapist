//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import Foundation

public extension NSObject {

    class var name: String {
        return String(describing: self)
    }

}

public extension Bundle {
    static var appVesion:String {
        return (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String)  ?? ""
    }
}

