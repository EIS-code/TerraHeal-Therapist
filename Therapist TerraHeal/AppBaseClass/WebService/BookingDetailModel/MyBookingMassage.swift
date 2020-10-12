
import Foundation

class MyBookingMassage{

    var name : String = "thai yoga massage"
    var price : String = "200"
    var time : String = "90"
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init() {
    }
    init(fromDictionary dictionary: [String:Any]){
        self.name = (dictionary["name"] as? String) ?? ""
        self.price = (dictionary["price"] as? String) ?? ""
        self.time = (dictionary["time"] as? String) ?? ""
    }

}
