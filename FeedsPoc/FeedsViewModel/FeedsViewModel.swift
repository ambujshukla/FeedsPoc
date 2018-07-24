//
//  FeedsViewModel.swift
//  FeedsPoc
//
//  Created by Ambuj Shukla on 23/07/18.
//  Copyright © 2018 Ambuj Shukla. All rights reserved.
//

import Foundation
import ObjectMapper

struct FeedsViewModel {
    var feedsData = FeedsModel()
}

extension FeedsViewModel {
    
    func getFeedsData(completion: @escaping ((FeedsModel) -> Void)) {
        ApiManager.sharedInstance.getFeeds(methodName:"", parameters: [:], completion: { (responseData) in
            if let resultData = Mapper<FeedsModel>().map(JSON: self.convertToDictionary(text: responseData.result.value!)! ){
                completion(resultData)
            }
            print("")
        }) { (error) in
            print(error!)
        }
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}
