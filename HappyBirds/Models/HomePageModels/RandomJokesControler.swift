//
//  RandomJokesControler.swift
//  HappyBirds
//
//  Created by Thao Doan on 7/21/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import Foundation

class RandomJokesController {
    
    static let photoArray = Array(1...104).compactMap { "us\($0)" }
    struct Contants {
         static let randomJokeBaseURL = URL(string: "https://icanhazdadjoke.com/")
    }
 static func fetchRanDomJoke(completion: @escaping (RandomJokes?) -> Void) {
        guard let url = Contants.randomJokeBaseURL else {return}
        var getRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30.0)
        getRequest.httpMethod = "GET"
        getRequest.setValue("tifdoan2210@gmail.com", forHTTPHeaderField:"User-Agent")
        getRequest.setValue("application/json", forHTTPHeaderField:"Accept")
        
        URLSession.shared.dataTask(with: getRequest) { (data, response, error) in
            if let error = error {
                print("Error sending request \(error.localizedDescription)")
            }
            guard let data = data else {completion(nil);return}
            let jsonDecoder = JSONDecoder()
            do {
                let jokeDict = try jsonDecoder.decode(RandomJokes.self, from: data)
                completion(jokeDict)
            } catch let error {
                print("Error fetching random joke \(error.localizedDescription) ")
            }
            }.resume()
    }
}
