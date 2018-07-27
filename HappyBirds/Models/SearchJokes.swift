//
//  SearchJokes.swift
//  HappyBirds
//
//  Created by Thao Doan on 7/26/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import Foundation
struct SearchJokes: Codable {
    var joke : String?
}
struct Results: Codable{
    var results : [SearchJokes]
}
