//
//  FeedsModel.swift
//  FeedsPoc
//
//  Created by Ambuj Shukla on 23/07/18.
//  Copyright © 2018 Ambuj Shukla. All rights reserved.
//

import Foundation

import ObjectMapper

class FeedsModel: NSObject, Mappable {
    
    var title : String?
    var rows : [RowsDataModel]?
    
    required init?(map: Map) {
    }
    
    override init() {
        super.init()
    }
    
    func mapping(map: Map) {
        title <- map["title"]
        rows <- map["rows"]
    }
}
