//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit
import GoogleMaps


struct ServiceCenterDetail1 {
    var name:String = ""
    var address:String = ""
    var numberOfServices: String = ""
    var serviceDetails: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Bibendum est ultricies integer quis. Iaculis urna id volutpat lacus laoreet. Mauris vitae ultricies leo integer malesuada. Ac odio tempor orci dapibus ultrices in. Egestas diam in arcu cursus euismod. Dictum fusce ut placerat orci nulla. Tincidunt ornare massa eget egestas purus viverra accumsan in nisl. Tempor id eu nisl nunc mi ipsum faucibus. Fusce id velit ut tortor pretium. Massa ultricies mi quis hendrerit dolor magna eget. Nullam eget felis eget nunc lobortis."
    var latitude: String = ""
    var longitude: String = ""
    var isSelected: Bool = false
    func getCoordinatte() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.latitude.toDouble, longitude: self.longitude.toDouble)
    }
}

class ServiceNavigationVC: BaseVC {
    
    
    @IBOutlet weak var btnCheckIn: ThemeButton!
  
    @IBOutlet weak var btnBack: FloatingRoundButton!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var btnKm: ThemeButton!
    @IBOutlet weak var btnMyLocation: UIButton!
    var currentMarker: GMSMarker? = nil
    var path: GMSPolyline =   GMSPolyline.init()
    var currentIndex: Int = 0
    // MARK: Object lifecycle
    let serviceDetail: ServiceCenterDetail1 = ServiceCenterDetail1(name: "terra heal massage center", address: "Lorem ipsum dolor sit,lisbon, portugal -25412", numberOfServices: "25",latitude: "22.35",longitude: "70.90")
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialViewSetup()
        self.currentMarker = GMSMarker.init()
        self.setupMapView(mapView: self.mapView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if self.isViewAvailable() {
            self.mapView.roundCorners(corners:[.topLeft,.topRight], radius: 40.0)
        }
    }
    
    private func initialViewSetup() {
        self.btnCheckIn.setFont(name: FontName.SemiBold, size: FontSize.button_14)
        self.btnCheckIn.setTitle("BOOKING_DETAIL_BTN_CHECK_IN".localized(), for: .normal)
    }
    
    @IBAction func btnCheckInTapped(_ sender: Any) {
        btnCheckIn.isEnabled = false
        self.openScanQrDialog()
        //Common.appDelegate.loadServiceStatusVC(navigaionVC: self.navigationController)
    }
    
    // MARK: Action Buttons
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        super.btnLeftTapped(btn)
        _ = _ = (self.navigationController as? NC)?.popVC()
    }
    
    @IBAction func btnCurrentLocationTapped(_ sender: Any) {
        let arrForCoordinate: [CLLocationCoordinate2D] = [self.currentMarker!.position]
        self.mapView.focusMap(locations: arrForCoordinate)
    }
    
    func openScanQrDialog() {
        let scanDialog: ScanDialog = ScanDialog.fromNib()
        scanDialog.initialize(title: "DIALOG_SCAN_TITLE".localized(), buttonTitle: "DIALOG_BTN_SCAN".localized(), cancelButtonTitle: "".localized())
        scanDialog.show(animated: true)

        scanDialog.onBtnDoneTapped = { [weak scanDialog, weak self]  in
            guard let self = self else {
                return
            }
            scanDialog?.dismiss()
            self.btnCheckIn.isEnabled = true
            self.openCameraVC()
        }
        scanDialog.onBtnCancelTapped = { [weak scanDialog, weak self]  in
            guard let self = self else {
                return
            }
            scanDialog?.dismiss()
            self.btnCheckIn.isEnabled = true
        }
    }


    func openCameraVC() {
        let cameraVC: CameraVC =  Common.appDelegate.loadCameraVC(navigaionVC: self.navigationController)
        cameraVC.onBtnCaptureTapped = { [weak self] (document)  in
                   guard let self = self else {
                       return
                   }
                _ = (self.navigationController as? NC)?.popVC()
        }
    }

}

