//
//  HomeViewController.swift
//  HappyBirds
//
//  Created by Thao Doan on 7/21/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import UIKit
import HomePageInfoKit

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    var homeTitle = "Random Jokes"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let textAttributes = [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0, green: 0.8651906848, blue: 0.6215168834, alpha: 1)]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
         fetchJokes()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchJokes()
        updateViews()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBAction func moreButtonTapped(_ sender: Any) {
    }
    
    // Mark: - Methods
    func updateViews() {
        let rand = Int(arc4random_uniform(UInt32(RandomJokesController.photoArray.count)))
        UIGraphicsBeginImageContext(view.frame.size)
        UIImage(named:RandomJokesController.photoArray[rand])?.draw(in: self.view.frame)
        let imageToShow : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: imageToShow)
        backgroundImageView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        backgroundImageView.contentMode = .scaleAspectFill
    }
    func fetchJokes() {
        if homeTitle == "Random Jokes" {
            RandomJokesController.fetchRanDomJoke { (jokes) in
                guard let jokes = jokes else {return}
                DispatchQueue.main.async {
                    self.bodyTextView.text = jokes.joke
                    self.bodyTextView.contentMode = .center
                    self.bodyTextView.layer.masksToBounds = true
                    self.bodyTextView.layer.cornerRadius = 10
                    self.bodyTextView.backgroundColor = #colorLiteral(red: 0.1607843137, green: 0.168627451, blue: 0.2078431373, alpha: 1).withAlphaComponent(0.2)
                    self.bodyTextView.textContainerInset = UIEdgeInsetsMake(self.bodyTextView.bounds.height/4, 20, 0, 20);
                    self.titleLabel.text = self.homeTitle
                }
                
            }
        }
    }
}
