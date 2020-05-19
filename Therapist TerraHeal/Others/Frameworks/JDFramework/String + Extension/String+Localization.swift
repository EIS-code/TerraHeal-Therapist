//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import Foundation
//Localizable Extension
public extension String
{
    func localized(comment: String = "") -> String {
        
        return NSLocalizedString(self, comment: comment)
    }

    var localized: String {
        
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    var localizedCapitalized: String {
        
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "").capitalized
    }
    var localizedUppercase: String {
        
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "").uppercased()
    }
    var localizedLowercase: String {
        
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "").lowercased()
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
