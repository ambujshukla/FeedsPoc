//
//  FeedsViewModel.swift
//  FeedsPoc
//
//  Created by Ambuj Shukla on 23/07/18.
//  Copyright © 2018 Ambuj Shukla. All rights reserved.
//

import Foundation

struct FeedsViewModel {
    
}

extension FeedsViewModel {
    
    func getFeedsData(completion: @escaping ((FeedsModel) -> Void)) {
        let apiManager = ApiManager()
        
        apiManager.getFeeds(methodName: "", parameters: [:], completion: { (responseData) in
            if let jsonObject : [String : Any] = responseData.result.value as? [String : Any]{
                let statusCode = jsonObject["result_code"] as! Bool
                if statusCode {
                    do {
                        if let data = responseData.data {
                            let decoder = JSONDecoder()
                            let feedsModel = try decoder.decode(FeedsModel.self, from: data)
                            completion(feedsModel)
                        }
                    } catch  {
                     //   CommonUtility.showErrorCRNotifications(title: NSLocalizedString("title.error.occur", comment: "Error is shown when the json is unable to decode"), message: jsonObject["message"] as! String)
                    }
                }else {
                  //  CommonUtility.showErrorCRNotifications(title: appTitle(), message: jsonObject["message"] as! String)
                }
            }
        }) { (error) in
        }
    }
}
