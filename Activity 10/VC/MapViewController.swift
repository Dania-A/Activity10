//
//  MapViewController.swift
//  Activity 10 Solution
//
//  Created by Dania A on 04/11/2018.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var MapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MapView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        APICalls.getAllLocations () {(studentsLocations, error) in
            DispatchQueue.main.async {
                
                if error != nil {
                    let errorAlert = UIAlertController(title: "Erorr performing request", message: "There was an error performing your request", preferredStyle: .alert )
                    
                    errorAlert.addAction(UIAlertAction (title: "OK", style: .default, handler: { _ in
                        return
                    }))
                    self.present(errorAlert, animated: true, completion: nil)
                    return
                }
                
                var annotations = [MKPointAnnotation] ()
                
                guard let locationsArray = studentsLocations else {
                    let locationsErrorAlert = UIAlertController(title: "Erorr loading locations", message: "There was an error loading locations", preferredStyle: .alert )
                    
                    locationsErrorAlert.addAction(UIAlertAction (title: "OK", style: .default, handler: { _ in
                        return
                    }))
                    self.present(locationsErrorAlert, animated: true, completion: nil)
                    return
                }
                
                //Loop through the array of structs and get locations data from it so they can be displayed on the map
                for locationStruct in locationsArray {
                    
                    let long = CLLocationDegrees (locationStruct.longitude ?? 0)
                    let lat = CLLocationDegrees (locationStruct.latitude ?? 0)
                    
                    let coords = CLLocationCoordinate2D (latitude: lat, longitude: long)
                    
                    //TODO: Get the media URL and call it mediaURL, if it's nil its value should be " ", for that use Nil-Coalescing Operator (??)
                    let mediaURL = locationStruct.mediaURL ?? " "
                    
                    //TODO: Get the first name and call it first, if it's nil its value should be " ", for that use Nil-Coalescing Operator (??)
                    let first = locationStruct.firstName ?? " "
                    
                    //TODO: Get the last name and call it last, if it's nil its value should be " ", for that use Nil-Coalescing Operator (??)
                    let last = locationStruct.lastName ?? " "
                    
                    // Here we create the annotation and set its coordiate, title, and subtitle properties
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = coords
                    annotation.title = "\(first) \(last)"
                    annotation.subtitle = mediaURL
                    
                    annotations.append (annotation)
                }
                self.MapView.addAnnotations (annotations)
            }
            
        }//end getAllLocations
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    // This delegate method is implemented to respond to taps. It opens the system browser
    // to the URL specified in the annotationViews subtitle property.
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            if let toOpen = view.annotation?.subtitle! {
                app.open(URL(string: toOpen)!, options: [:], completionHandler: nil)
            }
        }
    }
}
