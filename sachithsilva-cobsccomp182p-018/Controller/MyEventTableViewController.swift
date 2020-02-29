//
//  MyEventTableViewController.swift
//  sachithsilva-cobsccomp182p-018
//
//  Created by Sachith Silva on 2/16/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import UIKit
import SVProgressHUD
import IPImage

class MyEventTableViewController: UITableViewController {

    var selectedEvent:Event?


    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show()
        FirebaseManager.getUserEvents() {
            (event) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
         SVProgressHUD.dismiss()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    @IBAction func addEvent(_ sender: Any) {
         performSegue(withIdentifier: "addEvent", sender: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return FirebaseManager.myEvents.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath ) -> CGFloat {
        // #warning Incomplete implementation, return the number of rows
        return 265
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
        let u = FirebaseManager.myEvents[indexPath.row]
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
        let perLevel:CGFloat = CGFloat(1.0) / CGFloat(FirebaseManager.myEvents.count)
        cell.backgroundColor = UIColor.init(red: 35 / 255.0, green: 204/255.0, blue: 216.0/255.0, alpha: (perLevel + CGFloat(indexPath.row) * perLevel))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedEvent = FirebaseManager.myEvents[indexPath.row]
        self.performSegue(withIdentifier: "eventDetailView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "eventDetailView",
            let destinationViewController = segue.destination as? EventDetailViewController {
            destinationViewController.event = selectedEvent
        }
    }
    
}
