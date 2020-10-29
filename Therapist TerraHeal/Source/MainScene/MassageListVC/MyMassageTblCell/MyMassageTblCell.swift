//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

struct MyMassageTblCellDetail{
    var title: String = ""
    var isSelected: Bool = false
}
class MyMassageTblCell: TableCell {

    @IBOutlet weak var lblName: ThemeLabel!
    @IBOutlet weak var vwCollapse: UIView!
    @IBOutlet weak var btnAction: ThemeButton!
    @IBOutlet weak var ivForplace: UIImageView!
    @IBOutlet weak var ivCellChecked: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        self.lblName?.setFont(name: FontName.Bold, size: FontSize.subHeader)
        self.vwCollapse?.setRound(withBorderColor: .clear, andCornerRadious: 15.0, borderWidth: 1.0)
        self.btnAction?.setFont(name: FontName.SemiBold, size: FontSize.header)
        self.vwCollapse.backgroundColor = .white
    }

    func setData(data: MyMassageTblCellDetail ) {
        self.lblName.setText(data.title)
        self.ivCellChecked.isHidden = !data.isSelected
       // self.vwBar.backgroundColor =  data.isSelected ? UIColor.themeBookingType1 : UIColor.themeBookingType2
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.vwCollapse?.setRound(withBorderColor: .clear, andCornerRadious: 15.0, borderWidth: 1.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}

