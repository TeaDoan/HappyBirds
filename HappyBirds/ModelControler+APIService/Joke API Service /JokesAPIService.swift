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
        static let searchForJokes = URL(string: "https://icanhazdadjoke.com/search")
    }
   static func fetchJokes(completion: @escaping ([Value]?) -> Void) {
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
    
    static func searchJokes (searchTerm: String, completion: @escaping ([SearchJokes]?) -> ()) {
        guard let baseURL = Contants.searchForJokes else {return}
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let queryTearm = URLQueryItem(name:"term",value: searchTerm)
        let queryArray = [queryTearm]
        components?.queryItems = queryArray
        guard let fullUrl = components?.url else {completion(nil); return}
        var getRequest = URLRequest(url: fullUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30.0)
        getRequest.httpMethod = "GET"
        getRequest.setValue("tifdoan2210@gmail.com", forHTTPHeaderField:"User-Agent")
        getRequest.setValue("application/json", forHTTPHeaderField:"Accept")
        URLSession.shared.dataTask(with: getRequest) { (data, _, error) in
            if let error = error {
                print("Error sending request \(error.localizedDescription)")
            }
            guard let data = data else {completion(nil);return}
            let jsonDecoder = JSONDecoder()
            do {
                let jokeDict = try jsonDecoder.decode(Results.self, from: data)
                let joke = jokeDict.results.compactMap{$0}
                completion(joke)
            } catch let error {
                print("Error fetching joke \(error.localizedDescription) ")
            }
            }.resume()
    }
    }
    

