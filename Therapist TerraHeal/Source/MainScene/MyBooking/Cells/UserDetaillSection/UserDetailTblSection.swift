//
//  KycInfoTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

struct UserDetailSectionModel {
    var name:String = "Saurav"
    var age:String = "27"
    var gender:String = "Male"

    init(name: String? = nil, //👈
        age: String? = nil,
        gender: String? = nil) {

        self.name = name ?? ""
        self.age = age ?? ""
        self.gender = gender ?? ""
    }

    
}

class UserDetailTblSection: UITableViewHeaderFooterView {
    
    @IBOutlet weak var lblName: ThemeLabel!
    @IBOutlet weak var lblAge: ThemeLabel!
    @IBOutlet weak var lblGender: ThemeLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblName.setFont(name: FontName.SemiBold, size: FontSize.subHeader)
        self.lblAge.setFont(name: FontName.SemiBold, size: FontSize.subHeader)
        self.lblGender.setFont(name: FontName.SemiBold, size: FontSize.subHeader)
    }

    func setData(data: UserDetailSectionModel) {
        self.lblName.text = data.name
        self.lblAge.text = data.age
        self.lblGender.text = data.gender
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

}

