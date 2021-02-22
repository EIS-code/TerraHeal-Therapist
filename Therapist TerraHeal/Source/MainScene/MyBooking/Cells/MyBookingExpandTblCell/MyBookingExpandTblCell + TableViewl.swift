//
//  MyBookingExpandTblCell + MassageDetail.swift
//  Terra Heal
//
//  Created by Jaydeep Vyas on 29/09/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import Foundation
import UIKit

extension MyBookingExpandTblCell :  UITableViewDelegate,UITableViewDataSource {
    func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 40
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 50
        tableView.separatorStyle = .none
        tableView.register(MassageDetailTblCell.nib()
                   , forCellReuseIdentifier: MassageDetailTblCell.name)
        tableView.register(UserDetailTblSection.nib(), forHeaderFooterViewReuseIdentifier: UserDetailTblSection.name)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrForData.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrForData[section].bookingMassages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let data = arrForData[indexPath.section].bookingMassages[indexPath.row]
       let cell = tableView.dequeueReusableCell(withIdentifier: MassageDetailTblCell.name, for: indexPath) as?  MassageDetailTblCell
        cell?.layoutIfNeeded()
        
        cell?.setData(data: MassageCellDetail.init(data: data))
        cell?.layoutIfNeeded()
        return cell!
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       guard let view = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: UserDetailTblSection.name)
            as? UserDetailTblSection
            else {
                return nil
        }
        view.setData(data: UserDetailSectionModel.init(name:arrForData[0].name, age: arrForData[0].age, gender: arrForData[0].gender))
        return view

    }
}
