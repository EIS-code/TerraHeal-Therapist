//
//  Common.swift
//  EserviceProvider
//  Created by Mac Pro5 on 01/05/19.
//  Copyright © 2019 Jaydeepvyas. All rights reserved.
//

import UIKit
import QuartzCore
import CoreLocation
import GooglePlaces
import GoogleMaps

typealias LC = LocationCenter

class LocationCenter: NSObject, CLLocationManagerDelegate {
    
    let manager: CLLocationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    var myLatitude:String = ""
    var myLongitude:String = ""
    var myAddress:String = ""
    var my:String = ""
    
    class var isServicesEnabled: Bool {
        get {
            return CLLocationManager.locationServicesEnabled()
        }
    }
    
    class var authorizationStatus: CLAuthorizationStatus {
        get {
            return CLLocationManager.authorizationStatus()
        }
    }
    
    var lastLocation: CLLocation? {
        get {
            return self.manager.location
        }
    }
    
    static let `default`: LocationCenter = {
        let instance: LocationCenter = LocationCenter()
        return instance
    }()
    
    override init() {
        super.init()
        
        self.manager.delegate = self
        self.manager.activityType = CLActivityType.other
        self.manager.distanceFilter = kCLDistanceFilterNone
        self.manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        self.manager.pausesLocationUpdatesAutomatically = true
        self.requestAuthorization()
        //self.manager.allowsBackgroundLocationUpdates = true
        //self.manager.showsBackgroundLocationIndicator = false
    }
    
    deinit {
        //debugPrint("\(self) \(#function)")
    }
    
    func requestAuthorization() {
        self.manager.requestWhenInUseAuthorization()
    }
    
    func requestLocationOnce() {
        self.manager.requestLocation()
        self.start()
    }
    
    func start() {
        self.manager.startUpdatingLocation()
    }
    
    func stop() {
        self.manager.stopUpdatingLocation()
    }
    
    // MARK: - LocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case CLAuthorizationStatus.notDetermined:
            debugPrint("\(self) \(#function) notDetermined")
            self.stop()
            break
        case CLAuthorizationStatus.restricted:
            debugPrint("\(self) \(#function) restricted")
            self.stop()
            break
        case CLAuthorizationStatus.denied:
            debugPrint("\(self) \(#function) denied")
            self.stop()
            break
        case CLAuthorizationStatus.authorizedAlways:
            debugPrint("\(self) \(#function) authorizedAlways")
            self.start()
            break
        case CLAuthorizationStatus.authorizedWhenInUse:
            debugPrint("\(self) \(#function) authorizedWhenInUse")
            self.start()
            break
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        debugPrint("\(self) \(#function)")
        guard let mostRecentLocation = locations.last else { return }
        appSingleton.myLatitude = mostRecentLocation.coordinate.latitude.toString(places: 8)
        appSingleton.myLongitude = mostRecentLocation.coordinate.longitude.toString(places: 8)
        Common.nCd.post(name: Common.locationUpdateNtfNm,
                        object: self,
                        userInfo: ["ncd": ["location": mostRecentLocation]])
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        debugPrint("\(self) \(#function)")
        
        Common.nCd.post(name: Common.locationFailNtfNm,
                        object: self,
                        userInfo: ["ncd": ["locationError": error]])
        
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didFinishDeferredUpdatesWithError error: Error?) {
        debugPrint("\(self) \(#function)")
        
    }
    
    func locationManagerDidPauseLocationUpdates(_ manager: CLLocationManager) {
        debugPrint("\(self) \(#function)")
    }
    
    func locationManagerDidResumeLocationUpdates(_ manager: CLLocationManager) {
        debugPrint("\(self) \(#function)")
    }
}



