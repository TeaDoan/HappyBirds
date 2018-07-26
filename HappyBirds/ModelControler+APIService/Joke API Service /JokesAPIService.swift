//
//  APIService.swift
//  HappyBirds
//
//  Created by Thao Doan on 7/22/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import Foundation

class JokeAPIService {
    
    struct Contants {
        static let jokesBaseURL = URL(string:"http://api.icndb.com/jokes/$jokenumber")
    }
   static let shared = JokeAPIService()
    func fetchJokes(completion: @escaping ([Value]?) -> Void) {
        guard let url = Contants.jokesBaseURL else {return}
        URLSession.shared.dataTask(with: url) { (data , _, error) in
            if let error = error {
                print("Error downloading quotes with Datatask : \(error)")
                completion(nil)
                return
            }
            guard let data = data else {completion(nil);return}
            let jsonDecoder  = JSONDecoder()
            do {
                let toplevelData = try jsonDecoder.decode(JokeTopLevelJson.self, from: data)
                let jokeArray = toplevelData.value.compactMap{$0}
                completion(jokeArray)
                
            } catch let error {
                print("Error decoding quotes from data task: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            }.resume()
    }
    
}
