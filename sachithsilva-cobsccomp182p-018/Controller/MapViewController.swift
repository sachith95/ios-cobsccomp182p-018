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
   
    @IBOutlet weak var mapView: MKMapView!
    let initialLocation = CLLocation(latitude: 6.9271, longitude: 79.8612)
   let regionRadius: CLLocationDistance = 100000
    override func viewDidLoad() {
        super.viewDidLoad()
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
extension MKMapView {
    
    func moveCenterByOffSet(offSet: CGPoint, coordinate: CLLocationCoordinate2D) {
        var point = self.convert(coordinate, toPointTo: self)
        
        point.x += offSet.x
        point.y += offSet.y
        
        let center = self.convert(point, toCoordinateFrom: self)
        self.setCenter(center, animated: true)
    }
    
    func centerCoordinateByOffSet(offSet: CGPoint) -> CLLocationCoordinate2D {
        var point = self.center
        
        point.x += offSet.x
        point.y += offSet.y
        
        return self.convert(point, toCoordinateFrom: self)
    }
}
