//  EvolutionDemo
//
//  Created by Jaydeep on 19/03/20.
//  Copyright © 2020 com.evolutiondemo. All rights reserved.
//
import UIKit
import Foundation

class FreeSpotCltCell: SelectionBorderCollectionCell {

    @IBOutlet weak var lblName: ThemeLabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.lblName?.setFont(name: FontName.SemiBold, size: FontSize.regular)
    }
    func setData(data:FreeSpotCellDetail) {
        self.setData(isSelected: data.isSelected)
        self.lblName.setText(data.slotDetail)
    }
    override func layoutSubviews() {
        super.layoutSubviews()

    }
}




