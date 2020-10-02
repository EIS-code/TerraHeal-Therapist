//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import Foundation
//Localizable Extension
public extension String
{
    
    func toCurrency(places:Int = 2) -> String {
        return appSingleton.currencySymbol + self.toDouble.toString(places: places)
    }
    func localized(comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }

    func localized(with arguments: [CVarArg]) -> String {
        return String(format: self.localized(), locale: nil, arguments: arguments)
    }
    
    func localizedCompare(string:String) -> Bool {
        let str1 = NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
        let str2 = NSLocalizedString(string, tableName: nil, bundle: Bundle.main, value: "", comment: "")
        return str1.caseInsensitiveCompare(str2) == .orderedSame
    }
    
    func localizedCaseCompare(string:String) -> Bool {
        let str1 = NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
        let str2 = NSLocalizedString(string, tableName: nil, bundle: Bundle.main, value: "", comment: "")
        return str1.compare(str2) == .orderedSame
    }

    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

}
