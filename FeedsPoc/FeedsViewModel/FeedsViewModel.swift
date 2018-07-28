//
//  FeedsViewModel.swift
//  FeedsPoc
//
//  Created by Ambuj Shukla on 23/07/18.
//  Copyright © 2018 Ambuj Shukla. All rights reserved.
//

import Foundation
import ObjectMapper

private let InternalServerError = "Some error occured. Please try again."

struct FeedsViewModel {
    var feedsData = FeedsModel()
}

extension FeedsViewModel {
    
    /*[weak self] can't be use in this block as this is struct and thus a value type. As it is relevant to reference counting and only classes are reference counted.*/
    func getFeedsData(completion: ((FeedsModel) -> Void)?) {
        ApiManager.sharedInstance.getFeeds(methodName:"", parameters: [:], completion: { (responseData) in
            //Here we need to refractor the code if in case the coming response is not a proper json.
            if let dict = self.convertToDictionary(text: responseData.result.value!) {
                if let resultData = Mapper<FeedsModel>().map(JSON: dict){
                    completion!(resultData)
                }
            }else {
                CommonUtility.showErrorCRNotifications(message: InternalServerError)
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
