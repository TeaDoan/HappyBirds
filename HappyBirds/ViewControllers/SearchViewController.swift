//
//  SearchViewController.swift
//  HappyBirds
//
//  Created by Thao Doan on 7/27/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK - Properties
    var jokeResults : [SearchJokes] = []
    let cellIdentifer = "resultCell"
   
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).textColor = UIColor.white
        let textAttributes = [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) ]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK - TableView Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jokeResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifer, for: indexPath) as? SearchTableViewCell else {return UITableViewCell()}
        let result = jokeResults[indexPath.row]
        cell.bodyLabel.text = result.joke ?? "No results found"
        cell.detailsLabel.text = "Unknown"
        DispatchQueue.main.async {
        cell.formatContainerViewIfNeeded()
        }
        tableView.separatorStyle = .none
        return cell
    }
    
    // MARK - TableView Delegate
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 250
//    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
}

extension SearchViewController : UISearchBarDelegate{
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
             UIApplication.shared.isNetworkActivityIndicatorVisible = true
            guard let searchText = searchBar.text?.lowercased() , !searchText.isEmpty else {return}
            JokeAPIService.searchJokes(searchTerm: searchText) { (jokes) in
                guard let jokes = jokes else {return}
                DispatchQueue.main.async {
                self.jokeResults = jokes
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                self.tableView.reloadData()
                }
            }
        }
   
    
    }

