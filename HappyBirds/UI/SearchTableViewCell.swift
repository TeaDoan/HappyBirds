//
//  SearchTableViewCell.swift
//  HappyBirds
//
//  Created by Thao Doan on 7/27/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
}
