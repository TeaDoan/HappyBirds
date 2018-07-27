//
//  FavoriteTableViewCell.swift
//  HappyBirds
//
//  Created by Thao Doan on 7/26/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var bodyTextLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var detailLabel: UILabel!
    @IBAction func shareButtonTapped(_ sender: Any) {
    }
    
}
