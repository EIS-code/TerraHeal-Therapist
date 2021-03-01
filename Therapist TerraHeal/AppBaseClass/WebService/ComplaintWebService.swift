//
//  UserGiveReviewToStore.swift
//  ShoppingApp
//
//  Created by Jaydeep on ""4/11/19.
//  Copyright © 2""19 Jaydeep. All rights reserved.
//

import Foundation

//MARK: Request Models
class ComplaintWebService {
    static let getAllComplaintUrl: String = API_URL.GetAllComplaints
    static let addComplaintUrl: String = API_URL.AddComplaints
    struct RequestAddComplaint: Codable {
        var complaint: String = ""
    }
    struct RequestAllComplaint: Codable {
        var Complaint: String = ""
    }
}

//MARK: Response Models
extension ComplaintWebService {
    class Response :  ResponseModel {
        var complaintList: [Complaint] = []
        override init(fromDictionary dictionary: [String:Any]) {
            super.init(fromDictionary: dictionary)
            complaintList.removeAll()
            if let dataArray = dictionary["data"] as? [[String:Any]] {
                for data in dataArray {
                    complaintList.append(Complaint.init(fromDictionary: data))
                }
            }
            else if let data = dictionary["data"] as? [String:Any] {
                    complaintList.append(Complaint.init(fromDictionary: data))
            }
        }
    }
}

class Complaint {
    var id: String = ""
    var shopId: String = ""
    var complaint: String = ""
    var therapistId: String = ""


        init(fromDictionary dictionary: [String:Any]){
            self.id = (dictionary["id"] as? String) ?? ""
            self.shopId = (dictionary["shop_id"] as? String) ?? ""
            self.complaint = (dictionary["complaint"] as? String) ?? ""
            self.therapistId = (dictionary["therapist_id"] as? String) ?? ""
        }

}
//MARK: Web Service Calls
extension ComplaintWebService {
   static func getAllComplaint(params:ComplaintWebService.RequestAllComplaint = ComplaintWebService.RequestAllComplaint.init() , completionHandler: @escaping ((ComplaintWebService.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: AppWebApi.URL.ForgotPassword, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = ComplaintWebService.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    static func requestAddComplaint(params:ComplaintWebService.RequestAddComplaint, completionHandler: @escaping ((ComplaintWebService.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: ComplaintWebService.addComplaintUrl, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = ComplaintWebService.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
}

