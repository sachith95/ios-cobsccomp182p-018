//
//  EventDetailViewController.swift
//  sachithsilva-cobsccomp182p-018
//
//  Created by user164669 on 2/13/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {
    
    var event:Event?
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var organizerLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titlelabel: UILabel!
    @IBOutlet weak var noOfGoingLabel: UILabel!
    @IBOutlet weak var venuLabel: UILabel!
    @IBOutlet weak var eventTypeLabel: UILabel!
    @IBOutlet weak var entranceLabel: UILabel!
    @IBOutlet weak var aboutTextField: UITextView!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longertitudeLabel: UILabel!
    @IBOutlet weak var goingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FirebaseManager.checkGoingEvent(eventId: event!.eventId){
            (bool) in
            if(bool){
                self.goingButton.isEnabled = false
                self.goingButton.alpha = 0.5
            }
        }
        if(event != nil){
        self.fillEventDetails()
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(EventDetailViewController.tapFunction))
        organizerLabel.isUserInteractionEnabled = true
        organizerLabel.addGestureRecognizer(tap)
    }
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        print("tap working")
        self.performSegue(withIdentifier:"viewPublicProfile", sender: self)
    }
    @IBAction func moreOptButtonPressed(_ sender: Any) {
        let moreOptionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        let notGoing = UIAlertAction(title: "Not Going", style: .default, handler: {
            _ in self.notGoingAction()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        moreOptionMenu.addAction(notGoing)
        moreOptionMenu.addAction(cancelAction)
        
        self.present(moreOptionMenu, animated: true, completion: nil)
    }
    
    @IBAction func goingButtonPressed(_ sender: Any) {
        FirebaseManager.updateGoingCount(eventId: event!.eventId)
    }
    func notGoingAction() {
         FirebaseManager.updateNotGoingCount(eventId: event!.eventId)
    }
    func fillEventDetails(){
        organizerLabel.text = "Hosted By \(event?.organizer ?? "Unknown")"
        dateLabel.text = "\(event?.startDate ?? "") - \(event?.endDate ?? "")"
        titlelabel.text = event?.title
        noOfGoingLabel.text = "\(event?.goingCount ?? "0") people are going"
        venuLabel.text = "Join us on \(event?.venu ?? "Unknown")"
        eventTypeLabel.text = "\(event?.eventType ?? "Public") Invitation"
        entranceLabel.text = "Entrance \(event?.entrance ?? "Free")"
        aboutTextField.text = "Details: \(event?.about ?? "Details not available")"
        latitudeLabel.text = event?.latitude
        longertitudeLabel.text = event?.longitude
        if(event?.eventImageUrl != ""){
            eventImageView.image = event?.getEventImage()
        } else {
            eventImageView.image = UIImage(named: "default")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewPublicProfile",
            let destinationViewController = segue.destination as? PublicUserProfileViewController {
            destinationViewController.userID = event!.userId
        }
        if segue.identifier == "showOnMap",
            let destinationViewController = segue.destination as? MapViewController {
            destinationViewController.eventLat = latitudeLabel.text
            destinationViewController.eventLong = longertitudeLabel.text
            destinationViewController.eventTitle = event?.title
        }
    }

}
