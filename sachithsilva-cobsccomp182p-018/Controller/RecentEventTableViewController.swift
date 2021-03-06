//
//  RecentEventTableViewController.swift
//  sachithsilva-cobsccomp182p-018
//
//  Created by Sachith Silva on 2/9/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import UIKit
import SVProgressHUD
import IPImage

class RecentEventTableViewController: UITableViewController {

    
    @IBOutlet var LoginBarButton: UIBarButtonItem!
    private let searchController = UISearchController(searchResultsController: nil)
    private var previousRun = Date()
    private let minInterval = 0.05
    private var eventsResults = [Event]() {
        didSet {
            tableView.reloadData()
        }
    }
     var selectedEvent:Event?
    var isGuest:Bool?
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show()
        FirebaseManager.getAllEvents(){
            (event) in
            self.eventsResults = event
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        SVProgressHUD.dismiss()
        tableView.tableFooterView = UIView()
        setupTableViewBackgroundView()
        setupSearchBar()
        if(isGuest == false){
       self.navigationItem.rightBarButtonItem = nil
        }
    }

  
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath ) -> CGFloat {
        // #warning Incomplete implementation, return the number of rows
        return 265
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.eventsResults.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                 for: indexPath) as! AllEventTableViewCell
        let u = FirebaseManager.events[indexPath.row]
        cell.titleLabel.text = u.title
        cell.dateLabel.text = u.startDate
        cell.organizerLabel.text = u.organizer
        if(u.eventImageUrl != ""){
            cell.eventImage.image = u.getEventImage()
        } else {
            cell.eventImage.image = UIImage(named: "default")
        }
        FirebaseManager.getUserDetail(userID: u.userId){ (user) in
            if user.profileImageUrl == ""{
                let ipimage = IPImage(text: user.username, radius: 30, font: UIFont(name: "Cochin-Italic", size: 30), textColor: nil, randomBackgroundColor: true)
                cell.avatarImage.image = ipimage.generateImage()
            }
            else {
                   cell.avatarImage.image = user.getProfileImage()
            }
        }
        
        let perLevel:CGFloat = CGFloat(1.0) / CGFloat(FirebaseManager.events.count)
        cell.backgroundColor = UIColor.init(red: 35 / 255.0, green: 204/255.0, blue: 216.0/255.0, alpha: (perLevel + CGFloat(indexPath.row) * perLevel))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedEvent = FirebaseManager.events[indexPath.row]
        self.performSegue(withIdentifier: "recentEventDetailView", sender: self)
    }

    private func setupSearchBar() {
        searchController.searchBar.delegate = self as? UISearchBarDelegate
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search by event"
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }
    private func setupTableViewBackgroundView() {
        let backgroundViewLabel = UILabel(frame: .zero)
        backgroundViewLabel.textColor = .darkGray
        backgroundViewLabel.numberOfLines = 0
        tableView.backgroundView = backgroundViewLabel
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "recentEventDetailView",
            let destinationViewController = segue.destination as? EventDetailViewController {
            destinationViewController.event = selectedEvent
        }
    }

}

extension RecentEventTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.eventsResults.removeAll()
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
        FirebaseManager.search(searchText: text, completion: {
            [weak self] results in

            self?.eventsResults = results
        })
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        eventsResults.removeAll()
        FirebaseManager.getAllEvents(){
            (event) in
            self.eventsResults = event
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
