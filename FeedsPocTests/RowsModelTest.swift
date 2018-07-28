//
//  RowsModelTest.swift
//  FeedsPocTests
//
//  Created by Ambuj Shukla on 28/07/18.
//  Copyright © 2018 Ambuj Shukla. All rights reserved.
//

import Foundation

import ObjectMapper

class RowsModelTest: Mappable {
    
    var title : String?
    var imageHref : String?
    var description : String?
    var id: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        title <- map["title"]
        imageHref <- map["imageHref"]
        description <- map["description"]
        id <- map["id"]
    }
}
