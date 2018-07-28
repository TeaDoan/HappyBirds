//
//  FavoriteToShareViewController.swift
//  HappyBirds
//
//  Created by Thao Doan on 7/28/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import UIKit
import Social

class FavoriteToShareViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    @IBOutlet weak var shareImageView: UIImageView!
    
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        
        //Alert
        let alert = UIAlertController(title: "Share", message: "Share Jokes", preferredStyle: .actionSheet)
        
        //First action
        let actionOne = UIAlertAction(title: "Share on Facebook", style: .default) { (action) in
            
            //Checking if user is connected to Facebook
            if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook)
            {
                let post = SLComposeViewController(forServiceType: SLServiceTypeFacebook)!
                
                post.setInitialText("Poem of the day")
                post.add(UIImage(named: "us10"))
                
                self.present(post, animated: true, completion: nil)
                
            } else {self.showAlert(service: "Facebook")}
        }
        
        //Second action
        let actionTwo = UIAlertAction(title: "Share on Twitter", style: .default) { (action) in
            
            //Checking if user is connected to Facebook
            if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter)
            {
                let post = SLComposeViewController(forServiceType: SLServiceTypeTwitter)!
                
                post.setInitialText("Poem of the day")
                post.add(UIImage(named: "us20"))
                
                self.present(post, animated: true, completion: nil)
                
            } else {self.showAlert(service: "Twitter")}
    }
        let actionThree = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        //Add action to action sheet
        alert.addAction(actionOne)
        alert.addAction(actionTwo)
        alert.addAction(actionThree)
        
        //Present alert
        self.present(alert, animated: true, completion: nil)
    
}

    func showAlert(service:String)
    {
        let alert = UIAlertController(title: "Error", message: "You are not connected to \(service)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
}

}
