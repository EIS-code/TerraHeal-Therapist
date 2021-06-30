//
//  UserGiveReviewToStore.swift
//  ShoppingApp
//
//  Created by Jaydeep on ""4/11/19.
//  Copyright © 2""19 Jaydeep. All rights reserved.
//

import Foundation

class ServiceWebService {
    static let getAllServicesUrl: String = API_URL.GetServiceList
    struct RequestGetSeviceList: Codable {
        var user_id: String = PreferenceHelper.shared.getUserId()
    }

}

//MARK: Response Models
extension ServiceWebService {
    class Response :  ResponseModel {
        var serviceList: [Service] = []
        override init(fromDictionary dictionary: [String:Any]) {
            super.init(fromDictionary: dictionary)
            serviceList.removeAll()
            if let dataArray = dictionary["data"] as? [[String:Any]] {
                for data in dataArray {
                    serviceList.append(Service.init(fromDictionary: data))
                }
            }
            else if let data = dictionary["data"] as? [String:Any] {
                serviceList.append(Service.init(fromDictionary: data))
            }
        }
    }
}

class Service {
    var descriptionField: String = ""
    var icon: String = ""
    var id: String = ""
    var image: String = ""
    var name: String = ""
    var shopId: String = ""
    var type: ServiceType = .Massages
    var isSelected: Bool = false

    init(massage:Massage) {
        self.descriptionField = "massage.massageName"
        self.icon = massage.image
        self.id = massage.id
        self.image = massage.image
        self.name = massage.massageName
        self.shopId = massage.massageId
        self.type =  .Massages
    }
    init(therapy:Therapy) {
        self.descriptionField = "massage.massageName"
        self.icon = therapy.image
        self.id = therapy.id
        self.image = therapy.image
        self.name = therapy.therapyName
        self.shopId = therapy.therapyId
        self.type =  .Therapies
    }
    init(fromDictionary dictionary: [String:Any]){
        self.descriptionField = (dictionary["description"] as? String) ?? ""
        self.icon = (dictionary["icon"] as? String) ?? ""
        self.id = (dictionary["id"] as? String) ?? ""
        self.image = (dictionary["image"] as? String) ?? ""
        self.name = (dictionary["name"] as? String) ?? ""
        self.shopId = (dictionary["shop_id"] as? String) ?? ""

    }

}
//MARK: Web Service Calls
extension ServiceWebService {
    static func getAllServices(params:ServiceWebService.RequestGetSeviceList = ServiceWebService.RequestGetSeviceList.init() , completionHandler: @escaping ((ServiceWebService.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: Self.getAllServicesUrl, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = ServiceWebService.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    
}

