//
//  QuotesAPIService.swift
//  HappyBirds
//
//  Created by Thao Doan on 7/25/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import Foundation

class QuotesAPIService {
   private struct Contants {
      static let getQuotesBaseURL = URL(string:"https://talaikis.com/api/quotes/")
      static let programmingQuoteURL = URL(string:"http://quotes.stormconsultancy.co.uk/popular.json")
    }
   static func getQuotes(completion: @escaping ([Quotes]?) -> Void) {
        guard let url = Contants.getQuotesBaseURL else {
            print("Error with baseURL")
            completion(nil)
            return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error dowloading quote with Datatask \(error.localizedDescription)")
                completion(nil)
                return
            }
            guard let data = data else {return}
            let jsonDecoder = JSONDecoder()
            do {
                let quoteDict = try jsonDecoder.decode([Quotes].self, from: data)
                let quotesData = quoteDict.compactMap{$0}
                completion(quotesData)
                return
            } catch let error {
                print("Error decoding quotes \(error.localizedDescription)")
                completion(nil)
                return
            }
        }.resume()
    }
    
  static func getProgrammingQuote(completion: @escaping ([Quotes]?) -> Void) {
        guard let url = Contants.programmingQuoteURL else {
            print("Error with baseURL")
            completion(nil)
            return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error dowloading programming quotes with Datatask \(error.localizedDescription)")
                completion(nil)
                return
            }
            guard let data = data else {return}
            let jsonDecoder = JSONDecoder()
            do {
                let quoteDict = try jsonDecoder.decode([Quotes].self, from: data)
                let quotesData = quoteDict.compactMap{$0}
                completion(quotesData)
                return
            } catch let error {
                print("Error decoding progarmming quotes \(error.localizedDescription)")
                completion(nil)
                return
            }
            }.resume()
    }
    
}
