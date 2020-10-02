//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import Foundation


public extension Data {

    func toDictionary() throws -> [String:Any] {
        if  let jsonString = String(data: self, encoding: String.Encoding.utf8) {
            guard let data = jsonString.data(using: .utf8) else { return [:] }
            let anyResult: Any = try JSONSerialization.jsonObject(with: data, options: [])
            return (anyResult as? [String: Any]) ?? [:]
        }
        return [:]
    }


}

public extension String {
    func convertToDictionary() throws -> [String: String] {
        guard let data = self.data(using: .utf8) else { return [:] }
        let anyResult: Any = try JSONSerialization.jsonObject(with: data, options: [])
        return (anyResult as? [String: Any])?.convertValues as! [String : String]
    }

    func htmlAttributedString() -> NSAttributedString? {
        do {
            guard let data = data(using: String.Encoding.utf8) else {
                return nil
            }
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }

}

public extension Dictionary {

    var jsonData: Data? {
        var jsonData: Data?
        do {
            let options = JSONSerialization.WritingOptions.prettyPrinted
            jsonData = try JSONSerialization.data(withJSONObject: self, options: options)
        }
        catch let error {
            print(error)
        }

        return jsonData
    }

    var convertValues: [String: Any] {
        
        var dictionary: [String: Any] = self as! [String : Any]
        let strEmpty: String = ""

        for (key, value) in dictionary {
            if value is NSNull {
                dictionary[key] = strEmpty
            }
            else if value is String {
                let str: String = value as! String
                dictionary[key] = String(format: "%@", str)
            }
            else if value is NSNumber {
                let number: NSNumber = value as! NSNumber
                dictionary[key] = number.stringValue
            }
            else if value is Array<Any> {
                let array: Array<Any> = value as! Array<Any>
                dictionary[key] = array.convertValues
            }
            else if value is Dictionary<AnyHashable, Any> {
                let dict: Dictionary<AnyHashable, Any> = value as! Dictionary<AnyHashable, Any>
                dictionary[key] = dict.convertValues
            }
            else {
                print("\(self) \(#function)")
                print("Undefined type \(value.self) of \((key, value))")
            }
        }

        return dictionary
    }

    func convertIntoJSONString() -> String? {

        do {
            let jsonData: Data = try JSONSerialization.data(withJSONObject: self, options: [])
            if  let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) {
                return jsonString as String
            }

        } catch let error as NSError {
            print("Array convertIntoJSON - \(error.description)")
        }
        return nil
    }

}

public struct JSON {
    static let encoder = JSONEncoder()
}
public extension Encodable {

    subscript(key: String) -> Any? {
        return dictionary[key]
    }
    var dictionary: [String: Any] {
        
        return (try? JSONSerialization.jsonObject(with: JSON.encoder.encode(self))) as? [String: Any] ?? [:]
    }
}

public extension Array {

    var jsonData: Data? {
        var jsonData: Data?
        
        do {
            let options = JSONSerialization.WritingOptions.prettyPrinted
            jsonData = try JSONSerialization.data(withJSONObject: self, options: options)
        }
        catch let error {
            print(error)
        }

        return jsonData
    }

    var convertValues: [Any] {
        
        var array: [Any] = self
        let strEmpty: String = ""

        for (index, element) in array.enumerated() {
            if element is NSNull {
                array[index] = strEmpty
            }
            else if element is String {
                let str: String = element as! String
                array[index] = String(format: "%@", str)
            }
            else if element is NSNumber {
                let number: NSNumber = element as! NSNumber
                array[index] = number.stringValue
            }
            else if element is Array<Any> {
                let arr: Array<Any> = element as! Array<Any>
                array[index] = arr.convertValues
            }
            else if element is Dictionary<AnyHashable, Any> {
                let dictionary: Dictionary<AnyHashable, Any> = element as! Dictionary<AnyHashable, Any>
                array[index] = dictionary.convertValues
            }
            else {
                print("\(self) \(#function)")
                print("Undefined type \(element.self) of \((index, element))")
            }
        }

        return array
    }

    func convertIntoJSONString() -> String? {

        do {
            let jsonData: Data = try JSONSerialization.data(withJSONObject: self, options: [])
            if  let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) {
                return jsonString as String
            }

        } catch let error as NSError {
            print("Array convertIntoJSON - \(error.description)")
        }
        return nil
    }



}


