//
//  RowsDataModel.swift
//  test
//
//  Created by cdn68 on 24/07/18.
//  Copyright © 2018 cdn. All rights reserved.
//

import Foundation
import ObjectMapper

class RowsDataModel: Mappable {
    
    var title : String?
    var imageHref : String?
    var description : String?
    
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        title <- map["title"]
        imageHref <- map["imageHref"]
        description <- map["description"]
        
    }
}
