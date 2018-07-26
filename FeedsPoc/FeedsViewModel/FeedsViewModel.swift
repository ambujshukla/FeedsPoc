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
    
    /*weak can't be use in this block as this is struct and thus a value type. As
      it is relevant to reference counting and only classes are reference counted.*/
    func getFeedsData(completion: ((FeedsModel) -> Void)?) {
        ApiManager.sharedInstance.getFeeds(methodName:"", parameters: [:], completion: { (responseData) in
            if let resultData = Mapper<FeedsModel>().map(JSON: self.convertToDictionary(text: responseData.result.value!)! ){
                completion!(resultData)
            }
            print("")
        }) { (error) in
            CommonUtility.showErrorCRNotifications(message: (error?.localizedDescription)!)
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
