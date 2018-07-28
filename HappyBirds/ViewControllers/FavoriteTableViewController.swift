//
//  FavoriteTableViewController.swift
//  HappyBirds
//
//  Created by Thao Doan on 7/26/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import UIKit

class FavoriteTableViewController: UITableViewController {
    
    var photoArray = ["us1", "us2", "us3", "us4"]

    override func viewDidLoad() {
        super.viewDidLoad()
        let textAttributes = [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0, green: 0.8651906848, blue: 0.6215168834, alpha: 1)]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return photoArray.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favorite", for: indexPath) as! FavoriteTableViewCell
        let image = UIImage(named:photoArray[indexPath.row])
        cell.imageView?.image = image
        cell.imageView?.contentMode = .scaleAspectFit
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
           
        }    
    }
  

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}
