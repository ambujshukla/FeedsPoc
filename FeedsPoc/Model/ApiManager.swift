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
        //Here it is checking for network availability. if not present then show error.
        NetworkManager.isUnreachable { _ in
            CommonUtility.showErrorCRNotifications(message: kNetwork_Issue)
            return
        }
        
        CommonUtility.startLoader()
        
        Alamofire.request(url, method: .post , parameters: parameters, encoding: URLEncoding.default , headers: nil).responseString {response in
            print(response)
            if response.result.error == nil {
                completion(response)
            }else {
                failure(response.result.error as NSError?)
            }
            CommonUtility.stopLoader()
        }
    }
}


