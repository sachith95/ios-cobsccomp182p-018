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
            }
        }
        if(event != nil){
        self.fillEventDetails()
        }
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
        organizerLabel.text = event?.organizer
        dateLabel.text = "\(event?.startDate ?? "") - \(event?.endDate ?? "")"
        titlelabel.text = event?.title
        noOfGoingLabel.text = event?.goingCount
        venuLabel.text = event?.venu
        eventTypeLabel.text = event?.eventType
        entranceLabel.text = event?.entrance
        aboutTextField.text = event?.about
        latitudeLabel.text = event?.latitude
        longertitudeLabel.text = event?.longitude
        if(event?.eventImageUrl != ""){
            eventImageView.image = event?.getEventImage()
        } else {
            eventImageView.image = UIImage(named: "default")
        }
    }

}
