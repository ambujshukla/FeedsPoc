//
//  FeedsModel.swift
//  FeedsPoc
//
//  Created by Ambuj Shukla on 23/07/18.
//  Copyright © 2018 Ambuj Shukla. All rights reserved.
//

import Foundation

struct FeedsModel: Codable {
    
    var title: String?
    var rows: [Rows]
    
    enum CodingKeys: String, CodingKey {
        case rows = "rows"
    }
}

struct Rows: Codable {
    var title: String?
    var description: String?
    var imageHref: String?
}
