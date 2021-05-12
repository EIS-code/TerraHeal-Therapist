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
extension ExchangeOfferVC:  UITableViewDelegate, UITableViewDataSource {
     func setupAvailabilityView(tableView:  UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(TherapistCollapseShiftTableCell.nib()
            , forCellReuseIdentifier: TherapistCollapseShiftTableCell.name)
        tableView.register(TherapistExpandedShiftTableCell.nib()
            , forCellReuseIdentifier: TherapistExpandedShiftTableCell.name)
        tableView.tableFooterView = UIView()
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrForData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let therapistData: AvailabilityCellDetail = self.arrForData[indexPath.row]
        if therapistData.isSelected {
            let cell = tableView.dequeueReusableCell(withIdentifier: TherapistExpandedShiftTableCell.name, for: indexPath) as?  TherapistExpandedShiftTableCell
            cell?.parentVC = self
            cell?.setData(data: arrForData[indexPath.row])
            return cell!
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TherapistCollapseShiftTableCell.name, for: indexPath) as?  TherapistCollapseShiftTableCell
            cell?.parentVC = self
            cell?.setData(data: arrForData[indexPath.row])
            return cell!
        }

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        for index in 0..<self.arrForData.count{
            self.arrForData[index].isSelected = false
        }
        self.arrForData[indexPath.row].isSelected = true
        self.tblForAvailability.reloadData()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.tblForAvailability.reloadData {
                self.tblForAvailability.scrollToRow(at: indexPath, at: .top, animated: true)
            }

        }

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if arrForData[indexPath.row].isSelected {
            return UITableView.automaticDimension
        } else {
            return 80.0
        }

    }
    

}
