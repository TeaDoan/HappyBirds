//
//  JokesTableViewCell.swift
//  HappyBirds
//
//  Created by Thao Doan on 7/22/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import UIKit

class JokesTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var jokeLabel: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func favoriteButtonTapped(_ sender: Any) {
    }
}
