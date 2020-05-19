//
//  OngoingJobCell.swift
//  Dumparoo
//  Created by Jaydeep Vyas on 03/06/19.
//  Copyright © 2019 Jaydeepvyas. All rights reserved.
//

import UIKit
// import JDFramework

struct PaymentAccountDetails {
    var id: Int = 0
    var name: String = ""
    var isConnected: Bool = false
    var image:UIImage = UIImage()

}
class PaymetAccountCell: CollectionCell {
    
    @IBOutlet weak var ivForPayment: UIImageView!
    @IBOutlet weak var lblPaymentAccountName: ThemeLabel!

    @IBOutlet weak var vwContent: UIView!
    @IBOutlet weak var vwForConnected: UIView!
    @IBOutlet weak var btnConnect: ThemeButton!
    @IBOutlet weak var lblConnected: ThemeLabel!
    @IBOutlet weak var imgCheck: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
        self.contentView.backgroundColor = UIColor.clear
        self.lblPaymentAccountName.textColor = UIColor.themePrimary
        self.lblPaymentAccountName.setFont(name: FontName.GradDuke, size: FontSize.label_26)
        self.vwContent.setRound(withBorderColor: UIColor.clear, andCornerRadious: 10.0, borderWidth: 1.0)
        self.btnConnect.setRound(withBorderColor: UIColor.clear, andCornerRadious: 10.0, borderWidth: 1.0)
        self.btnConnect.setFont(name: FontName.GradDuke, size: FontSize.button_14)
        self.imgCheck.setRound()

    }


    func setData(_ data: PaymentAccountDetails, _ idxPath: IndexPath) {
        self.lblPaymentAccountName.text = data.name
        self.updateStatus(isConnected: data.isConnected)
    }

    func updateStatus(isConnected:Bool) {
        self.ivForPayment.isHidden = true
        if isConnected {
            self.vwForConnected.isHidden = false
            self.btnConnect.isHidden = true
        } else {
            self.vwForConnected.isHidden = true
            self.btnConnect.isHidden = false
        }
    }

}

