//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit


struct MyRateTblCellDetail {
    var title: String = ""
    var rate: Float = 0.5
    var isSelected: Bool = false
}

class MyRateTblCell: TableCell {

    @IBOutlet weak var lblCellTitle: ThemeLabel!
    @IBOutlet weak var vwRating: RatingView!
    @IBOutlet weak var vwCellBg: UIView!

   
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.lblCellTitle.setFont(name: FontName.SemiBold, size: FontSize.subHeader)
    }

    func setData(data: MyRateTblCellDetail ) {
        self.lblCellTitle.setText(data.title)
        self.vwRating.rating = data.rate
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        vwCellBg.setRound(withBorderColor: .clear, andCornerRadious: JDDeviceHelper.offseter(offset: 15.0), borderWidth: 1.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
