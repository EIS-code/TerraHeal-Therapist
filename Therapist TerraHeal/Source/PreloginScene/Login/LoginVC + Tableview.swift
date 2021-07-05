//
//  LoginVC + Tableview.swift
//  UONDA
//
//  Created by Jaydeep Vyas on 15/10/20.
//  Copyright © 2020 Jaydeep Vyas. All rights reserved.
//

import Foundation
import UIKit
//import IQKeyboardManagerSwift


extension LoginVC :  UITableViewDelegate,UITableViewDataSource {
    func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        tableView.sectionHeaderHeight = 1
        tableView.sectionFooterHeight = 1
        tableView.estimatedSectionHeaderHeight = 1
        tableView.isScrollEnabled = false
        tableView.bounces = false
        tableView.backgroundColor = UIColor.clear
        tableView.register(TextFieldTableCell.nib()
                   , forCellReuseIdentifier: TextFieldTableCell.name)
        tableView.reloadData(heightToFit: self.hTblData) {

        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loginForm.formItems.count
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let item = self.loginForm.formItems[indexPath.row]
       if let cell: TextFieldTableCell = tableView.dequeueReusableCell(withIdentifier: TextFieldTableCell.name, for: indexPath) as? TextFieldTableCell {
        cell.txtCellItem.delegate = self
        cell.setCellData(data: item)
           return cell
       }
       return UITableViewCell()
    }
}
//MARK: TextField Delegate
extension LoginVC : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.focusNext()
        return true
    }
}
