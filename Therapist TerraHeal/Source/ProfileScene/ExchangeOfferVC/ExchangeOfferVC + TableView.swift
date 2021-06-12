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
     func setupTableView(tableView:  UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(CollapseShiftTableCell.nib()
            , forCellReuseIdentifier: CollapseShiftTableCell.name)
        tableView.register(ExpandedShiftTableCell.nib()
            , forCellReuseIdentifier: ExpandedShiftTableCell.name)
        tableView.tableFooterView = UIView()
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrForData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData: ShiftContainerCellDetail = self.arrForData[indexPath.row]
        if cellData.isSelected {
            let cell = tableView.dequeueReusableCell(withIdentifier: ExpandedShiftTableCell.name, for: indexPath) as?  ExpandedShiftTableCell
            cell?.parentVC = self
            cell?.delegate = self
            cell?.setData(data: cellData)
            return cell!
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: CollapseShiftTableCell.name, for: indexPath) as?  CollapseShiftTableCell
            cell?.parentVC = self
            cell?.setData(data: cellData)
            return cell!
        }

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.selectShiftData(index: indexPath.row)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.tblVwForData.reloadData {
                self.tblVwForData.scrollToRow(at: indexPath, at: .top, animated: true)
            }

        }
    }

    func  selectShiftData(index:Int) {
        for i in 0..<self.arrForData.count{
            self.arrForData[i].isSelected = false
        }
        self.arrForData[index].isSelected = true
        self.tblVwForData.reloadData()

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if arrForData[indexPath.row].isSelected {
            return UITableView.automaticDimension
        } else {
            return 80.0
        }

    }
    

}

extension ExchangeOfferVC: ShiftSelected {
    func dataChanged(data: ShiftContainerCellDetail) {
        self.selectedShiftForExchange.exchangeShiftData(data: data)
    }


}
