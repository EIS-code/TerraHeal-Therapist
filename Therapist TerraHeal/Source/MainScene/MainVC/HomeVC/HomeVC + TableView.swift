//
//  HomeVC + TableView.swift
//  Therapist TerraHeal
//
//  Created by Jaydeep Vyas on 02/10/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import Foundation
import UIKit

extension HomeVC: UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate {

    func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }

    func registerNib(tableView: UITableView) {
        tableView.register(MyBookingTblCell.nib()
            , forCellReuseIdentifier: MyBookingTblCell.name)
        tableView.register(MyBookingTblSection.nib(), forHeaderFooterViewReuseIdentifier: MyBookingTblSection.name)
        tableView.tableFooterView = UIView()
    }

    func registerFilterNib(tableView: UITableView) {
        tableView.register(FilterTblCell.nib()
            , forCellReuseIdentifier: FilterTblCell.name)
        tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblForFilter {
            return arrForFilter.count
        }
        return arrForMyPlaces.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if tableView == tblForFilter {
            let cell = tableView.dequeueReusableCell(withIdentifier: FilterTblCell.name, for: indexPath) as?  FilterTblCell
            cell?.setData(data: arrForFilter[indexPath.row])
            return cell!

        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: MyBookingTblCell.name, for: indexPath) as?  MyBookingTblCell
            cell?.layoutIfNeeded()
            cell?.setData(data: arrForMyPlaces[indexPath.row])
            cell?.layoutIfNeeded()
            return cell!
        }


    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == tblForFilter {
            return UITableView.automaticDimension
        }
        return UITableView.automaticDimension

    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == tableView {
            if selectedFilterType == .Today {
                return nil
            } else {
                guard let view = tableView.dequeueReusableHeaderFooterView(
                    withIdentifier: MyBookingTblSection.name)
                    as? MyBookingTblSection
                    else {
                        return nil
                }
                if #available(iOS 14.0, *) {
                    view.backgroundConfiguration = UIBackgroundConfiguration.clear()
                } else {
                    // Fallback on earlier versions
                    view.backgroundColor = .clear
                }

                view.backgroundView?.backgroundColor = .blue
                if selectedFilterType == .Past {
                    view.imgFilterType.image = UIImage.init(named: ImageAsset.Filter.pastDark)
                    view.lblFilterType.setText("Past")
                } else {
                    view.imgFilterType.image = UIImage.init(named: ImageAsset.Filter.futureDark)
                    view.lblFilterType.setText("Future")
                }
                return view
            }
        }
        return nil
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if tableView == tblForFilter {
            if let data = self.arrForFilter[indexPath.row].data as? FilterType {
                self.selectedFilterType = data
            }
            print(self.selectedFilterType.rawValue)
            self.tableView.reloadData()

            self.updateFilterButton(isShowFilter: false)
        }  else {
            if indexPath.row % 2 == 0 {
                Common.appDelegate.loadBookingDetailVC(navigaionVC: self.navigationController, completion: {/* [weak self]*/ (bookingDetailVC) in
                    bookingDetailVC.bookingDetail = BookingWebSerive.BookingDetail.init(fromDictionary: [:])
                    bookingDetailVC.bookingDetail.bookingInfoId = arrForMyPlaces[indexPath.row].id
                    bookingDetailVC.bookingDetail.bookingType = BookingType.MassageCenter.rawValue
                })
            } else {
                Common.appDelegate.loadBookingDetailVC(navigaionVC: self.navigationController, completion: { /*[weak self]*/ (bookingDetailVC) in
                    bookingDetailVC.bookingDetail = BookingWebSerive.BookingDetail.init(fromDictionary: [:])
                    bookingDetailVC.bookingDetail.bookingInfoId = arrForMyPlaces[indexPath.row].id
                    bookingDetailVC.bookingDetail.bookingType = BookingType.AtHotelOrRoom.rawValue
                })
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if selectedFilterType != .Today && tableView == self.tableView {

            return JDDeviceHelper.offseter(offset: 60, direction: .vertical)
        } else {
            return 0
        }
    }

}

