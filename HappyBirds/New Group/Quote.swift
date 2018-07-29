//
//  Quotes.swift
//  HappyBirds
//
//  Created by Thao Doan on 7/25/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import Foundation

// 2 network calls is using this class because the json format are the same
class Quote: Codable {
    
    var author: String?
    var quote : String?
    var isFavorite: Bool? = false
    
    init(author: String, quote:String, isFavorite: Bool = false) {
        self.author = author
        self.quote = quote
        self.isFavorite = isFavorite
    }
    
}
