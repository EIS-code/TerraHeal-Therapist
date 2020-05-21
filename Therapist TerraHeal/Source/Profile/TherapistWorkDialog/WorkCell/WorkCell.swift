//
//  OngoingJobCell.swift
//  Dumparoo
//  Created by Jaydeep Vyas on 03/06/19.
//  Copyright © 2019 Jaydeepvyas. All rights reserved.
//

import UIKit

class WorkCell: CollectionCell {
    
    @IBOutlet weak var ivForPayment: UIImageView!
    @IBOutlet weak var lblName: ThemeLabel!
    @IBOutlet weak var vwContent: UIView!
    @IBOutlet weak var ivSelected: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
        self.contentView.backgroundColor = UIColor.clear
        self.lblName.textColor = UIColor.themePrimary
        self.lblName.setFont(name: FontName.Ovo, size: FontSize.label_18)
        //self.vwContent.setRound(withBorderColor: UIColor.clear, andCornerRadious: 10.0, borderWidth: 1.0)


    }


    func setData(_ data: MassageDetail, _ idxPath: IndexPath) {
        self.lblName.text = data.name
        self.updateStatus(isConnected: data.isSelected)
    }

    func updateStatus(isConnected:Bool) {
        self.ivForPayment.isHidden = true
        self.ivSelected.isHidden = !isConnected
    }

}

