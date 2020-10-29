//
//  KycInfoTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

class WorkingScheduleTblSection: UITableViewHeaderFooterView {
    
    @IBOutlet weak var lblTitle: ThemeLabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblTitle.setFont(name: FontName.SemiBold, size: FontSize.header)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

}

