//
//  ViewController.swift
//  Virtual Tourist
//
//  Created by Ankita Satpathy on 17/09/17.
//  Copyright © 2017 Ankita Satpathy. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, UIGestureRecognizerDelegate{
    
    @IBOutlet weak var mapview:MKMapView!
    var centerCoordinate: CLLocationCoordinate2D?
    var centerCoordinateLongitude: CLLocationDegrees?
    var centerCoordinateLatitude: CLLocationDegrees?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       mapview.delegate = self
        addGestureRecognizer()
        
        
    }
    func addGestureRecognizer() {
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(self.addPinToMap(gestureRecognizer:)))
        gesture.minimumPressDuration = 0.5
        gesture.delegate = self
        self.mapview.addGestureRecognizer(gesture)
        
    }
    
    @objc func addPinToMap(gestureRecognizer: UILongPressGestureRecognizer){
        if gestureRecognizer.state == UIGestureRecognizerState.began {
            let point = gestureRecognizer.location(in: mapview)
            
            let coordinate = mapview.convert(point, toCoordinateFrom: mapview)
            let longitude = coordinate.longitude
            let latitude = coordinate.latitude
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            mapview.addAnnotation(annotation)
            
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKAnnotationView
        
        if pinView == nil
        {
            
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
        }
        else
        {
            pinView!.annotation = annotation
        }
        
        pinView?.tintColor = UIColor.red
        pinView?.isDraggable = true
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let annotation =  view.annotation
        mapView.selectAnnotation(annotation!, animated: true)
        
        performSegue(withIdentifier: "photoAlbum", sender: annotation!)
        mapView.deselectAnnotation(annotation, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "photoAlbum" {
            let photoVC = segue.destination as! PhotoAlbumViewController
        }
    }
    
}

