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
        tableView.register(MyBookingCollapseCell.nib()
            , forCellReuseIdentifier: MyBookingCollapseCell.name)
        tableView.register(MyBookingExpandTblCell.nib()
        , forCellReuseIdentifier: MyBookingExpandTblCell.name)
        tableView.tableFooterView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.bounds.width, height: JDDeviceHelper.offseter(offset: 88)))
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrForOriginalBooking.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let data = arrForOriginalBooking[indexPath.row]
        if data.isSelected {
            let cell = tableView.dequeueReusableCell(withIdentifier: MyBookingExpandTblCell.name, for: indexPath) as?  MyBookingExpandTblCell
            cell?.parentVC = self
            cell?.indexPath = indexPath
            cell?.layoutIfNeeded()
            cell?.setData(data: data)
            self.tableView.reloadRows(at: [indexPath], with: .none)
            cell?.layoutIfNeeded()
            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: MyBookingCollapseCell.name, for: indexPath) as?  MyBookingCollapseCell
            cell?.setData(data: data)
            return cell!
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if arrForOriginalBooking[indexPath.row].isSelected {
            print("Row Height:- \(tableView.estimatedRowHeight)")
            return UITableView.automaticDimension
        }
        return UITableView.automaticDimension

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        for i in 0..<arrForOriginalBooking.count {
            if indexPath.row != i {
                arrForOriginalBooking[i].isSelected = false
            } else {
                self.arrForOriginalBooking[indexPath.row].isSelected.toggle()
            }

        }
        tableView.beginUpdates()
        if arrForOriginalBooking[indexPath.row].isSelected {
            self.tableView.reloadRows(at: [indexPath], with: .fade)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
                self.tableView.reloadData()
            }
        } else {
            self.tableView.reloadRows(at: [indexPath], with: .fade)
        }
        tableView.endUpdates()

    }

}

extension MyBookingVC {

   
}

