//
//  EditProfile + CollectionView.swift
//  Therapist TerraHeal
//
//  Created by Jaydeep Vyas on 27/10/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import Foundation
import UIKit


extension EditProfileVC:  UIScrollViewDelegate {

    @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
        var point = recognizer.location(in: self.scrVw)
        point.y = point.y + self.kTableHeaderHeight + self.scrVw.frame.origin.y
        let buttonFrame = self.btnAddPicture.superview!.convert(self.btnAddPicture.frame, to: self.view)
        if (buttonFrame.contains(point)) {
            self.btnAddPictureTapped(btnAddPicture ?? UIButton())
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateHeaderView()
    }
    func updateHeaderView() {

        if self.scrVw.contentOffset.y < 0 {
            let y = abs(self.scrVw.contentOffset.y)
            let transLation = y/kTableHeaderHeight
            headerView.alpha = transLation
            headerView.transform = CGAffineTransform.init(scaleX: transLation, y: transLation)
            self.collectionVwForProfile.isScrollEnabled = false
        } else {
            headerView.alpha = 0.0
            self.collectionVwForProfile.isScrollEnabled = true
        }
    }


}


// MARK: - CollectionView Methods
extension EditProfileVC:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func setupCollectionView(collectionView:  UICollectionView) {
        collectionView.backgroundColor = UIColor.clear
        collectionView.isUserInteractionEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(EditProfileCell.nib()
            , forCellWithReuseIdentifier: EditProfileCell.name)
        scrVw.delegate = self
    }

    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrForProfile.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EditProfileCell.name, for: indexPath) as! EditProfileCell
        cell.setData(data: self.arrForProfile[indexPath.row])
        cell.parent = self
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        print(indexPath.item)
        let data = arrForProfile[indexPath.item]
        switch data.type {
        case .Name,.Surname,.Nif, .Email, .AccountNumber, .Ssn :
            self.openTextFieldPicker(index: indexPath.row)
        case .Documents:
            Common.appDelegate.loadMyDocumentsVC(navigaionVC: self.navigationController)
        case .Gender:
            self.openGenderPicker(index: indexPath.row)
        case .DOB:
            self.openDatePicker(index: indexPath.row)
        case .LanguageSpoken:
            self.openLanguageSelectionDialog(index: indexPath.row)
        case .Description:
            self.openPersonalDetailDialog(index: indexPath.row)
        case .HealthCodndition:
            self.openHeathConditionDialog(index: indexPath.row)
        case .Phone:
            self.openMobileNumberDialog(index: indexPath.row)
        case .EmergencyContact:
            self.openMobileNumberDialog(index: indexPath.row)
        case .City:
            self.openCityPicker(index: indexPath.row, countryId: selectedCountry ??  "")
        case .Country:
            self.openCountryPicker(index: indexPath.row)
        case .Services:
            self.openServiceSelection(index: indexPath.row)
        case .Experience:
            Common.appDelegate.loadManageDocumentVC(navigaionVC: self.navigationController, docType: .PersonalExperience)
        default:
            print("")
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.bounds.width
        let data = arrForProfile[indexPath.row]
        if data.type == .Country || data.type == .City  {
            return CGSize(width: (size / 2.0) - 10, height: JDDeviceHelper.offseter(offset: 52.0))
        }
        return CGSize(width: size , height: JDDeviceHelper.offseter(offset: 52.0))
    }
}
