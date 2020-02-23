//
//  MapViewController.swift
//  sachithsilva-cobsccomp182p-018
//
//  Created by Janith Ganewatta on 2/21/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import UIKit
import MapKit


class MapViewController: UIViewController {
  let locationManager = CLLocationManager()
    @IBOutlet weak var mapView: MKMapView!
    let initialLocation = CLLocation(latitude: 6.9271, longitude: 79.8612)
   let regionRadius: CLLocationDistance = 100000
    override func viewDidLoad() {
        super.viewDidLoad()
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                locationManager.requestWhenInUseAuthorization()
                mapView.showsUserLocation = true
            case .authorizedAlways, .authorizedWhenInUse:
               mapView.showsUserLocation = true
            }
        } else {
            let alertController = UIAlertController(title: "Location Permission Required", message: "Please enable location permissions in settings.", preferredStyle: UIAlertController.Style.alert)
            
            let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
                //Redirect to Settings app
                UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
            })
            
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
            alertController.addAction(cancelAction)
            
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        centerMapOnLocation(location: initialLocation)
    }
  
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
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
