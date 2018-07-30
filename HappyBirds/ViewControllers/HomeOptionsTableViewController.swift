//
//  HomeOptionsTableViewController.swift
//  HappyBirds
//
//  Created by Thao Doan on 7/28/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import UIKit
import HomePageInfoKit
// This is for future updates
class HomeOptionsTableViewController: UITableViewController {
    
    // MARK: Properties
//    var defaults = UserDefaults(suiteName:"group.teaDoan.happyBirdsWidget")!
    let options = ["Random Daily Jokes","Random Daily Quotes"]
    
    var selectedCategory = "" {
        didSet {
//            var options = selectedOption.split { $0 == "," }.map {String($0)}
            selectedOption = options[0]
        }
    }
    
    private(set) var selectedOption = ""

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "optionsCell", for: indexPath)
         cell.textLabel?.text = options[indexPath.row]
         cell.accessoryType = (options[indexPath.row] == selectedOption) ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
        if let option = cell?.textLabel?.text {
            selectedOption = option
//            defaults.setValue(selectedOption, forKey: "homeTitle")
        }
        
        tableView.reloadData()
    }
 
}
