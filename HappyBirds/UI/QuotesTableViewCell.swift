//
//  QuotesTableViewCell.swift
//  HappyBirds
//
//  Created by Thao Doan on 7/25/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import UIKit

protocol FavoriteButtonClickDelegate: class {
    func toggleIsFavorite(cell: QuotesTableViewCell)
}

class QuotesTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var quotes : Quotes? {
        didSet {
            updateViews()
        }
    }
    weak var delegate : FavoriteButtonClickDelegate?
    //Mark : IBOutlet
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var quoteLabel: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    // MARK: IBActions
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        UIButton.animate(withDuration: 0.5,
                         animations: {
                            sender.transform = CGAffineTransform(scaleX: 0.975, y: 0.96)
        },
                         completion: { finish in
                            UIButton.animate(withDuration: 0.5, animations: {
                                sender.transform = CGAffineTransform.identity
                            })
        })
    
        delegate?.toggleIsFavorite(cell: self)
        updateViews()
    }
    //MARK : Methods
    
    func updateViews() {
        guard quotes != nil else {return}
        if (favoriteButton != nil) {
            favoriteButton.setImage(#imageLiteral(resourceName: "favoriteActive"), for: .normal)
        } else {
            favoriteButton.setImage(#imageLiteral(resourceName: "favorite"), for: .normal)
        }
    }
}
