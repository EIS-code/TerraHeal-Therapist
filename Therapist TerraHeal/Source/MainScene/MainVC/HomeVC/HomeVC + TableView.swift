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
                if selectedFilterType == .Past {
                    view.imgFilterType.image = UIImage.init(named: ImageAsset.Filter.past)
                    view.lblFilterType.text = "Past"
                } else {
                    view.imgFilterType.image = UIImage.init(named: ImageAsset.Filter.future)
                    view.lblFilterType.text = "Future"
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
            self.hideFilterDialog()
        }  else {
            // Common.appDelegate.loadBookingDetailVC(navigaionVC: self.navigationController,isBookingFinished: self.arrForMyPlaces[indexPath.row].isSelected)
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tblForFilter ==  tableView{
            return 1
        }
        return 60
    }

}

