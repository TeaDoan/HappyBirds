//
//  FavoriteToShareViewController.swift
//  HappyBirds
//
//  Created by Thao Doan on 7/28/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import UIKit

enum ImageState {
    case none
    case user(UIImage)
    case random(UIImage)
}


class FavoriteToShareViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var state: ImageState = .none {
        didSet {
            updateShareImageView()
        }
    }
    
    var favoriteToShare : Favorite?
    var randomPhoto = Array(1...104).compactMap {"us\($0)"}

    override func viewDidLoad() {
        super.viewDidLoad()
        if isViewLoaded {
            updateViews()
            
        }
    }
    
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var shareImageView: UIImageView!
    @IBAction func camareButtonTapped(_ sender: Any) {
        let imagePickerControler = UIImagePickerController()
        imagePickerControler.delegate = self
        let actionSheetController = UIAlertController(title: "Select Photo Location", message: nil, preferredStyle: .actionSheet)
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
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            state = .user(image)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func randomButtonTapped(_ sender: Any) {
        randomizeImage()
    }
    
    private func randomizeImage() {
        let rand = Int(arc4random_uniform(UInt32(randomPhoto.count)))
        UIGraphicsBeginImageContext(view.frame.size)
        UIImage(named:randomPhoto[rand])?.draw(in: self.view.frame)
        let imageToShow : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.state = .random(imageToShow)
    }
    
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        var userActivityController : UIActivityViewController
        if shareImageView.image == nil {
            userActivityController = UIActivityViewController(activityItems: [contentLabel.text ?? "There is nothing to share"], applicationActivities: nil)
        } else {
            userActivityController = UIActivityViewController(activityItems: [ textToImage(drawText: contentLabel.text!, inImage: shareImageView.asImage(), atPoint: CGPoint(x: 0, y: Int(shareImageView.frame.height - contentLabel.frame.height)*2))], applicationActivities: nil)
        }
        present(userActivityController, animated: true, completion: nil)
        
}
    
    func updateViews() {
        guard let favoriteToShare = favoriteToShare else {return}
        contentLabel.text = favoriteToShare.text
        contentLabel.backgroundColor = UIColor.black.withAlphaComponent(0.3)
    }
    
    func updateShareImageView() {
        switch state {
        case .none:
            shareImageView.image = nil
        case .user(let image):
            shareImageView.image = image
        case .random(let image):
            self.shareImageView.image = image
        }
    }
    
    func textToImage(drawText text: String, inImage image: UIImage, atPoint point: CGPoint) -> UIImage {
        let textColor = UIColor.white
        let textFont = UIFont(name: "Helvetica Bold", size: 20)!
        let background = UIColor.black.withAlphaComponent(0.3)
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(image.size,false, scale)
        
        let textFontAttributes = [
            NSAttributedStringKey.font: textFont,
            NSAttributedStringKey.foregroundColor: textColor,
            NSAttributedStringKey.backgroundColor: background
            ] as [NSAttributedStringKey : Any]
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
        
        let rect = CGRect(origin: point, size: image.size)
        text.draw(in: rect, withAttributes: textFontAttributes)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}

extension UIView {
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}


                        
