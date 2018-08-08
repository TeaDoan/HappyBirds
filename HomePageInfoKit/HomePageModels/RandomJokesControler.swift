//
//  RandomJokesControler.swift
//  HappyBirds
//
//  Created by Thao Doan on 7/21/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import Foundation


public class RandomJokesController {
    
public static let photoArray = Array(1...104).compactMap { "us\($0)" }
public struct Contants {
         static let randomJokeBaseURL = URL(string: "https://icanhazdadjoke.com/")
         static let randomQuoteBaseURL = URL(string: "http://quotes.rest/qod.json")
    }
public static func fetchRanDomJoke(completion: @escaping (RandomJokes?) -> Void) {
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
    
   public static func fetchQuote(completion: @escaping ([RandomQuotes]?) -> Void){
        guard let url = Contants.randomQuoteBaseURL else {
            print("Error with baseURL")
            completion(nil)
            return}
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error downloading quotes with Datatask : \(error)")
                completion(nil)
                return
            }
            guard let data = data else {completion(nil); return}
            let jsonDecoder = JSONDecoder()
            
            do {
                let dictict = try jsonDecoder.decode(ToplevelData.self, from: data)
                let quote = dictict.contents.quotes
                completion(quote)
                
            } catch let error {
                print("Error decoding quotes from data task: \(error.localizedDescription)")
                completion(nil)
                return
            }
            }.resume()
    }
}
