//
//  ApiManager.swift
//  FeedsPoc
//
//  Created by Ambuj Shukla on 23/07/18.
//  Copyright © 2018 Ambuj Shukla. All rights reserved.
//

import Foundation
import Alamofire

class ApiManager {
    
    func getFeeds(methodName:String, parameters: [String : Any], completion: @escaping ((DataResponse<Any>) -> Void),failure: @escaping ((NSError?)) -> Void) {
        self.callService(url: "\(kBaseUrl)\(methodName)", parameters: parameters, completion: { (responseData) in
            completion(responseData)
        }) { (error) in
            failure(error as NSError?)
        }
    }
    
    func callService(url: String, parameters: [String : Any], completion: @escaping ((DataResponse<Any>) -> Void), failure: @escaping ((NSError?) -> Void))
    {
//        NetworkManager.isUnreachable { _ in
//            CommonUtility.showErrorCRNotifications(title: "No Internet Connection", message: "Connect your device with Internet")
//            return
//        }

   //     CommonUtility.startLoader()
        
        let headers: HTTPHeaders = [:]
        //[
//            "Content-Type":"text/plain",
//            "Accept": "text/plain"
//        ]

        Alamofire.request(url, method: .get , parameters: parameters, encoding: URLEncoding.default , headers: headers).validate()
            .responseString {response in
            print(response)
                self.convertStringToDictionary(text: response.result.value!)
//                if let data = response.data(using: .utf8) {
//                    do {
//                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
//                        print(json)
//                    } catch {
//                        print(error.localizedDescription)
//                    }
//                }
            if response.result.error == nil {
                //completion(response)
             //   CommonUtility.stopLoader()
            }else {
                failure(response.result.error as NSError?)
             //   CommonUtility.stopLoader()
            }
        }
    }
    
    func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        if let data = text.data(using: String.Encoding.utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject]
                return json
            } catch {
                print("Something went wrong")
            }
        }
        return nil
    }
}
