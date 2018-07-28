//
//  FeedsModelTest.swift
//  FeedsPocTests
//
//  Created by Ambuj Shukla on 28/07/18.
//  Copyright © 2018 Ambuj Shukla. All rights reserved.
//

import Foundation

import ObjectMapper

class FeedsModelTest: NSObject, Mappable {
    
    var title : String?
    var rows : [RowsModelTest]?
    
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
