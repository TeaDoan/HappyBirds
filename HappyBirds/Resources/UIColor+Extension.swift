//
//  UIColor+Extension.swift
//  HappyBird
//
//  Created by Thao Doan on 7/10/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgb(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

