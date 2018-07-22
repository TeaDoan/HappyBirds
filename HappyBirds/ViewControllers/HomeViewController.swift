//
//  HomeViewController.swift
//  HappyBirds
//
//  Created by Thao Doan on 7/21/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchJokes()
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
        backgroundImageView.contentMode = .scaleAspectFit
    }
    func fetchJokes() {
        RandomJokesController.fetchRanDomJoke { (jokes) in
            guard let jokes = jokes else {return}
            DispatchQueue.main.async {
                self.bodyTextView.text = jokes.joke
                self.bodyTextView.contentMode = .center
                self.titleLabel.text = "Random Jokes "
            }
           
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
