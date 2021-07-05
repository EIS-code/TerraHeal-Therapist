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
        self.setupTableView(tableView: self.tblForSessionType)
        self.arrForData = []
        self.tblForSessionType.reloadData()

    }

    func setupTableView(tableView: UITableView) {
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
        if tableView == tblForSessionType {
            return arrForData.count
        }
        return 1

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblForSessionType {
            if arrForData[section].isExpanded {
                return arrForData[section].sessions.count
            } else {
                return 0
            }
        } else if tableView == tblForClient {
            return arrForClientData.count
        } else {
            if self.vwServiceSelection.currentIndex == 0 {
                return arrForMassageData.count
            } else {
                return arrForTherapyData.count
            }

        }

    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if  tableView == self.tblForSessionType {
            return 50
        }
        return 1

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RadioSelectionTblCell.name, for: indexPath) as?  RadioSelectionTblCell
        cell?.layoutIfNeeded()
        switch tableView {
        case self.tblForClient:
            cell?.setData(data: self.arrForClientData[indexPath.row])
            break;
        case self.tblForServices:
            if vwServiceSelection.currentIndex == 0 {
                cell?.setData(data: self.arrForMassageData[indexPath.row])
            } else {
                cell?.setData(data: self.arrForTherapyData[indexPath.row])
            }
            break;
        default:
            cell?.setData(data: arrForData[indexPath.section].sessions[indexPath.row])
        }

        cell?.layoutIfNeeded()
        return cell!

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch tableView {
        case self.tblForServices:
            if self.selectedServiceType == .Massages {
                for i in 0..<arrForMassageData.count {
                    arrForMassageData[i].isSelected = false
                }
                self.arrForMassageData[indexPath.row].isSelected = true
                self.selectedValue = self.arrForMassageData[indexPath.row].massageId
            } else {
                for i in 0..<arrForTherapyData.count {
                    arrForTherapyData[i].isSelected = false
                }
                self.arrForTherapyData[indexPath.row].isSelected = true
                self.selectedValue = self.arrForTherapyData[indexPath.row].therapyId
            }
            break;
        case self.tblForClient:
            for i in 0..<arrForClientData.count {
                arrForClientData[i].isSelected = false
            }
            self.arrForClientData[indexPath.row].isSelected = true
            self.selectedValue = self.arrForClientData[indexPath.row].id
            break;
        case self.tblForSessionType:
            for i in 0..<arrForData[indexPath.section].sessions.count {
                arrForData[indexPath.section].sessions[i].isSelected = false
            }
            self.arrForData[indexPath.section].sessions[indexPath.row].isSelected = true
            self.selectedValue = self.arrForData[indexPath.section].sessions[indexPath.row].id
            break;
        default:
            print("")
        }

        //self.selectedFilterValues.massage_date = self.selectedMilli.toString()
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == tblForSessionType {
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
        return nil

    }

    @IBAction func btnSelectSectionTapped(_ sender: UIButton) {
        for i in 0..<self.arrForData.count {
            self.arrForData[i].isExpanded = false
        }
        self.arrForData[sender.tag].isExpanded = true
        self.tblForSessionType.reloadData()
    }
    
}
