//
//  RecentEventTableViewController.swift
//  sachithsilva-cobsccomp182p-018
//
//  Created by Sachith Silva on 2/9/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import UIKit
import SwiftyJSON

class RecentEventTableViewController: UITableViewController {

    private let searchController = UISearchController(searchResultsController: nil)
    private let apiFetcher = FirebaseManager()
    private var previousRun = Date()
    private let minInterval = 0.05
    private var eventsResults = [JSON]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        setupTableViewBackgroundView()
        setupSearchBar()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsResults.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath ) -> CGFloat {
        return 340
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                 for: indexPath) as! CustomTableViewCell
        
//        cell.titleLabel.text = searchResults[indexPath.row]["title"].stringValue
//        
//        cell.descriptionLabel.text = searchResults[indexPath.row]["terms"]["description"][0].string
//        
//        if let url = searchResults[indexPath.row]["thumbnail"]["source"].string {
//            apiFetcher.fetchImage(url: url, completionHandler: { image, _ in
//                cell.wikiImageView?.image = image
//            })
//        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let title = eventsResults[indexPath.row]["title"].stringValue
        // naviagte or open up detail view
        tableView.deselectRow(at: indexPath, animated: true)
    }

    private func setupSearchBar() {
        searchController.searchBar.delegate = self as? UISearchBarDelegate
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search any Topic"
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }
    private func setupTableViewBackgroundView() {
        let backgroundViewLabel = UILabel(frame: .zero)
        backgroundViewLabel.textColor = .darkGray
        backgroundViewLabel.numberOfLines = 0
        backgroundViewLabel.text =
        "Oops, \n No results to show! ..."
        tableView.backgroundView = backgroundViewLabel
    }

}

extension RecentEventTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        eventsResults.removeAll()
        guard let textToSearch = searchBar.text, !textToSearch.isEmpty else {
            return
        }
        
        if Date().timeIntervalSince(previousRun) > minInterval {
            previousRun = Date()
            fetchResults(for: textToSearch)
        }
    }
    
    func fetchResults(for text: String) {
        print("Text Searched: \(text)")
//        apiFetcher.search(searchText: text, completionHandler: {
//            [weak self] results, error in
//            if case .failure = error {
//                return
//            }
//            
//            guard let results = results, !results.isEmpty else {
//                return
//            }
//            
//            self?.eventsResults = results
//        })
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        eventsResults.removeAll()
    }
}
