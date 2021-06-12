//  EvolutionDemo
//
//  Created by Jaydeep on 19/03/20.
//  Copyright © 2020 com.evolutiondemo. All rights reserved.
//
import UIKit
import Foundation




struct AvailabilityCellDetail {
    var shiftName:String = ""
    var shiftTime:String = ""
    var availabilityStatus: AvailabilityStatus = .Available
    var isSelected: Bool = false
    init(shift:Shift) {
        self.shiftName =  "shift - " + shift.shiftId
        let sDate = Date.init(milliseconds: shift.from.toDouble)
        let eDate = Date.init(milliseconds: shift.to.toDouble)
        self.shiftTime = sDate.toString(format: "hh:mm") + " - " + eDate.toString(format: "hh:mm")

    }
}

class AvailabilityCell: CollectionCell {
    
    @IBOutlet weak var lblCellTitle: ThemeLabel!
    @IBOutlet weak var vwForCellBg: UIView!
    var data: AvailabilityCellDetail!

    override func awakeFromNib()  {
        super.awakeFromNib()
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        lblCellTitle.setFont(name: FontName.SemiBold, size: FontSize.regular)
    }
    
    func setData(data:AvailabilityCellDetail) {
        self.data = data
        self.lblCellTitle.setText(data.shiftName)
        switch  data.availabilityStatus {
        case .Available:
            vwForCellBg.backgroundColor = .init(hex: "#33B199")
        default:
            vwForCellBg.backgroundColor = .init(hex: "#FD3A58")
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        vwForCellBg.setRound(withBorderColor: .clear, andCornerRadious: JDDeviceHelper.offseter(offset: 10), borderWidth: 1.0)
    }

}
