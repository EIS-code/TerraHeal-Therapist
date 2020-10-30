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
extension AvailabilityVC:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
     func setupCollectionView(collectionView:  UICollectionView) {



        collectionView.backgroundColor = UIColor.clear
        collectionView.isUserInteractionEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.register(AvailabilityCell.nib()
            , forCellWithReuseIdentifier: AvailabilityCell.name)



        let width = JDDeviceHelper.offseter(offset: collectionView.bounds.width/3.0)
        let size: CGSize = CGSize.init(width: width, height: JDDeviceHelper.offseter(offset: 40))
        self.hCltVw.constant = size.height * 8.0
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = size
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView.reloadData()
        collectionView.collectionViewLayout = layout


        
    }

    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrForData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AvailabilityCell.name, for: indexPath) as! AvailabilityCell
        cell.setData(data: self.arrForData[indexPath.row])
        print((collectionView.collectionViewLayout as! UICollectionViewFlowLayout).minimumInteritemSpacing)
        print((collectionView.collectionViewLayout as! UICollectionViewFlowLayout).minimumLineSpacing)
        cell.backgroundColor = .yellow
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }

   /* func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.bounds.width / 3.0
        let heightRatio = JDDeviceHelper.offseter(scaleFactor: 1.0, offset: 3.66, direction: .vertical)
        return CGSize(width: size , height: size/heightRatio)
    }*/
    

}
