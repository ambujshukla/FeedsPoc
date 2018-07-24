//
//  ApiManager.swift
//  FeedsPoc
//
//  Created by Ambuj Shukla on 23/07/18.
//  Copyright © 2018 Ambuj Shukla. All rights reserved.
//

import Foundation
import Alamofire

class ApiManager: NSObject {
    
//    class var  sharedApiManager: ApiManager {
//        struct Static {
//            static var instance : ApiManager? = nil
//        }
//
//        if !(Static.instance != nil) {
//            Static.instance = ApiManager()
//        }
//        return Static.instance!
//    }
    
    static let sharedInstance = ApiManager()
    
    func getFeeds(methodName:String, parameters: [String : Any], completion: @escaping ((DataResponse<String>) -> Void),failure: @escaping ((NSError?)) -> Void) {
        self.callService(url: "\(kBaseUrl)\(methodName)", parameters: parameters, completion: { (responseData) in
            completion(responseData)
        }) { (error) in
            failure(error as NSError?)
        }
    }
    
    func callService(url: String, parameters: [String : Any], completion: @escaping ((DataResponse<String>) -> Void), failure: @escaping ((NSError?) -> Void))
    {
        //        NetworkManager.isUnreachable { _ in
        //            CommonUtility.showErrorCRNotifications(title: "No Internet Connection", message: "Connect your device with Internet")
        //            return
        //        }
        //        CommonUtility.startLoader()
        
        Alamofire.request(url, method: .post , parameters: parameters, encoding: URLEncoding.default , headers: nil).responseString {response in
            print(response)
            if response.result.error == nil {
                completion(response)
                //  CommonUtility.stopLoader()
            }else {
                failure(response.result.error as NSError?)
                //  CommonUtility.stopLoader()
            }
        }
    }
}


