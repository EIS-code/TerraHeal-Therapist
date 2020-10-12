
import Foundation

class MyBookingData {

   
   var bookingType: String = ""
   var id: String = ""
   var clientName:String = "sauravsingh"
   var massageDetail: [MyBookingMassage] = [MyBookingMassage.init(),MyBookingMassage.init(),MyBookingMassage.init(),MyBookingMassage.init(),MyBookingMassage.init()]
   var massageDate: String = "28 oct 2020"
   var massageTime: String = "13:00 - 14:30"
   var genderPreference: String = "male only"
   var pressurePreference: String = "medium pressure"
   var sessionType: String = "Single"
   var notes: String = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam"
   var injuriesNote: String = "Lorem ipsum dolor"
   var focusPreference: String = "head"



    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        /*self.massageDetail = MyBookingMassage()
        self.bookingType = (dictionary["booking_type"] as? String) ?? ""
        self.shopDescription = (dictionary["shop_description"] as? String) ?? ""
        self.id = (dictionary["id"] as? String) ?? ""
        self.shopName = (dictionary["shop_name"] as? String) ?? ""
        self.totalPrice = (dictionary["total_price"] as? String) ?? ""
        self.sessionType = (dictionary["session_type"] as? String) ?? ""
        self.massageTime = (dictionary["massage_time"] as? String) ?? ""*/



    }


}
