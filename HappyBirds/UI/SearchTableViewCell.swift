//
//  SearchTableViewCell.swift
//  HappyBirds
//
//  Created by Thao Doan on 7/27/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
//    private lazy var whiteRoundedView: UIView = {
//        let view = UIView(frame: CGRect(x: 20, y: 18, width: self.contentView.frame.size.width - 40, height: 170))
//        view.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 0.9])
//        view.layer.masksToBounds = false
//        view.layer.cornerRadius = 8.0
//        view.layer.masksToBounds = true
//        view.layer.shadowOffset = CGSize(width: -1, height: 1)
//        view.layer.shadowOpacity = 0.2
//        view.applyGradient(colours:[UIColor.rgb(71, 207, 171),UIColor.rgb(56, 207, 150)] )
//        return view
//    }()
//
    override func awakeFromNib() {
        super.awakeFromNib()
//        contentView.addSubview(whiteRoundedView)
//        contentView.sendSubview(toBack: whiteRoundedView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func formatContainerViewIfNeeded() {
        searchCellBackgroundView.layer.cornerRadius = 8.0
        searchCellBackgroundView.layer.masksToBounds = true
        searchCellBackgroundView.layer.shadowOffset = CGSize(width: -1, height: 1)
        searchCellBackgroundView.layer.shadowOpacity = 0.2
        searchCellBackgroundView.applyGradient(colours: [UIColor.rgb(71, 207, 171), UIColor.rgb(56, 207, 150)])
    }
    
    @IBOutlet weak var searchCellBackgroundView: UIView!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
}
