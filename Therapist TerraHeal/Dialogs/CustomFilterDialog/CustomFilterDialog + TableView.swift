//
//  CustomFilterDialog + TableView.swift
//  Therapist TerraHeal
//
//  Created by Jaydeep Vyas on 07/10/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import Foundation
import UIKit

extension CustomFilterDialog: UITableViewDelegate, UITableViewDataSource {

    func setupSession() {
        self.vwSession.frame = self.activeView.bounds
        self.activeView.addSubview(self.vwSession)
        self.setupSessionTableView(tableView: self.tblForSessionType)
        self.arrForData = [
            RadioSelectionTblCellDetail.init(id: "1", title: "SESSION_TYPE_SINGLE".localized()),
            RadioSelectionTblCellDetail.init(id: "2", title: "SESSION_TYPE_COUPLE".localized()),
            RadioSelectionTblCellDetail.init(id: "3", title: "SESSION_TYPE_GROUPE".localized())]
        self.tblForSessionType.reloadData()




    }

    private func setupSessionTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.register(RadioSelectionTblCell.nib(), forCellReuseIdentifier: RadioSelectionTblCell.name)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrForData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RadioSelectionTblCell.name, for: indexPath) as?  RadioSelectionTblCell
        cell?.layoutIfNeeded()
        cell?.setData(data: arrForData[indexPath.row])
        cell?.layoutIfNeeded()
        return cell!

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        for i in 0..<arrForData.count {
            arrForData[i].isSelected = false
        }
        self.arrForData[indexPath.row].isSelected = true
        self.selectedValue = self.arrForData[indexPath.row].title
        self.selectedFilterValues.massage_date = self.selectedMilli.toString()
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
