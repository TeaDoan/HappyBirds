//
//  HappyBirdLaunchPageViewController.swift
//  HappyBirds
//
//  Created by Thao Doan on 8/7/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import UIKit

class HappyBirdLaunchPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let attributedText = NSMutableAttributedString(string:
            "\n Welcome To HappyBirds", attributes:[NSAttributedStringKey.font : UIFont.systemFont(ofSize: 25), NSAttributedStringKey.foregroundColor : #colorLiteral(red: 0, green: 0.8651906848, blue: 0.6215168834, alpha: 1)])
        attributedText.append(NSMutableAttributedString(string: "\n \n Daily Random Jokes \n \n Hundred Of Famous Quotes \n\n Share Your Favortie Quotes and Jokes \n\n Search For Jokes", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 20),NSAttributedStringKey.foregroundColor : #colorLiteral(red: 0, green: 0.8651906848, blue: 0.6215168834, alpha: 1) ]))
        textView.attributedText = attributedText
        textView.textAlignment = .center
        textView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        startButton.layer.masksToBounds = true
        startButton.layer.cornerRadius = 10
        startButton.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        startButton.setTitleColor(#colorLiteral(red: 0, green: 0.8509803922, blue: 0.5529411765, alpha: 1), for: .normal)
        startButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        startButton.layer.borderWidth = 1.5
        startButton.layer.borderColor = UIColor.rgb(0, 217, 141).cgColor
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var startButton: UIButton!
    
    @IBAction func startButtonTapped(_ sender: Any) {
    }
    
    @IBOutlet weak var textView: UITextView!
    
    
}
