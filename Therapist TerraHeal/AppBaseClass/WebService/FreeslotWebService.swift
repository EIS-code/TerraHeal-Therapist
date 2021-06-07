//
//  FreeslotWebService.swift
//  Therapist TerraHeal
//
//  Created by Jaydeep Vyas on 19/05/21.
//  Copyright © 2021 Evolution. All rights reserved.
//

import Foundation

//MARK: Request Models
class FreeSlotWebService {
    static let getFreeSlotURL: String = API_URL.FreeSlot
    static let addFreeSlotURL: String = API_URL.AddFreeSlot
    struct RequestFreeSlots: Codable {
        var shop_id: String = appSingleton.user.shopId
        var date: String = "1621401916308"
    }
    struct RequestAddFreeSlots: Codable {
        var therapist_id: String = appSingleton.user.shopId
        var date: String = "1621401916308"
    }


}

//MARK: Response Models
extension FreeSlotWebService {
    class Response :  ResponseModel {
        override init(fromDictionary dictionary: [String:Any]) {
            super.init(fromDictionary: dictionary)
        }
    }
}

//MARK: Web Service Calls
extension FreeSlotWebService {
    class func getFreeSlots(params:FreeSlotWebService.RequestFreeSlots, completionHandler: @escaping ((FreeSlotWebService.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: Self.getFreeSlotURL, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = FreeSlotWebService.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
}

