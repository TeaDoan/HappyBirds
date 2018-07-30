//
//  FavoriteToShareViewController.swift
//  HappyBirds
//
//  Created by Thao Doan on 7/28/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import UIKit

class FavoriteToShareViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var favoriteToShare : Favorite?
    var randomPhoto = Array(1...104).compactMap {"us\($0)"}

    override func viewDidLoad() {
        super.viewDidLoad()
        if isViewLoaded {
            updateViews()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
  
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var shareImageView: UIImageView!
    @IBAction func camareButtonTapped(_ sender: Any) {
        let imagePickerControler = UIImagePickerController()
        imagePickerControler.delegate = self
        let actionSheetController = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        actionSheetController.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action : UIAlertAction) in
            imagePickerControler.sourceType = .camera
            self.present(imagePickerControler, animated: true, completion: nil)
        }))
        actionSheetController.addAction(UIAlertAction(title: "Photo library", style: .default, handler: { (action : UIAlertAction) in
            imagePickerControler.sourceType = .photoLibrary
            self.present(imagePickerControler, animated: true, completion: nil)
        }))
        actionSheetController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheetController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        shareImageView.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func randomButtonTapped(_ sender: Any) {
        updateShareImageViews()
    }
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        let userActivityController = UIActivityViewController(activityItems: [bodyTextView.text], applicationActivities: nil)
        present(userActivityController, animated: true, completion: nil)
        
}
    
    func updateViews() {
        guard let favoriteToShare = favoriteToShare else {return}
        bodyTextView.text = favoriteToShare.text
        bodyTextView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
    }
    func updateShareImageViews() {
        let rand = Int(arc4random_uniform(UInt32(randomPhoto.count)))
        UIGraphicsBeginImageContext(view.frame.size)
        UIImage(named:randomPhoto[rand])?.draw(in: self.view.frame)
        let imageToShow : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.shareImageView.backgroundColor = UIColor(patternImage: imageToShow)
        shareImageView.contentMode = .scaleAspectFit
    }
}
