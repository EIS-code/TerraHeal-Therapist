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
   }


   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return arrForData.count
   }

   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExchangeOfferRequestTblCell.name, for: indexPath) as?  ExchangeOfferRequestTblCell
           cell?.parentVC = self
           cell?.setData(data: arrForData[indexPath.row])
           return cell!


   }

   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       tableView.deselectRow(at: indexPath, animated: true)


   }

   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return UITableView.automaticDimension
       
   }
}
