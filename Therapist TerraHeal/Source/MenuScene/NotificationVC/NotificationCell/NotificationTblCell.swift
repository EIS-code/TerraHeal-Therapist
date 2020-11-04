//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit


class NotificationTblCell: TableCell {

    @IBOutlet weak var lblMessage: ThemeLabel!
    @IBOutlet weak var vwCellBg: UIView!
    @IBOutlet weak var imgSelected: UIImageView!
    @IBOutlet weak var ivIcon: UIImageView!
    @IBOutlet weak var lblDate: ThemeLabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblMessage?.setFont(name: FontName.Bold, size: FontSize.subHeader)
        self.lblDate?.setFont(name: FontName.Bold, size: FontSize.detail)
        self.vwCellBg?.setRound(withBorderColor: .clear, andCornerRadious: JDDeviceHelper.offseter(offset: 15.0), borderWidth: 1.0)
    
    }

    func setData(data: NotificationDetail ) {
        self.lblMessage.setText(data.message)
        self.lblDate.setText(data.date)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
