//  EvolutionDemo
//
//  Created by Jaydeep on 19/03/20.
//  Copyright © 2020 com.evolutiondemo. All rights reserved.
//
import UIKit
import Foundation




struct BookingDetailCellDetail {
    var title:String = ""
    var value:String = ""
}

class BookingDetailTblCell: CollectionCell {
    
    @IBOutlet weak var lblTitle: ThemeLabel!
    @IBOutlet weak var lblValue: ThemeLabel!
    
    var data: BookingDetailCellDetail!
    var parent: UIViewController? = nil
    
    override func awakeFromNib()  {
        super.awakeFromNib()
        lblTitle.setFont(name: FontName.Bold, size: FontSize.label_22)
        lblValue.setFont(name: FontName.SemiBold, size: FontSize.label_18)
    }
    
    func setData(data:BookingDetailCellDetail) {
        self.data = data
        self.lblTitle.text = data.title
        self.lblValue.text = data.value
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
   
    
}

