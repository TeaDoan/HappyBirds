//
//  QuotesModelController.swift
//  HappyBirds
//
//  Created by Thao Doan on 7/26/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import Foundation
class QuotesModelController: FavoriteButtonClickDelegate {
    static let shared = QuotesModelController()
    func toggleIsFavorite(cell: QuotesTableViewCell){
        guard let quote = cell.quotes else {print("There was no Quote in the Cell") ; return }
        //        let favoriteQuote = FavoriteQuote(author: quote.author, quoteText: quote.quote)
        //        FavoriteQuoteController.shared.save(quote: favoriteQuote)
//        FavoriteQuotesController.shared.add(quote: quote.quote ?? "", author: quote.author ?? "")
        if quote.isFavorite != nil {
            quote.isFavorite! = !quote.isFavorite!
        } else {
            quote.isFavorite = true
        }
    }
}
