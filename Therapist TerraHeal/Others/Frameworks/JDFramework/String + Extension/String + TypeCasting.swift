//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import Foundation
import UIKit

public extension String  {
    
    fileprivate struct NumberFormat    {
        static let instance = NumberFormatter()
    }
   

     var toBool: Bool {
        
        switch self {
        case "True", "true", "yes", "1":
            return true
        case "False", "false", "no", "0":
            return false
        default:
            return false
        }
    }
     var toDouble: Double {
        
        return NumberFormat.instance.number(from: self)?.doubleValue ?? 0.0
    }
     var toInt: Int {
        
        return NumberFormat.instance.number(from: self)?.intValue ?? 0
    }
    
     func toDate (format: String) -> Date {
        
        let formatter = DateFormatter()
        formatter.dateFormat=format
        return formatter.date(from: self) ?? Date()
    }

    func formatDate(from:String, to:String)  -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = from
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        if let dateFromString = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = to
            return dateFormatter.string(from: dateFromString)  // 19-08-2015 06:00 AM -0300"
        }
        return ""
    }

    func getUnderLineAttributedText() -> NSMutableAttributedString {
        let attributedText = NSMutableAttributedString(string: self)
        attributedText.addAttribute(NSMutableAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedText.length))
        return attributedText
    }


}


public extension Int {
    func toString() -> String {
        return   String(self )
    }
}

public extension Float {
    func toString() -> String {
        return   String(self )
    }
}

public extension Double {

    func roundTo(places:Int = 2) -> Double {
        
        let divisor = pow(10.00, Double(places))
        return (self * divisor).rounded() / divisor
    }
    func toString(places:Int = 2) -> String {
        
        return String(format:"%."+places.description+"f", self)
    }
    func toInt() -> Int {
        
        if self > Double(Int.min) && self < Double(Int.max) {
            return Int(self)
        }
        else {
            return 0
        }
    }
   

}

public struct Units {

  public let bytes: Int64

  public var kilobytes: Double {
    return Double(bytes) / 1_024
  }

  public var megabytes: Double {
    return kilobytes / 1_024
  }

  public var gigabytes: Double {
    return megabytes / 1_024
  }

  public init(bytes: Int64) {
    self.bytes = bytes
  }

  public func getReadableUnit() -> String {

    switch bytes {
    case 0..<1_024:
      return "\(bytes) bytes"
    case 1_024..<(1_024 * 1_024):
      return "\(String(format: "%.2f", kilobytes)) kb"
    case 1_024..<(1_024 * 1_024 * 1_024):
      return "\(String(format: "%.2f", megabytes)) mb"
    case (1_024 * 1_024 * 1_024)...Int64.max:
      return "\(String(format: "%.2f", gigabytes)) gb"
    default:
      return "\(bytes) bytes"
    }
  }
}
