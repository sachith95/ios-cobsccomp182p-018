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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(event != nil){
        self.fillEventDetails()
        }
    }
    
    @IBAction func moreOptButtonPressed(_ sender: Any) {
    }
    
    @IBAction func goingButtonPressed(_ sender: Any) {
    }
 
    func fillEventDetails(){
        organizerLabel.text = event?.organizer
        dateLabel.text = event?.startDate
        titlelabel.text = event?.title
        noOfGoingLabel.text = event?.goingCount
        venuLabel.text = event?.venu
        eventTypeLabel.text = event?.eventType
        entranceLabel.text = event?.entrance
        aboutTextField.text = event?.about
        latitudeLabel.text = event?.latitude
        longertitudeLabel.text = event?.longitude
        if(event.eventImageUrl != ""){
            eventImageView.image = event.getEventImage()
        } else {
            eventImageView.image = UIImage(named: "default")
        }
    }

}
