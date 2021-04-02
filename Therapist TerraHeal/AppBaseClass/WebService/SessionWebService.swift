//
//  UserGiveReviewToStore.swift
//  ShoppingApp
//
//  Created by Jaydeep on ""4/11/19.
//  Copyright © 2""19 Jaydeep. All rights reserved.
//

import Foundation

//MARK: Request Models
class SessionWebService {
    static let getAllSessionsUrl: String = API_URL.GetSessionTypes

}

//MARK: Response Models
extension SessionWebService {
    class Response :  ResponseModel {
        var sessionList: [SessionType] = []
        var groupBySession:[SessionTypeDetails] = []
        override init(fromDictionary dictionary: [String:Any]) {
            super.init(fromDictionary: dictionary)
            sessionList.removeAll()
            groupBySession.removeAll()
            if let dataArray = dictionary["data"] as? [[[String:Any]]] {
                for subData in dataArray {
                    for sessionData in subData
                    {
                        let session =  SessionType.init(fromDictionary: sessionData)
                        sessionList.append(session)
                        self.createSessionList(session: session)
                    }
                }
            }
        }

        func createSessionList(session:SessionType) {
            if let index = groupBySession.firstIndex(where: { (sessionType) -> Bool in
                sessionType.id == session.booking_type
            }) {
                groupBySession[index].sessions.append(session)
            } else {
                let newSessionType = SessionTypeDetails.init(fromDictionary: [:])
                newSessionType.id = session.booking_type
                newSessionType.name = BookingType.init(rawValue: newSessionType.id)?.name() ?? ""
                newSessionType.image = BookingType.init(rawValue: newSessionType.id)?.getImage() ?? ""
                newSessionType.sessions = [session]
                groupBySession.append(newSessionType)
            }
        }

    }
}



class SessionType {
    var id: String = ""
    var type: String = ""
    var descriptions: String = ""
    var booking_type: String  = ""
    var icon: String = ""
    var isSelected:Bool = false

    init(fromDictionary dictionary: [String:Any]){
        self.id = (dictionary["id"] as? String) ?? ""
        self.type = (dictionary["type"] as? String) ?? ""
        self.descriptions = (dictionary["descriptions"] as? String) ?? ""
        self.booking_type = (dictionary["booking_type"] as? String) ?? ""
        self.icon = (dictionary["icon"] as? String) ?? ""
    }

}
//MARK: Web Service Calls
extension SessionWebService {
    static func getAllSessionTypes(completionHandler: @escaping ((SessionWebService.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: Self.getAllSessionsUrl, methodName: AlamofireHelper.GET_METHOD, paramData: [:]) { (data, dictionary, error) in
            let response = SessionWebService.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
}

//MARK: View Models

class SessionTypeDetails {
    var id: String = ""
    var name: String = ""
    var image: String = ""
    var isExpanded:Bool = false
    var sessions:[SessionType] = []
    init(fromDictionary dictionary: [String:Any]){
        self.id = (dictionary["id"] as? String) ?? ""
        self.name = (dictionary["type"] as? String) ?? ""
        self.image = (dictionary["image"] as? String) ?? ""
    }

}
