//
//  WorkingScheduleVC + TableView.swift
//  Therapist TerraHeal
//
//  Created by Jaydeep Vyas on 27/05/21.
//  Copyright © 2021 Evolution. All rights reserved.
//

import Foundation

extension ExchangeOfferRequestVC: UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate {
    func setupTableView(tableView:  UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(ExchangeOfferRequestTblCell.nib()
                           , forCellReuseIdentifier: ExchangeOfferRequestTblCell.name)
        tableView.tableFooterView = UIView()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.tblVwForData.reloadData {
            }
        }
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrForData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExchangeOfferRequestTblCell.name, for: indexPath) as?  ExchangeOfferRequestTblCell
        cell?.parentVC = self
        cell?.setData(data: arrForData[indexPath.row])
        cell?.btnReject.tag = indexPath.row
        cell?.btnAccept.tag = indexPath.row
        cell?.btnAccept.addTarget(self, action: #selector(btnAcceptTapped(_:)), for: .touchUpInside)
        cell?.btnReject.addTarget(self, action: #selector(btnRejectTapped(_:)), for: .touchUpInside)
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    @IBAction func btnAcceptTapped(_ sender: UIButton) {
        self.wsAcceptRequest(id: arrForData[sender.tag].withShift.shiftId)
    }

    @IBAction func btnRejectTapped(_ sender: UIButton) {
        self.wsRejectRequest(id: arrForData[sender.tag].withShift.shiftId)
    }
}
