//
//  FavoriteTableViewCell.swift
//  HappyBirds
//
//  Created by Thao Doan on 7/26/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import UIKit


class FavoriteTableViewCell: UITableViewCell {
    
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
   
    override func awakeFromNib() {
        super.awakeFromNib()
//        contentView.addSubview(whiteRoundedView)
//        contentView.sendSubview(toBack: whiteRoundedView)
    }
    
   func formatContainerViewIfNeeded() {
        containerView.layer.cornerRadius = 8.0
        containerView.layer.masksToBounds = true
        containerView.layer.shadowOffset = CGSize(width: -1, height: 1)
        containerView.layer.shadowOpacity = 0.2
        containerView.applyGradient(colours: [UIColor.rgb(71, 207, 171), UIColor.rgb(56, 207, 150)])
    }
    

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var bodyTextLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
}
