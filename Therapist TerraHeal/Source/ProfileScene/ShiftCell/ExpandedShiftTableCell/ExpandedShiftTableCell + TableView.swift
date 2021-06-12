//
//  TimeBreakDialog + CollectionView.swift
//  Therapist TerraHeal
//
//  Created by Jaydeep Vyas on 06/10/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import Foundation
import UIKit

protocol ShiftSelected: class {
    func dataChanged(data: ShiftContainerCellDetail)
}
// MARK: - CollectionView Methods
extension ExpandedShiftTableCell:  UITableViewDelegate, UITableViewDataSource {
     func setupTableView(tableView:  UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        tableView.register(ShiftTableCell.nib()
            , forCellReuseIdentifier: ShiftTableCell.name)
        tableView.tableFooterView = UIView()
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.shiftContainerData?.shifts.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = self.shiftContainerData?.shifts[indexPath.row] ?? ShiftCellDetail.init(shift: Shift.init(fromDictionary: [:]))
        let cell = tableView.dequeueReusableCell(withIdentifier: ShiftTableCell.name, for: indexPath) as?  ShiftTableCell
        cell?.layoutIfNeeded()
        cell?.setData(data: cellData)
        cell?.layoutIfNeeded()
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        for i in 0 ..< self.shiftContainerData!.shifts.count {
            self.shiftContainerData!.shifts[i].isSelected = false
        }
        self.shiftContainerData!.shifts[indexPath.row].isSelected = true
        self.delegate?.dataChanged(data: self.shiftContainerData!)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80//UITableView.automaticDimension
    }


}
