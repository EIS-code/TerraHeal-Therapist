//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit




class BookingDetailVC: MainVC {
    @IBOutlet weak var btnBack: FloatingRoundButton!
    @IBOutlet weak var ivProfilePic: UIImageView!
    @IBOutlet weak var scrVw: UIScrollView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var collectionVwForProfile: UICollectionView!
    @IBOutlet weak var hCltVw: NSLayoutConstraint!
    
    
    @IBOutlet weak var vwForFinishedService: UIView!
    @IBOutlet weak var vwPadding: UIView!
    @IBOutlet weak var lblFinished: ThemeLabel!
    @IBOutlet weak var lblStartTime: ThemeLabel!
    @IBOutlet weak var lblStartTimeValue: ThemeLabel!
    @IBOutlet weak var lblEndTime: ThemeLabel!
    @IBOutlet weak var lblEndTimeValue: ThemeLabel!
    
    @IBOutlet weak var btnIGo: ThemeButton!
    @IBOutlet weak var btnIamSafe: ThemeButton!
    @IBOutlet weak var hMapVw: NSLayoutConstraint!
    @IBOutlet weak var vwMap: UIView!
    @IBOutlet weak var ivMap: UIImageView!
    
    var isBookingFinished:Bool = false
    var arrForData: [BookingDetailCellDetail] = [
        BookingDetailCellDetail(title: "BOOKING_DETAIL_DATE".localized() , value: "28 oct 2020 3:30am"),
        BookingDetailCellDetail(title: "BOOKING_DETAIL_TYPE_OF_SERVICE".localized() , value: "thai yoga massage 10 min"),
        BookingDetailCellDetail(title: "BOOKING_DETAIL_SERVICE_DETAIL".localized() , value: "medium pressure"),
        BookingDetailCellDetail(title: "BOOKING_DETAIL_GENDER_PREFERENCE".localized() , value: "male only"),
        BookingDetailCellDetail(title: "BOOKING_DETAIL_SESSION_TYPE".localized() , value: "single"),
        BookingDetailCellDetail(title: "BOOKING_DETAIL_NEED_TO_BRING".localized() , value: "table 2"),
    ]
    
    // MARK: Object lifecycle
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
        self.setupCollectionView(collectionView: collectionVwForProfile)
        if isBookingFinished {
            vwForFinishedService.isHidden = false
            vwMap.isHidden = true
            hMapVw.constant = 0
        } else {
            vwForFinishedService.isHidden = true
            vwMap.isHidden = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if self.isViewAvailable() {
            self.ivProfilePic?.setRound()
            self.collectionVwForProfile.reloadData(heightToFit: self.hCltVw) {}
            self.ivMap.setRound(withBorderColor: UIColor.themeDarkText, andCornerRadious: 15.0, borderWidth: 1.0)
            self.vwPadding.setRound(withBorderColor: .clear, andCornerRadious: 5.0, borderWidth: 1.0)
            self.collectionVwForProfile.setRound(withBorderColor: .clear, andCornerRadious: 15.0, borderWidth: 1.0)
            self.vwForFinishedService.setRound(withBorderColor: .clear, andCornerRadious: 15.0, borderWidth: 1.0)
            self.btnIGo.setHighlighted(isHighlighted: true)
            self.btnIamSafe.setHighlighted(isHighlighted: false)
        }
    }
    
    private func initialViewSetup() {
        self.setTitle(title: "BOOKING_DETAIL_TITLE".localized())
        self.lblTitle?.setFont(name: FontName.Bold, size: FontSize.label_26)
        self.btnBack.setBackButton()
        self.lblFinished.text = "BOOKING_DETAIL_LBL_FINISHED".localized()
        self.lblStartTime.text = "BOOKING_DETAIL_LBL_START_TIME".localized()
        self.lblEndTime.text = "BOOKING_DETAIL_LBL_END_TIME".localized()
        self.lblStartTime.setFont(name: FontName.Bold, size: FontSize.label_22)
        self.lblStartTimeValue.setFont(name: FontName.SemiBold, size: FontSize.label_18)
        self.lblEndTime.setFont(name: FontName.Bold, size: FontSize.label_22)
        self.lblEndTimeValue.setFont(name: FontName.SemiBold, size: FontSize.label_18)
        self.lblFinished.setFont(name: FontName.Regular, size: FontSize.label_14)
        self.btnIGo?.setTitle("BOOKING_DETAIL_BTN_I_GO".localized(), for: .normal)
        self.btnIGo?.setFont(name: FontName.SemiBold, size: FontSize.button_14)
        self.btnIGo?.setHighlighted(isHighlighted: true)
        self.btnIamSafe?.setTitle("BOOKING_DETAIL_BTN_I_AM_SAFE".localized(), for: .normal)
        self.btnIamSafe?.setFont(name: FontName.SemiBold, size: FontSize.button_14)
        self.btnIamSafe?.setHighlighted(isHighlighted: false)
    }
    
    @IBAction func btnBackTapped(_ sender: Any) {
        _ = _ = (self.navigationController as? NC)?.popVC()
    }
    
    @IBAction func btnIgoTapped(_ sender: Any) {
        Common.appDelegate.loadMapBookVC(navigaionVC: self.navigationController)
    }
    
}



// MARK: - CollectionView Methods
extension BookingDetailVC:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private func setupCollectionView(collectionView:  UICollectionView) {
        collectionView.isUserInteractionEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(BookingDetailTblCell.nib()
            , forCellWithReuseIdentifier: BookingDetailTblCell.name)
        scrVw.delegate = self
        
        
    }
    
    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrForData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookingDetailTblCell.name, for: indexPath) as! BookingDetailTblCell
        cell.setData(data: self.arrForData[indexPath.row])
        cell.parent = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.bounds.width
        return CGSize(width: size , height: size * 0.2)
    }
}
