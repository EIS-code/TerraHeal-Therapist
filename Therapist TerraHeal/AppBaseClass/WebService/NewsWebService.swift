//
//  UserGiveReviewToStore.swift
//  ShoppingApp
//
//  Created by Jaydeep on ""4/11/19.
//  Copyright © 2""19 Jaydeep. All rights reserved.
//

import Foundation

//MARK: Request Models
class NewsWebService {
    static let url: String = API_URL.GetNews
    struct RequestReadNews: Codable {
        var id: String = PreferenceHelper.shared.getUserId()
        var news_id: String = ""
    }
}

//MARK: Response Models
extension NewsWebService {
    class Response :  ResponseModel {
        var newsList: [NewsData] = []
        override init(fromDictionary dictionary: [String:Any]) {
            super.init(fromDictionary: dictionary)
            newsList.removeAll()
            if let dataArray = dictionary["data"] as? [[String:Any]] {
                for data in dataArray {
                    newsList.append(NewsData.init(fromDictionary: data))
                }
            }
        }
    }

    class NewsData{
        var descriptionField: String = ""
        var id: String = ""
        var subTitle: String = ""
        var title: String = ""
        var updatedAt: String = ""
        var isRead: Bool = false
        /**
         * Instantiate the instance using the passed dictionary values to set the properties values
         */
        init(fromDictionary dictionary: [String:Any]){
            self.descriptionField = (dictionary["description"] as? String) ?? ""
            self.id = (dictionary["id"] as? String) ?? ""
            self.subTitle = (dictionary["sub_title"] as? String) ?? ""
            self.title = (dictionary["title"] as? String) ?? ""
            self.updatedAt = (dictionary["updated_at"] as? String) ?? ""
        }

    }
}


//MARK: WebServiceCall
extension NewsWebService {
    static func getUpdatedNews(completionHandler: @escaping ((NewsWebService.Response) -> Void)) {
        AppWebApi.getNews { (response) in
            completionHandler(response)
        }
    }
    static func readNews(params:NewsWebService.RequestReadNews, completionHandler: @escaping ((NewsWebService.Response) -> Void)) {
        AppWebApi.readNews(params: params) { (response) in
            completionHandler(response)
        }
    }
}

