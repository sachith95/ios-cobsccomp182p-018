//
//  MapViewController.swift
//  sachithsilva-cobsccomp182p-018
//
//  Created by Sachith Silva on 2/21/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UINavigationControllerDelegate  {
    var eventLong:String?
    var eventLat:String?
    var eventTitle:String?
    @IBOutlet weak var mapView: MKMapView!
    
  
    private var locationManager: CLLocationManager!
    private var currentLocation: CLLocation!
    
    override func viewDidLoad() {
//        requestLocationAccess()
        addAnnotations()
        super.viewDidLoad()
        
        mapView.showsUserLocation = true
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // Set delegates
        mapView.delegate = self
        locationManager.delegate = self
        
        // Check for Location Services
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            self.currentLocation = locationManager.location
        }
        navigationController?.delegate = self
   
    }
    
    func addAnnotations(){
        let event = MKPointAnnotation()
        event.title = self.eventTitle
        event.coordinate = CLLocationCoordinate2D(latitude: Double(self.eventLat ?? "0.00") as! CLLocationDegrees , longitude: Double(self.eventLong ?? "0.00") as! CLLocationDegrees)
        mapView.addAnnotation(event)
        let viewRegion = MKCoordinateRegion( center: event.coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
        mapView.setRegion(viewRegion, animated: false)
    }
    
    func requestLocationAccess() {
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            return
            
        case .denied, .restricted:
            print("location access denied")
            
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        defer { currentLocation = locations.last }
        
        if currentLocation == nil {
            if let userLocation = locations.last {
        let viewRegion = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
                mapView.setRegion(viewRegion, animated: false)
            }
        }
    }

}

extension MapViewController
{    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        (viewController as? AddEventViewController)?.longtitude = "\(currentLocation.coordinate.self.longitude)"
     (viewController as? AddEventViewController)?.latitude  = "\(currentLocation.coordinate.self.latitude)"
    }
}
