//  EvolutionDemo
//
//  Created by Jaydeep on 19/03/20.
//  Copyright © 2020 com.evolutiondemo. All rights reserved.
//
import UIKit
import Foundation

class TimeSlotCltCell: CollectionCell {

    @IBOutlet weak var lblName: ThemeLabel!
    @IBOutlet weak var vwForSelected: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblName?.setFont(name: FontName.Regular, size: FontSize.detail)
    }
    func setData(data:SlotDetail) {
        self.lblName.setText(data.minute)
        if data.isSelected {
            self.vwForSelected.isHidden = false
            self.lblName.textColor = UIColor.themeLightTextColor
        } else {
            self.vwForSelected.isHidden = true
            self.lblName.textColor = UIColor.themeDarkText
        }
        self.vwForSelected?.setRound()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.vwForSelected?.setRound()
    }
}




