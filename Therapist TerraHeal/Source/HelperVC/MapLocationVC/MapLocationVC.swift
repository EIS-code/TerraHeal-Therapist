import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation


class MapLocationVC: MainVC {
    
    //MARK:
    //MARK: Outlets
    @IBOutlet weak var tblAutocomplete: UITableView!
    @IBOutlet weak var heightForAutoComplete: NSLayoutConstraint!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var imgForLocation: UIImageView!
    @IBOutlet weak var btnCurrentLocation: FloatingRoundButton!
    @IBOutlet weak var btnDone: ThemeButton!
    @IBOutlet weak var searchVw: UIView!
    @IBOutlet weak var txtSearchBar: ThemeTextField!
    @IBOutlet weak var lblAddressValue: ThemeLabel!
    var isFromAutoComplete:Bool = false
    var onLocationSelected: ((_ data: Address ) -> Void)? = nil
    var selectedAddress: Address = Address.init(fromDictionary: [:])
    var arrForAdress:[AutoCompleteAddress] = []
    var lc: LocationCenter? = nil
    //MARK:
    //MARK: View life cycle
    override func viewDidLoad(){
        super.viewDidLoad();
        self.lc = LocationCenter()
        self.setupMapView(mapView: self.mapView)
        setLocalization()
        self.addLocationObserver()
        self.setupSearchbar(searchBar: self.txtSearchBar)
        self.setupTableView(tableView: self.tblAutocomplete)
        self.gettingCurrentLocation()
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews();
        setupLayout()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillDisappear(_ animated: Bool){
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool){
        super.viewDidDisappear(animated)
    }
    
    func  setLocalization(){
        self.btnDone.setTitle("BTN_PROCEED".localized(), for: .normal)
        self.btnDone.setFont(name: FontName.SemiBold, size: FontSize.button_14)
        
        self.lblAddressValue.setFont(name: FontName.Regular, size: FontSize.label_14)
        
        
    }
    
    func  setupLayout(){
        if self.isViewAvailable() {
            btnDone.setHighlighted(isHighlighted: true)
            searchVw.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
            searchVw.setShadow()
        }
    }
    //MARK:
    //MARK: Button action methods
    @IBAction func onClickBtnDone(_ sender: UIButton){
      self.lc = nil
      if self.onLocationSelected != nil {
        self.onLocationSelected!(Address.init(fromDictionary: selectedAddress.toDictionary()));
      }
        
    }
    
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        super.btnLeftTapped(btn)
        if let nc = self.navigationController as? NC {
            _ = nc.popVC()
        } else  {
            self.dismiss(animated: true) {
            }
        }
    }
    
    @IBAction func onClickBtnCurrentLocation(_ sender: Any) {
        gettingCurrentLocation()
    }
    
    func gettingCurrentLocation() {
        lc?.requestLocationOnce()
    }
    
    func animateToLocation(coordinate:CLLocationCoordinate2D) {
        CATransaction.begin()
        CATransaction.setValue(1.0, forKey: kCATransactionAnimationDuration)
        CATransaction.setCompletionBlock {
        }
        let camera = GMSCameraPosition.camera(withTarget: coordinate, zoom: 17.0, bearing: 45, viewingAngle: 0.0)
        self.mapView.animate(to: camera)
        CATransaction.commit()
    }
    
    //MARK: Location Observer
    
    override func locationUpdate(_ ntf: Notification = Common.defaultNtf) {
        if let locationDict: [String: Any]  = ntf.userInfo?["ncd"] as? [String:Any] {
            if let location = locationDict["location"]  {
                if let coordinate =  (location as?  CLLocation)?.coordinate {
                    self.animateToLocation(coordinate: coordinate)
                }
            }
        }
    }
    
    override func locationFail(_ ntf: Notification = Common.defaultNtf) {
    }
}

extension MapLocationVC :GMSMapViewDelegate {
    
