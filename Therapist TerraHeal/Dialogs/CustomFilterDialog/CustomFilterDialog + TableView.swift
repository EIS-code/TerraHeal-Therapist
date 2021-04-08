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
        self.arrForData = []
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
        tableView.register(SessionTypeTblSection.nib(), forHeaderFooterViewReuseIdentifier: SessionTypeTblSection.name)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return arrForData.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arrForData[section].isExpanded {
            return arrForData[section].sessions.count
        } else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RadioSelectionTblCell.name, for: indexPath) as?  RadioSelectionTblCell
        cell?.layoutIfNeeded()
        cell?.setData(data: arrForData[indexPath.section].sessions[indexPath.row])
        cell?.layoutIfNeeded()
        return cell!

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        for i in 0..<arrForData[indexPath.section].sessions.count {
            arrForData[indexPath.section].sessions[i].isSelected = false
        }
        self.arrForData[indexPath.section].sessions[indexPath.row].isSelected = true
        self.selectedValue = self.arrForData[indexPath.section].sessions[indexPath.row].id
        //self.selectedFilterValues.massage_date = self.selectedMilli.toString()
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(
                        withIdentifier: SessionTypeTblSection.name)
                        as? SessionTypeTblSection
        else {return nil}
        view.ivForSessionType.image = ImageAsset.getImage(arrForData[section].image)
        view.btnSelectSection.tag = section
        view.lblSectionTitle.setText(arrForData[section].name)
        print(arrForData[section].name)
        view.btnSelectSection.addTarget(self, action: #selector(btnSelectSectionTapped(_:)), for: .touchUpInside)
        return view
    }

    @IBAction func btnSelectSectionTapped(_ sender: UIButton) {
        for i in 0..<self.arrForData.count {
            self.arrForData[i].isExpanded = false
        }
        self.arrForData[sender.tag].isExpanded = true
        self.tblForSessionType.reloadData()
    }
    
}
