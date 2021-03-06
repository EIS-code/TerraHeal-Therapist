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
        tableView.tableFooterView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.bounds.width, height: JDDeviceHelper.offseter(offset: 100)))
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
        return self.arrForData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if tableView == tblForFilter {
            let cell = tableView.dequeueReusableCell(withIdentifier: FilterTblCell.name, for: indexPath) as?  FilterTblCell
            cell?.setData(data: arrForFilter[indexPath.row])
            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: MyBookingTblCell.name, for: indexPath) as?  MyBookingTblCell
            cell?.layoutIfNeeded()
            cell?.vwBar.isHidden = true
            cell?.setData(data: self.arrForData[indexPath.row])
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
                if let date = self.selectedDate {
                    view.lblSelectDate.setText(date.toString(format: "dd-MM-yyyy"))
                }
                view.btnSelectDate.addTarget(self, action: #selector(openDatePicker(sender:)), for: .touchUpInside)
                if #available(iOS 14.0, *) {
                    //view.backgroundConfiguration = UIBackgroundConfiguration.clear()
                } else {
                    // Fallback on earlier versions
                    //view.backgroundColor = .clear
                }
                if selectedFilterType == .Past {
                    view.imgFilterType.image = UIImage.init(named: ImageAsset.Filter.pastDark)
                    view.lblFilterType.setText("HOME_FILTER_PAST".localized())
                } else {
                    view.imgFilterType.image = UIImage.init(named: ImageAsset.Filter.futureDark)
                    view.lblFilterType.setText("HOME_FILTER_FUTURE".localized())
                }
                return view
            }
        }
        return nil
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if tableView == tblForFilter {
            if let data = self.arrForFilter[indexPath.row].data as? BookingDateFilterType {
                self.selectedFilterType = data
            }
            switch self.selectedFilterType {
            case .Future:
                self.wsGetFutureBooking(request: self.currentBookingRequest)
            case .Past:
                self.wsGetPastBooking(request: self.currentBookingRequest)
            default:
                self.wsGetTodaysBooking(request: self.currentBookingRequest)
            }
            self.tableView.reloadData()
            self.updateFilterButton(isShowFilter: false)
        }  else {
            Common.appDelegate.loadBookingDetailVC(navigaionVC: self.navigationController, completion: {/* [weak self]*/ (bookingDetailVC) in
                appSingleton.bookingTypeSelected = self.selectedFilterType
                appSingleton.currentService = BookingDetail.init(fromDictionary: [:])
                appSingleton.currentService.bookingInfoId = self.arrForOriginalData[indexPath.row].bookingInfoId
                appSingleton.currentService.bookingMassageId = self.arrForOriginalData[indexPath.row].bookingMassageId
            })
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

