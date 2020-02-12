//
//  EventDetailViewController.swift
//  sachithsilva-cobsccomp182p-018
//
//  Created by user164669 on 2/13/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {

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

        // Do any additional setup after loading the view.
    }
    
    @IBAction func moreOptButtonPressed(_ sender: Any) {
    }
    
    @IBAction func goingButtonPressed(_ sender: Any) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
