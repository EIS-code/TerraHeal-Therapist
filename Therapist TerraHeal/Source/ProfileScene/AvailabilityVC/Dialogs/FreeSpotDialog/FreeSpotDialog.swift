//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Jaydeep. All rights reserved.
//

import UIKit

struct FreeSpotCellDetail {
    var slotDetail: String = ""
    var isSelected: Bool = false
    static func getDemoArray() -> [FreeSpotCellDetail] {
        return [
            FreeSpotCellDetail.init(slotDetail: "9:00 am - 9:40"),
            FreeSpotCellDetail.init(slotDetail: "10:00 - 10:40"),
            FreeSpotCellDetail.init(slotDetail: "14:00 - 14:45", isSelected: true),
            FreeSpotCellDetail.init(slotDetail: "15:15 - 15:55"),
            FreeSpotCellDetail.init(slotDetail: "16:00 - 16:45"),
            FreeSpotCellDetail.init(slotDetail: "17:00 - 17:45")
        ]
    }
}
class FreeSpotDialog: ThemeBottomDialogView {
    
    @IBOutlet weak var collectionVw: UICollectionView!
    var onBtnDoneTapped: (( ) -> Void)? = nil
    var arrForData: [FreeSpotCellDetail] = FreeSpotCellDetail.getDemoArray()

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
        
    }
    
    override func initialSetup() {
        super.initialSetup()
        self.lblTitle.setFont(name: FontName.Bold, size: FontSize.header)
        self.setupCollectionView(collectionView: self.collectionVw)

        self.setDataForStepUpAnimation()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    @IBAction func btnDoneTapped(_ sender: Any) {
        if self.onBtnDoneTapped != nil {
            self.onBtnDoneTapped!();
        }
    }
    


}


// MARK: - CollectionView Methods
extension FreeSpotDialog:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private func setupCollectionView(collectionView:  UICollectionView) {
        collectionView.backgroundColor = UIColor.clear
        collectionView.isUserInteractionEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FreeSpotCltCell.nib()
            , forCellWithReuseIdentifier: FreeSpotCltCell.name)
        
    }
    
    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrForData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FreeSpotCltCell.name, for: indexPath) as! FreeSpotCltCell
        cell.setData(data: self.arrForData[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        for index in 0..<arrForData.count  {
            self.arrForData[index].isSelected = false
        }
        self.arrForData[indexPath.row].isSelected = true
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.bounds.width / 2.0
        return CGSize(width: size , height: size/3.0)
    }
    
}
