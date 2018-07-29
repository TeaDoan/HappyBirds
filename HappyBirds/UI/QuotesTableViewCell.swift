//
//  QuotesTableViewCell.swift
//  HappyBirds
//
//  Created by Thao Doan on 7/25/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import UIKit

protocol FavoriteButtonClickDelegate: class {
    func didSet(cell: QuotesTableViewCell, isFavorite: Bool)
}

class QuotesTableViewCell: UITableViewCell {

    var quote : Quote? {
        didSet { favoriteButton.isSelected = quote?.isFavorite ?? false }
    }
    
    weak var delegate : FavoriteButtonClickDelegate?
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var quoteLabel: UILabel!
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        delegate?.didSet(cell: self, isFavorite: !sender.isSelected)
        sender.pulse(selected: !sender.isSelected)
    }
    
}

private extension UIButton {
    
    func pulse(selected: Bool) {
        self.isSelected = selected
        UIButton.animate(withDuration: 0.15, animations: {
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }, completion: { finish in
            UIButton.animate(withDuration: 0.3, animations: {
                self.transform = .identity
            })
        })
    }
}
