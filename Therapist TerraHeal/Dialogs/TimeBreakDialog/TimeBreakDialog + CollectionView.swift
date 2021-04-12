//
//  TimeBreakDialog + CollectionView.swift
//  Therapist TerraHeal
//
//  Created by Jaydeep Vyas on 06/10/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import Foundation
import UIKit


// MARK: - CollectionView Methods
extension TimeBreakDialog:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
     func setupCollectionView(collectionView:  UICollectionView) {
        collectionView.backgroundColor = UIColor.clear
        collectionView.isUserInteractionEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TimeSlotCltCell.nib()
            , forCellWithReuseIdentifier: TimeSlotCltCell.name)
        
    }

    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrForData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimeSlotCltCell.name, for: indexPath) as! TimeSlotCltCell
        cell.setData(data: self.arrForData[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        self.txtBreakTime.setText("")
        self.txtBreakTime.resignFirstResponder()
        self.select(data: self.arrForData[indexPath.row])
        self.timePicker.setDate(Date().add(component: .minute, value: self.arrForData[indexPath.row].minute.toInt), animated: true)
        self.minutes =  self.arrForData[indexPath.row].minute.toInt
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.bounds.width / 6.0
        return CGSize(width: size , height: size)
    }


}
