//
//  Jokes.swift
//  HappyBirds
//
//  Created by Thao Doan on 7/25/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import Foundation

struct JokeTopLevelJson: Codable {
    var value : [Value]
}
struct Value: Codable {
    let joke : String
}
