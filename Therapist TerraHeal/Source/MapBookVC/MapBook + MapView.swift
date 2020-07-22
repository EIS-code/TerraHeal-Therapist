//
//  ServiceMap + MapView.swift
//  Terra Heal
//
//  Created by Jaydeep Vyas on 08/07/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps

extension MapBookVC :GMSMapViewDelegate {
    
    func setupMapView(mapView: GMSMapView) {
        mapView.delegate = self;
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.settings.allowScrollGesturesDuringRotateOrZoom = false;
        mapView.padding = UIEdgeInsets.init(top: 20, left: 20, bottom: 60, right: 20)
        mapView.animate(toLocation: CLLocationCoordinate2D.init(latitude: 22.30, longitude: 70.80))
        mapView.animate(toZoom: 15)
        self.mapView.setCurrentMarker(marker: self.currentMarker!, location: CLLocationCoordinate2D.init(latitude: 22.30, longitude: 70.80))
        self.setMassageCenterMarker()
        self.mapView.applyStyle()
        self.mapView.focusMap(locations: [self.currentMarker!.position,serviceDetail.getCoordinatte()])
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition){
        
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        mapView.updateLine(polyline: path)
    }
    
    func setMassageCenterMarker() {
       self.mapView.setMassageCenterMarker(marker: GMSMarker.init(), image: UIImage.init(named: "asset-center")!, location: serviceDetail.getCoordinatte())
    }
}
