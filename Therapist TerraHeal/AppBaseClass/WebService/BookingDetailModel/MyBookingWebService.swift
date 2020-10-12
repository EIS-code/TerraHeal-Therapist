import Foundation



class MyBookingUserPeople{

    var age: String = ""
    var gender: String = ""
    var id: String = ""
    var name: String = ""
    var bookingMassages: [MyBookingMassage] = []

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        self.age = (dictionary["age"] as? String) ?? ""
        self.gender = (dictionary["gender"] as? String) ?? ""
        self.id = (dictionary["id"] as? String) ?? ""
        self.name = (dictionary["name"] as? String) ?? ""
        bookingMassages = [MyBookingMassage]()
        if let bookingMassagesArray = dictionary["booking_massages"] as? [[String:Any]]{
            for dic in bookingMassagesArray{
                let value = MyBookingMassage(fromDictionary: dic)
                bookingMassages.append(value)
            }
        }
    }

}
