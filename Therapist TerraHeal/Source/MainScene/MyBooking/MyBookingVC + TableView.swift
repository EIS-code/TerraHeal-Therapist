//
//  MyBookingVC + TableView.swift
//  Therapist TerraHeal
//
//  Created by Jaydeep Vyas on 09/10/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import Foundation
import UIKit

extension MyBookingVC: UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate {

    func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 500
        tableView.register(MyBookingTblCell.nib()
            , forCellReuseIdentifier: MyBookingTblCell.name)
        tableView.register(MyBookingExpandTblCell.nib()
        , forCellReuseIdentifier: MyBookingExpandTblCell.name)
        tableView.tableFooterView = UIView()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrForData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if arrForData[indexPath.row].isSelected {
            let cell = tableView.dequeueReusableCell(withIdentifier: MyBookingExpandTblCell.name, for: indexPath) as?  MyBookingExpandTblCell
            cell?.parentVC = self
            cell?.indexPath = indexPath
            cell?.layoutIfNeeded()
            cell?.setData(data: [MyBookingUserPeople.init(fromDictionary: [:]),MyBookingUserPeople.init(fromDictionary: [:])])
            cell?.layoutIfNeeded()
            print("Cell Height: \(cell?.bounds)")
            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: MyBookingTblCell.name, for: indexPath) as?  MyBookingTblCell
            //cell?.setData(data: arrForData[indexPath.row])
            return cell!
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if arrForData[indexPath.row].isSelected {
            print("Row Height:- \(tableView.estimatedRowHeight)")
            return UITableView.automaticDimension
        }
        return UITableView.automaticDimension

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.arrForData[indexPath.row].isSelected.toggle()
        self.tableView.reloadRows(at: [indexPath], with: .fade)
    }

}

extension MyBookingVC {

    func setDataSourceForPastBooking(dataSource:[MyBookingData]) {
        self.arrForData.removeAll()
        for data in dataSource {
            self.arrForData.append(
                .init(data: data))
        }
    }
}

