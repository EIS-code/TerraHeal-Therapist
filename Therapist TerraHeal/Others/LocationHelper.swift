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


struct AutoCompleteAddress {
    var title: NSAttributedString!
    var subTitle: NSAttributedString!
    var placeID: String = ""
}

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

extension LocationCenter {
    
    
    
    func getAddressFromCoordinate(coordinate:CLLocationCoordinate2D, completion : @escaping ((Address) -> Void))
    {
        if geocoder.isGeocoding {
            geocoder.cancelGeocode()
        }
        geocoder.reverseGeocodeLocation(CLLocation.init(latitude: coordinate.latitude, longitude:coordinate.longitude)) { (places, error) in
            
            let address:Address = Address.init(fromDictionary: [:])
            if error == nil{
                if let place = places?.first {
                    address.addressLine1 = place.thoroughfare ?? place.name ?? ""
                    address.addressLine2 = place.subThoroughfare ?? ""
                    address.city = place.locality ?? ""
                    address.landMark = place.subLocality ?? ""
                    address.latitude = place.location?.coordinate.latitude.toString(places: 8) ?? ""
                    address.longitude = place.location?.coordinate.longitude.toString(places: 8) ?? ""
                    address.pinCode = place.postalCode ?? ""
                    address.province = place.administrativeArea ?? ""
                    completion(address)
                } else {
                    completion(address)
                }
            }  else {
                completion(address)
            }
        }
    }
    
    
    func getGMSAddress(coordinate:CLLocationCoordinate2D, completion: @escaping ((Address) -> Void)) {
        GMSGeocoder.init().reverseGeocodeCoordinate(coordinate) { (result, error) in
            let address:Address = Address.init(fromDictionary: [:])
            if error != nil {
                print(error?.localizedDescription ?? "")
                completion(address)
            } else  {
                if let place = result?.firstResult() {
                    address.addressLine1 = place.lines?.joined() ?? ""
                    address.addressLine2 = ""
                    address.city = place.locality ?? ""
                    address.landMark = place.subLocality ?? ""
                    address.latitude = place.coordinate.latitude.toString(places: 8)
                    address.longitude = place.coordinate.longitude.toString(places: 8)
                    address.pinCode = place.postalCode ?? ""
                    address.province = place.administrativeArea ?? ""
                }
                completion(address)
            }
        }
    }
    func getAutocomplete(text:String, completion: @escaping  (([AutoCompleteAddress]) -> Void)) {
        let token = GMSAutocompleteSessionToken.init()
        
        // Create a type filter.
        let filter = GMSAutocompleteFilter()
        filter.type = .establishment
        let placeClient = GMSPlacesClient.shared()
        placeClient.findAutocompletePredictions(fromQuery: text, filter: filter, sessionToken: token) {  (results, error) in
            var arrForAutoComplete: [AutoCompleteAddress] = []
            if let error = error {
                print("Autocomplete error: \(error)")
                completion(arrForAutoComplete)
                return
            }
            if let results = results {
                for result in results {
                    arrForAutoComplete.append(AutoCompleteAddress.init(title: result.attributedPrimaryText, subTitle:result.attributedFullText, placeID: result.placeID))
                    completion(arrForAutoComplete)
                    print("Result \(result.attributedFullText) with placeID \(result.placeID)")
                }
            } else {
                completion(arrForAutoComplete)
            }
        }
        
    }
    
    
    func getAddress(placeId:String, completion: @escaping  ((Address) -> Void)) {
        let token = GMSAutocompleteSessionToken.init()
        let placeClient = GMSPlacesClient.shared()
        placeClient.fetchPlace(fromPlaceID: placeId, placeFields: GMSPlaceField.all, sessionToken: token) { (place, error) in
            let address:Address = Address.init(fromDictionary: [:])
            if let error = error {
                print("lookup place id query error: \(error.localizedDescription)")
                completion(address)
                return
            }
            
            guard let place = place else {
                print("No place details for \(placeId)")
                completion(address)
                return
            }
            
            address.addressLine1 = place.formattedAddress ?? ""
            address.latitude = place.coordinate.latitude.toString(places: 8)
            address.longitude = place.coordinate.longitude.toString(places: 8)
            
            if let addressComponents = place.addressComponents {
                for component: GMSAddressComponent in addressComponents {
                    for type: String in component.types {
                        switch type {
                        case "postal_code":
                            address.pinCode = component.name
                        case "administrative_area_level_2":
                            address.city = component.name
                        case "administrative_area_level_1":
                            address.province = component.name
                        case "locality":
                            address.landMark = component.name
                        default:
                            print(component.name)
                        }
                    }
                }
            }
            completion(address)
        }
    }
    
}

