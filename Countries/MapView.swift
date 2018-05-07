//
//  MapView.swift
//  Countries
//
//  Created by SHAISHAV ILESH VALERA on 5/19/17.
//  Copyright © 2017 SHAISHAV ILESH VALERA. All rights reserved.
//

import UIKit
import MapKit

class MapView: UIViewController, MKMapViewDelegate
{
    
    @IBAction func back(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    var latitude: Double?
    var longitude: Double?
    var country: String?
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var countryname: UILabel!
    override func viewDidLoad()
    {
        let countryonmap = MKPointAnnotation()
        countryonmap.coordinate = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
        countryonmap.title = country
        countryname.text = country
        map.addAnnotation(countryonmap)
        super.viewDidLoad()
        let myregion = MKCoordinateRegionMakeWithDistance(countryonmap.coordinate, 2900000, 2900000)
        map.setRegion(myregion, animated: true)
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {
        let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        pin.canShowCallout = true
        return pin
    }
}
