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
extension TimeBreakDialog:  UITableViewDataSource, UITableViewDelegate {
    func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.register(DatePickerTableCell.nib(), forCellReuseIdentifier: DatePickerTableCell.name)
        tableView.register(ShiftTableSection.nib(), forHeaderFooterViewReuseIdentifier: ShiftTableSection.name)
        self.tblForData.reloadData()
        /*self.tblForData.reloadData(heightToFit: self.hTblVw) {
            
        }*/

    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return arrForData.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arrForData[section].isSelected {
            return 1
        }
        return 0
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DatePickerTableCell.name, for: indexPath) as?  DatePickerTableCell
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        guard let view = tableView.dequeueReusableHeaderFooterView(
                            withIdentifier: ShiftTableSection.name)
                            as? ShiftTableSection
            else {return nil}
        view.setData(data: arrForData[section])
        view.btnSelectShift.tag = section
        view.btnSelectShift.addTarget(self, action: #selector(btnSelectSectionTapped(sender:)), for: .touchUpInside)
        return view
    }
    @objc @IBAction func btnSelectSectionTapped(sender:UIButton){
        self.resetArray()
        arrForData[sender.tag].isSelected = true
        self.tblForData.reloadData()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.7) { [self] in
            if self.arrForData.count > sender.tag {
                let indexPath = IndexPath.init(row: 0, section: sender.tag)
               // self.tblForData.scrollToRow(at: indexPath, at: .top, animated: true)

            }

        }

    }
}