    func setupMapView(mapView: GMSMapView) {
        mapView.delegate = self;
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.settings.allowScrollGesturesDuringRotateOrZoom = false;
        mapView.padding = UIEdgeInsets.init(top: searchVw.frame.maxY, left: 20, bottom: btnDone.frame.height, right: 20)
        mapView.applyStyle()
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition){
        if !isFromAutoComplete {
            let point = mapView.center;
            let myCoordinate = mapView.projection.coordinate(for: point)
            if myCoordinate.latitude != self.selectedAddress.latitude.toDouble || myCoordinate.longitude != self.selectedAddress.longitude.toDouble {
                self.setAddressDataFrom(coordinate: myCoordinate)
            }
        }
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        self.btnDone.gone()
    }
}

extension MapLocationVC : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        if gesture {
            self.isFromAutoComplete = false
        }
    }
    private func setupSearchbar(searchBar: UITextField) {
        txtSearchBar.delegate = self
        txtSearchBar.setFont(name: FontName.Regular, size: FontSize.textField_20)
        txtSearchBar.addTarget(self, action: #selector(searching(_:)), for: .editingChanged)
        txtSearchBar.changePlaceHolder(color: UIColor.themePrimary)
        txtSearchBar.placeholder = "TXT_SEARCH_ADDRESS".localized()
    }
    
    func searchData(for text: String) {
        if (text.count) > 2
        {
            lc?.getAutocomplete(text: text) { (array) in
                
                self.arrForAdress = array
                if self.arrForAdress.count > 0
                {
                    self.heightForAutoComplete.constant = self.tblAutocomplete.contentSize.height
                    self.reloadTableDateToFitHeight(tableView: self.tblAutocomplete)
                    self.tblAutocomplete.isHidden = false
                }
                else
                {
                    self.tblAutocomplete.isHidden = true
                }
            }
            
        }
    }
    
    @IBAction func searching(_ sender: UITextField) {
        searchData(for: sender.text ?? "")
    }
}
//MARK:  TableViewDataSource And Delegate

extension MapLocationVC: UITableViewDataSource,UITableViewDelegate {
    
    
    
    private func reloadTableDateToFitHeight(tableView: UITableView) {
        DispatchQueue.main.async {
            tableView.reloadData(heightToFit: self.heightForAutoComplete) {
                
            }
        }
        
    }
    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(AutocompleteLocationCell.nib()
            , forCellReuseIdentifier: AutocompleteLocationCell.name)
        tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrForAdress.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let autoCompleteCell = tableView.dequeueReusableCell(withIdentifier: AutocompleteLocationCell.name, for: indexPath) as?  AutocompleteLocationCell
        autoCompleteCell?.setCellData(place: arrForAdress[indexPath.row])
        return autoCompleteCell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat  {
        return UITableView.automaticDimension;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        tblAutocomplete.isHidden = true
        Loader.showLoading()
        self.txtSearchBar.text = ""
        self.setAddressDataFrom(placeID: arrForAdress[indexPath.row].placeID)
    }
    
}

//MARK:  Set Address
extension MapLocationVC {
    
    func setAddressDataFrom(placeID:String) {
        lc?.getAddress(placeId: placeID) {  [weak self] (address) in
            guard let self = self else {return}
            self.selectedAddress = address
            self.isFromAutoComplete = true
            self.animateToLocation(coordinate: CLLocationCoordinate2DMake(address.latitude.toDouble, address.longitude.toDouble))
            DispatchQueue.main.async {
                self.lblAddressValue.text = self.selectedAddress.addressLine1 + " " + self.selectedAddress.city + " " + "\n" + self.selectedAddress.province + " " + self.selectedAddress.pinCode
            }
            Loader.hideLoading()
        }
    }
    
    func setAddressDataFrom(coordinate:CLLocationCoordinate2D) {
        Loader.showLoading()
        self.lc?.getGMSAddress(coordinate: coordinate) { [weak self](address) in
            guard let self = self else {return}
            self.selectedAddress = address
            DispatchQueue.main.async {
                self.lblAddressValue.text = self.selectedAddress.addressLine1 + " " + self.selectedAddress.city + " " + "\n" + self.selectedAddress.province + " " + self.selectedAddress.pinCode
                self.btnDone.visible()
            }
            Loader.hideLoading()
        }
    }
    
}

