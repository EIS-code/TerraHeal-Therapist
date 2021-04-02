//
//  KycInfoTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

class SessionTypeTblSection: UITableViewHeaderFooterView {
    
    @IBOutlet weak var vwForBg: UIView!
    @IBOutlet weak var ivForSessionType: UIImageView!
    @IBOutlet weak var lblSectionTitle: ThemeLabel!
    @IBOutlet weak var btnSelectSection: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblSectionTitle.setFont(name: FontName.Regular, size: FontSize.regular)
        self.contentView.backgroundColor = UIColor.themeBackground
        self.vwForBg.setRound(withBorderColor: .clear, andCornerRadious: 7.0, borderWidth: 1.0)
    }


    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
   
    
}

