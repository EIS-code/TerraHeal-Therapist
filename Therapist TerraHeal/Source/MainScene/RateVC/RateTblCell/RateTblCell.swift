//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit


struct RateTblCellDetail {
    var title: String = ""
    var rate: Float = 0.5
    var isSelected: Bool = false
}

class RateTblCell: TableCell {

    @IBOutlet weak var lblCellTitle: ThemeLabel!
    @IBOutlet weak var vwRating: RatingView!

   
    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblCellTitle.setFont(name: FontName.SemiBold, size: FontSize.subHeader)
    }

    func setData(data: RateTblCellDetail ) {
        self.lblCellTitle.setText(data.title)
        self.vwRating.rating = data.rate
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
