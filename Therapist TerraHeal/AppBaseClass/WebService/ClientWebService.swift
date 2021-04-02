//
//  UserGiveReviewToStore.swift
//  ShoppingApp
//
//  Created by Jaydeep on ""4/11/19.
//  Copyright © 2""19 Jaydeep. All rights reserved.
//

import Foundation

//MARK: Request Models
class ClientWebService {
    static let url: String = API_URL.GetClientList
    struct RequestClientList: Codable {
        var search_val: String = ""
    }
    class Response: ResponseModel {
        var clientList: [Client] = []
        override init(fromDictionary dictionary: [String:Any]) {
            super.init(fromDictionary: dictionary)
            clientList.removeAll()
            if let dataArray = dictionary["data"] as? [[String:Any]] {
                for data in dataArray {
                    clientList.append(Client.init(fromDictionary: data))
                }
            }
        }
    }


}

class Client: Codable {
    
    var id: String = ""
    var name: String = ""
    var isSelected:Bool = false
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
     init(fromDictionary dictionary: [String:Any]) {
        self.id = (dictionary["id"] as? String) ?? ""
        self.name = (dictionary["name"] as? String) ?? ""
    }
}
//MARK: WebServiceCall
extension ClientWebService {
    static func getAllClients(params:ClientWebService.RequestClientList, completionHandler: @escaping ((ClientWebService.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: Self.url, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = ClientWebService.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
}
