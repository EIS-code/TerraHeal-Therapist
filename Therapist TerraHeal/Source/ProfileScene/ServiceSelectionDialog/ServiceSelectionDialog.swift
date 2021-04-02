//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Jaydeep. All rights reserved.
//

import UIKit

enum ServiceType: Int {
    case Massages = 0
    case Therapies = 1
}
class ServiceSelectionDialog: ThemeBottomDialogView {
    
    @IBOutlet weak var collectionVw: UICollectionView!
    @IBOutlet weak var vwServiceSelection: JDSegmentedControl!
    var selectedService: ServiceType = ServiceType.Massages
    var onBtnDoneTapped: (( ) -> Void)? = nil
    var arrForData: [Service] = []
    var arrForMassage: [Service] = []
    var arrForTherapies: [Service] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func initialize(title:String,buttonTitle:String,cancelButtonTitle:String) {
        
        self.initialSetup()
        self.lblTitle.text = title
        if cancelButtonTitle.isEmpty() {
            self.btnCancel.isHidden = true
        } else {
            self.btnCancel.setTitle(cancelButtonTitle, for: .normal)
            self.btnCancel.isHidden = false
        }
        if buttonTitle.isEmpty() {
            self.btnDone.isHidden = true
        } else {
            self.btnDone.setTitle(buttonTitle, for: .normal)
            self.btnDone.isHidden = false
        }
        self.wsGetServices()
        
    }
    
    override func initialSetup() {
        super.initialSetup()
        self.lblTitle.setFont(name: FontName.Bold, size: FontSize.header)
        self.setupCollectionView(collectionView: self.collectionVw)
        self.vwServiceSelection.allowChangeThumbWidth = false
        self.vwServiceSelection.itemTitles = ["massages".localized(),"therapies".localized()]
        self.vwServiceSelection.thumbColor = UIColor.themePrimary
        self.vwServiceSelection.changeBackgroundColor(UIColor.themeLightTextColor)
        self.vwServiceSelection.didSelectItemWith = { [weak self] (index,title) in
            guard let self = self else {
                return
            }
            
            if index == 0 {
                self.massagesTapped()
            } else {
                self.therapiesTapped()
            }
        }
        self.setDataForStepUpAnimation()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    @IBAction func btnDoneTapped(_ sender: Any) {
        self.wsUpdateMassages()


    }
    
    func setServicesFor(type:ServiceType) {
        if type == .Massages {
            self.massagesTapped()
        } else {
            self.therapiesTapped()
        }
    }
    
    func massagesTapped(){
        self.arrForData = self.arrForMassage
        self.vwServiceSelection.selectItemAt(index: 0)
        self.selectedService = ServiceType.Massages
        collectionVw.reloadData()
    }
    
    func therapiesTapped(){
        self.arrForData = self.arrForTherapies
        self.vwServiceSelection.selectItemAt(index: 1)
        self.selectedService = ServiceType.Therapies
        collectionVw.reloadData()
    }

}


// MARK: - CollectionView Methods
extension ServiceSelectionDialog:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private func setupCollectionView(collectionView:  UICollectionView) {
        collectionView.backgroundColor = UIColor.clear
        collectionView.isUserInteractionEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ServiceCltCell.nib()
            , forCellWithReuseIdentifier: ServiceCltCell.name)
        
    }
    
    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrForData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ServiceCltCell.name, for: indexPath) as! ServiceCltCell
        cell.setData(data: self.arrForData[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.bounds.width / 2.0
        return CGSize(width: size , height: size)
    }
    
}

//MARK:- Web Service Clls

extension ServiceSelectionDialog {

    func wsGetServices() {
        ServiceWebService.getAllServices { (response) in
            if ResponseModel.isSuccess(response: response) {
                for i in 0..<response.serviceList.count {
                    var data = response.serviceList[i]
                    if appSingleton.user.selectedMassages.contains(where: { (massages) -> Bool in
                        massages.id == data.id
                    }) {
                        data.isSelected = true
                    } else {
                        data.isSelected = false
                    }
                    self.arrForData.append(data)
                    self.arrForMassage.append(data)
                    self.arrForTherapies.append(data)
                }
            }
            self.collectionVw.reloadData()
        }
    }

    func wsUpdateMassages() {
        Loader.showLoading()
        var arrForIds:[String] = []
        for data in arrForData {
            if data.isSelected {
                arrForIds.append(data.id)
            }
        }
        AppWebApi.updateMassages(params: UserWebService.RequestUpdateMassage.init(my_massages: arrForIds)) { (response) in
            Loader.hideLoading()
            if ResponseModel.isSuccess(response: response, withSuccessToast: false, andErrorToast: true) {
                let user = response.data
                PreferenceHelper.shared.setUserId(user.id)
                appSingleton.user = user
                Singleton.saveInDb()
                if self.onBtnDoneTapped != nil {
                    self.onBtnDoneTapped!();
                }
            }
        }
    }
}
