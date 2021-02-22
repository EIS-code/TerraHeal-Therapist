//
//  BookingDetailVC + Tableview.swift
//  
//
//  Created by Jaydeep Vyas on 09/10/20.
//

import Foundation
import UIKit

extension BookingDetailVC: UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate {

    func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .themeBackground
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(BookingDetailTblCell.nib()
            , forCellReuseIdentifier: BookingDetailTblCell.name)
        tableView.reloadData {
            
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count: Int = 0
        switch tableView {
        case self.tblForCard1:
            count =  self.arrForTbl1.count

        case self.tblForCard2:
            count =  self.arrForTbl2.count

        case self.tblForCard3:
            count = self.arrForTbl3.count

        default:
            print("")
        }
        return count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


        var data: (title:String, detail:String) = ("","")

        switch tableView {
        case self.tblForCard1:
            data =  self.arrForTbl1[indexPath.row]

        case self.tblForCard2:
            data =  self.arrForTbl2[indexPath.row]

        case self.tblForCard3:
            data = self.arrForTbl3[indexPath.row]

        default:
            print("")
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: BookingDetailTblCell.name, for: indexPath) as?  BookingDetailTblCell
        cell?.layoutIfNeeded()
        cell?.setData(data: data)
        cell?.layoutIfNeeded()
        return cell!

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
