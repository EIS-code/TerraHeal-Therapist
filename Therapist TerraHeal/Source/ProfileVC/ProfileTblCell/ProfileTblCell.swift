//
//  KycInfoTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

class ProfileTblCell: TableCell {

    @IBOutlet weak var lblName: ThemeLabel!
    @IBOutlet weak var ivHome: UIImageView!
    @IBOutlet weak var btnAction: ThemeButton!
    @IBOutlet weak var vwBg: UIView!
    @IBOutlet weak var vwImgBg: UIView!
    


    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblName?.setFont(name: FontName.Regular, size: FontSize.detail)
        self.btnAction?.setFont(name: FontName.SemiBold, size: FontSize.header)
        //self.btnAction?.setTitle(FontSymbol.next_arrow, for: .normal)
        self.vwImgBg?.setRound()

    }

    func setData(data: ProfileItemDetail ) {
        self.lblName.text = data.type.name()
        self.ivHome.image = UIImage.init(named: data.type.image())
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.vwBg?.layoutIfNeeded()
        self.vwImgBg?.setRound()
        self.vwBg?.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
