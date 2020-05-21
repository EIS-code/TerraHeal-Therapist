//
//  AlamofireHelper.swift

//
//  Created by Jaydeep on 07/02/17.
//  Copyright © 2017 Jaydeep. All rights reserved.


import UIKit
import Foundation
import Alamofire


public typealias APIManagerCompletion = ((Data?, [String:Any], String?) -> Void)
struct Connectivity {
    static let sharedInstance = NetworkReachabilityManager()!
    static var isConnectedToInternet:Bool {
        return self.sharedInstance.isReachable
    }
}


class AlamofireHelper: NSObject {
    static let POST_METHOD = "POST"
    static let GET_METHOD = "GET"
    static let PUT_METHOD = "PUT"
    var dataBlock:APIManagerCompletion={_,_,_ in}; //Completion Block

    override init() {
        super.init()
    }

    func getDataFrom(urlString: String, methodName: String, paramData: [String:Any] , block:@escaping APIManagerCompletion) {
        self.dataBlock = block
        if Connectivity.isConnectedToInternet {

        } else {
            Loader.hideLoading()
            let dictResponse:[String:Any] = [:]
            self.dataBlock(nil, dictResponse,"Internet Connection Error")
            Common.showAlert(message: "Internet Connection Error")
        }
        if (methodName == AlamofireHelper.POST_METHOD) {
            let request = AF.request(urlString, method: .post, parameters:  paramData)
            request.response { (response) in
                switch(response.result) {
                case .success(let value):
                    if value != nil {
                        print("Success")
                        print("Request URL:- \(urlString)\n")
                        print("Request Parameters:- \(paramData)\n")
                        let dictionary = try! value!.toDictionary()
                        print("Request Response:- \(dictionary)")
                        self.dataBlock(value!,dictionary.convertValues,nil)
                    }
                    break
                case .failure(let error):
                    Loader.hideLoading()
                    print("Failed")
                    print("Request URL:- \(urlString)\n")
                    print("Request Parameters:- \(paramData)\n")
                    print("Request Response:- \(response.data.dictionary)")
                    Common.showAlert(message: error.localizedDescription)
                    self.dataBlock(nil,[:],error.localizedDescription)
                }
                print(response.data.dictionary)
            }
        } else {
            let request = AF.request(urlString, method: .get, parameters:  paramData)
            request.response { (response) in
                switch(response.result) {
                case .success(let value):
                    if value != nil {
                        print("Success")
                        print("Request URL:- \(urlString)\n")
                        print("Request Parameters:- \(paramData)\n")
                        let dictionary = try! value!.toDictionary()
                        print("Request Response:- \(dictionary)")
                        self.dataBlock(value!,dictionary.convertValues,nil)
                    }
                    break
                case .failure(let error):
                    Loader.hideLoading()
                    print("Failed")
                    print("Request URL:- \(urlString)\n")
                    print("Request Parameters:- \(paramData)\n")
                    print("Request Response:- \(response.data.dictionary)")
                    Common.showAlert(message: error.localizedDescription)
                    self.dataBlock(nil,[:],error.localizedDescription)
                }
                print(response.data.dictionary)
            }
        }
    }

    func uploadDocumentToURL(urlString: String ,paramData: [String:Any] ,documents:[UploadDocumentDetail], paramName:String = "", block:@escaping APIManagerCompletion) {
        self.dataBlock = block

        let headers: HTTPHeaders
        headers = ["Content-type": "multipart/form-data",
                   "Content-Disposition": "form-data"]
        AF.upload(multipartFormData: { (multipartFormData) in

            for document in documents {
                multipartFormData.append(document.data!, withName: paramName, fileName: document.name, mimeType: "*/*")
            }
            for (key, value) in paramData {
                multipartFormData.append((value as! String).data(using: String.Encoding.utf8)!, withName: key)
            }
        }, to: urlString, method: .post, headers: headers).response { (response) in
            switch(response.result) {
            case .success(let value):
                if value != nil {
                    print("Success")
                    print("Request URL:- \(urlString)\n")
                    print("Request Parameters:- \(paramData)\n")
                    print("Request Headers:- \(String(describing: response.request?.allHTTPHeaderFields))\n")
                    let dictionary = try! value!.toDictionary()
                    print("Request Response:- \(dictionary)")
                    self.dataBlock(value!,dictionary.convertValues,nil)
                }
                break
            case .failure(let error):
                Loader.hideLoading()
                print("Failed")
                print("Request URL:- \(urlString)\n")
                print("Request Parameters:- \(paramData)\n")
                print("Request Response:- \(response.data.dictionary)")
                Common.showAlert(message: error.localizedDescription)
                self.dataBlock(nil,[:],error.localizedDescription)
            }
            print(response.data.dictionary)
        }
    }
}

