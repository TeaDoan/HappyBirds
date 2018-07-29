//
//  JokesTableViewCell.swift
//  HappyBirds
//
//  Created by Thao Doan on 7/22/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import UIKit

protocol FavoriteJokeButtonClickDelegate: class {
    func didSet(cell: JokesTableViewCell, isFavorite: Bool)
}

class JokesTableViewCell: UITableViewCell {
    
    var joke : Joke? {
        didSet { favoriteButton.isSelected = joke?.isFavorite ?? false }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    weak var delegate : FavoriteJokeButtonClickDelegate?

    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var jokeLabel: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

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

