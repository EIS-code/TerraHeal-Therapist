//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import Foundation

public extension String {

    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }

    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    func isEmpty() -> Bool {
        return self.trim().isEmpty
    }

    func isValidEmail() -> Bool  {

        let stremail = self.trimmingCharacters(in:CharacterSet.whitespacesAndNewlines);
        if stremail.count > 0 {
            let stricterFilterString:String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
            let emailRegex:String = stricterFilterString;
            let emailTest:NSPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex);
            return emailTest.evaluate(with: self);
        }
        else {
            return false;
        }
    }
    func isNumber() -> Bool {

        let numberCharacters = CharacterSet.decimalDigits.inverted
        return !self.isEmpty() && self.rangeOfCharacter(from:numberCharacters) == nil
    }
    func maxLength(length: Int) -> String {

        var str = self
        let nsString = str as NSString
        if nsString.length >= length {
            str = nsString.substring(with:
                NSRange(
                    location: 0,
                    length: nsString.length > length ? length: nsString.length)
            )
        }
        return  str
    }

    var isPhoneNumber: Bool {
        get {

            let PHONE_REGEX = "^((\\+)|(00))[0-9]{6,14}$"
            let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
            _ = phoneTest.evaluate(with: self)
            return !isEmpty()
        }
    }

    var isValidPassword: Bool {
        get {
            return !self.isEmpty;
        }
    }


    func grouping(every groupSize: String.IndexDistance, with separator: Character) -> String {
            let cleanedUpCopy = replacingOccurrences(of: String(separator), with: "")

            return String(cleanedUpCopy.enumerated().map() {
                $0.offset % groupSize == 0 ? [separator, $0.element]: [$0.element]
            }.joined().dropFirst())
    }


}

