//
//  TodayViewController.swift
//  HomePage Widget
//
//  Created by Thao Doan on 7/22/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import UIKit
import NotificationCenter
import HomePageInfoKit

class TodayViewController: UIViewController, NCWidgetProviding {
    
    // MARK - Properties
    override func viewDidLoad() {
        super.viewDidLoad()
//        RandomJokesController.fetchRanDomJoke { (jokes) in
//            guard let jokes = jokes else {return}
//            DispatchQueue.main.async {
//                self.bodyTextLabel.text = jokes.joke
//            }
//        }
    }
    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
                RandomJokesController.fetchRanDomJoke { (jokes) in
                    guard let jokes = jokes else {return}
                    DispatchQueue.main.async {
                        self.bodyTextLabel.text = jokes.joke
                    }
                }
    }
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var bodyTextLabel: UILabel!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        RandomJokesController.fetchRanDomJoke { (jokes) in
            guard let jokeData = jokes else {
                completionHandler(NCUpdateResult.noData)
                return
            }
            OperationQueue.main.addOperation {() -> Void in
                self.bodyTextLabel.text = jokeData.joke.capitalized
                self.bodyTextLabel.textAlignment = .center
            }
        }
        
        completionHandler(NCUpdateResult.newData)
    }
    
   
}
