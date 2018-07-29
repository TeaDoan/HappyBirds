//
//  Jokes.swift
//  HappyBirds
//
//  Created by Thao Doan on 7/25/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import Foundation

struct JokeTopLevelJson: Codable {
    var value : [Joke]
}
class Joke: Codable {
    let joke : String?
    var isFavorite : Bool? = false
    init(joke:String, isFavorite: Bool = false) {
        self.joke = joke
        self.isFavorite = isFavorite
    }
    
}
