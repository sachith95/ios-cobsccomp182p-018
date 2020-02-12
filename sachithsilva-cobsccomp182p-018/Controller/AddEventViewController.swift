//
//  AddEventViewController.swift
//  sachithsilva-cobsccomp182p-018
//
//  Created by user164669 on 2/13/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import UIKit

class AddEventViewController: UIViewController {

    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventNameTextField: UITextField!
    @IBOutlet weak var endDateTextField: UITextField!
    @IBOutlet weak var endTimeTextField: UITextField!
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var startTimeTextField: UITextField!
    @IBOutlet weak var venuTextField: UITextField!
    @IBOutlet weak var detailTextField: UITextField!
    @IBOutlet weak var hostTextField: UITextField!
    @IBOutlet weak var longTextField: UITextField!
    @IBOutlet weak var lateTextField: UITextField!
    @IBOutlet weak var eventTypeTextField: UITextField!
    @IBOutlet weak var entranceTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func getPhotoButtonPress(_ sender: Any) {
    }
    @IBAction func uploadButtonPress(_ sender: Any) {
    }
    @IBAction func openMapButtonPress(_ sender: Any) {
    }
    @IBAction func saveButtonPress(_ sender: Any) {
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
