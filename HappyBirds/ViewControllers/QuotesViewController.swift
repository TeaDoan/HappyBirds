//
//  QuotesViewController.swift
//  HappyBirds
//
//  Created by Thao Doan on 7/25/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import UIKit

class QuotesViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    //MARK : Properties
     var photoArray = Array(1...104).compactMap {"us\($0)"}
    var imageDictionary = [IndexPath : UIImage]()
    var randomImageIndecies = Array(0...103)
    let cellIdentifier = "quoteCell"
    private var quotes : [Quotes] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    let textAttributes = [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0, green: 0.8651906848, blue: 0.6215168834, alpha: 1)]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
      fetchQuotes()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK : TableView DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier , for: indexPath) as! QuotesTableViewCell
        let quoteAtIndexPath = quotes[indexPath.row]
        tableView.separatorStyle = .none
        if let image = imageDictionary[indexPath] {
            cell.backgroundView = UIImageView(image: image)
        } else {
            let rand = Int(arc4random_uniform(UInt32(randomImageIndecies.count - 1)))
            UIGraphicsBeginImageContext(cell.frame.size)
            UIImage(named:photoArray[randomImageIndecies[rand]])?.draw(in: (cell.contentView.bounds))
            randomImageIndecies.remove(at: rand)
            if randomImageIndecies.count == 0 {
                randomImageIndecies = Array(0...photoArray.count)
            }
            let imageToShow : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            imageDictionary[indexPath] = imageToShow
            cell.backgroundView = UIImageView(image: imageToShow)
            cell.backgroundView?.contentMode = .scaleAspectFit
        }
        self.tableView.separatorStyle = .none
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 10
        cell.quoteLabel.text = quoteAtIndexPath.quote
        cell.quoteLabel.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        cell.authorLabel.text = quoteAtIndexPath.author ?? "Unknown"
        cell.delegate = QuotesModelController.shared
        cell.favoriteButton.contentMode = .scaleAspectFill
        
        return cell
    }
    
    //MARK : TableView Delegate
    
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            // IF you want this animation uncomment these lines.
    let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 100, 0)
            cell.layer.transform = rotationTransform
            //Define the final state (After the animation)
            UIView.animate(withDuration: 0.9, animations: { cell.layer.transform = CATransform3DIdentity })
        }
    
    //MARK : Methods
    
    func fetchQuotes() {
        QuotesAPIService.getQuotes { (quotes) in
            guard let quotes = quotes else {return}
            DispatchQueue.main.async {
                self.quotes = quotes
                self.tableView.reloadData()
                QuotesAPIService.getProgrammingQuote { (pQuote) in
                    guard let pQuote = pQuote else {return}
                    DispatchQueue.main.async {
                        self.quotes.append(contentsOf: pQuote)
                       self.tableView.reloadData()
                    }
                }
                
            }
        }
        
    }
}
