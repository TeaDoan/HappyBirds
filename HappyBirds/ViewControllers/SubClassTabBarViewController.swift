//
//  SubClassTabBarViewController.swift
//  HappyBirds
//
//  Created by Thao Doan on 8/6/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import UIKit

class SubClassTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
       delegate = self
    }

    @IBOutlet weak var homeButtonTapped: UITabBar!
    
}

extension SubClassTabBarViewController: UITabBarControllerDelegate  {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        guard let fromView = selectedViewController?.view, let toView = viewController.view else {
            return false // Make sure you want this as false
        }
        
        if fromView != toView {
            UIView.transition(from: fromView, to: toView, duration: 0.3, options: [.transitionCrossDissolve], completion: nil)
        }
        
        return true
    }
}
