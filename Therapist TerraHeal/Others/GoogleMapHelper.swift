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
extension GMSMapView {
        
    func setMarker(marker:GMSMarker) {
        if marker.map == nil {
            marker.map = self
        }
    }
    func drawPolyline(polyline:GMSPolyline, source:CLLocationCoordinate2D,destination:CLLocationCoordinate2D) {
        let path = GMSMutablePath(path: GMSPath())
        path.add(source)
        path.add(destination)
        polyline.map = nil
        polyline.path = path
        polyline.strokeColor = UIColor.themePrimary
        polyline.strokeWidth = 3.0
        polyline.geodesic = true
        
        
        /* let styles = [GMSStrokeStyle.solidColor(.clear),
                            GMSStrokeStyle.solidColor(.themePrimary)]
        let scale = 1.0 / Double(self.projection.points(forMeters: 1, at: self.camera.target))
        let lengths: [NSNumber] = [NSNumber(value: 10.0 * scale), NSNumber(value: 10.0 * scale)]
        
        polyline.spans = GMSStyleSpans(polyline.path!, styles, lengths, .rhumb)*/
        polyline.map = self
        // add coordinate to your path
       
    }
    func updateLine(polyline: GMSPolyline) {
       /* if polyline.path != nil {
                let styles = [GMSStrokeStyle.solidColor(.clear),
                                     GMSStrokeStyle.solidColor(.themePrimary)]
                let scale = 1.0 / Double(self.projection.points(forMeters: 1, at: self.camera.target))
                let lengths: [NSNumber] = [NSNumber(value: 10.0 * scale), NSNumber(value: 10.0 * scale)]
                polyline.spans = GMSStyleSpans(polyline.path!, styles, lengths, .rhumb)
        }*/
        
        
    }
    
    func focusMap(locations:[CLLocationCoordinate2D]) {
            var bounds = GMSCoordinateBounds()
            for location in locations
            {
                bounds = bounds.includingCoordinate(location)
            }
            let update = GMSCameraUpdate.fit(bounds, withPadding: 20)
            self.animate(with: update)
    }
    
    
    func setMassageCenterMarker(marker:GMSMarker,image:UIImage, location:CLLocationCoordinate2D) {
        if marker.map == nil {
            marker.map = self
        }
        marker.position = location
        if marker.icon == nil {
            marker.icon = self.drawImageWithMassageCenterPic(pp: image, image: UIImage.init(named: "asset-center-maker"))
        }
        marker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
    }
    func setCurrentMarker(marker:GMSMarker,location:CLLocationCoordinate2D) {
        if marker.map == nil {
            marker.map = self
        }
        marker.position = location
        if marker.icon == nil {
            marker.icon = self.drawImageWithProfilePic(pp: UIImage.init(named: "asset-user")!, image: nil)
        }
        marker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
    }
  
    func drawImageWithProfilePic(pp: UIImage, image: UIImage?) -> UIImage {
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        if image == nil {
                imgView.backgroundColor = UIColor.themePrimary.withAlphaComponent(0.3)
                imgView.layer.cornerRadius = imgView.frame.width/2
                imgView.clipsToBounds = true
        }else {
            imgView.image = image
        }
        let picImgView = UIImageView(image: pp)
        picImgView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        imgView.addSubview(picImgView)
        picImgView.backgroundColor = UIColor.white
        picImgView.center.x = imgView.center.x
        picImgView.center.y = imgView.center.y
        picImgView.layer.cornerRadius = picImgView.frame.width/2
        picImgView.clipsToBounds = true
        
        imgView.setNeedsLayout()
        picImgView.setNeedsLayout()

        let newImage = imageWithView(view: imgView)
        return newImage
    }

    func drawImageWithMassageCenterPic(pp: UIImage, image: UIImage?) -> UIImage {
           let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
           if image == nil {
                   imgView.backgroundColor = UIColor.themePrimary.withAlphaComponent(0.3)
                   imgView.layer.cornerRadius = imgView.frame.width/2
                   imgView.clipsToBounds = true
           }else {
               imgView.image = image
           }
           let picImgView = UIImageView(image: pp)
           picImgView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
           imgView.addSubview(picImgView)
           picImgView.backgroundColor = UIColor.white
           picImgView.center.x = imgView.center.x
           picImgView.center.y = imgView.center.y - 10
           picImgView.layer.cornerRadius = picImgView.frame.width/2
           picImgView.clipsToBounds = true
           
           imgView.setNeedsLayout()
           picImgView.setNeedsLayout()

           let newImage = imageWithView(view: imgView)
           return newImage
       }
    
    func imageWithView(view: UIView) -> UIImage {
        var image: UIImage?
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0.0)
        if let context = UIGraphicsGetCurrentContext() {
            view.layer.render(in: context)
            image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
        return image ?? UIImage()
    }
    
    func applyStyle() {
        do {
            // Set the map style by passing the URL of the local file. Make sure style.json is present in your project
            if let styleURL = Bundle.main.url(forResource: "styleable_map", withExtension: "json") {
                self.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                print("Unable to find style.json")
            }
        } catch {
            print("The style definition could not be loaded: \(error)")
        }
    }
}

