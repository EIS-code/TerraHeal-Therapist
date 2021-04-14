//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

struct RadioSelectionTblCellDetail {
    var id:String = ""
    var title:String = ""
    var isSelected:Bool = false
    var indexPath: IndexPath = IndexPath.init(row: -1, section: -1)
}
class RadioSelectionTblCell: TableCell {

    @IBOutlet weak var lblName: ThemeLabel!
    @IBOutlet weak var vwBg: UIView!
    @IBOutlet weak var btnAction: JDRadioButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblName?.setFont(name: FontName.Bold, size: FontSize.header)
        //self.vwBg?.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
      
    }

    func setData(data: RadioSelectionTblCellDetail ) {
        self.lblName.text = data.title
        self.btnAction.isSelected =  data.isSelected
    }

    func setData(data: SessionType ) {
        self.lblName.text = data.type
        self.btnAction.isSelected =  data.isSelected
    }
    func setData(data: Client ) {
        self.lblName.text = data.name
        self.btnAction.isSelected =  data.isSelected
    }
    func setData(data: Massage ) {
        self.lblName.text = data.massageName
        self.btnAction.isSelected =  data.isSelected
    }
    func setData(data: Therapy ) {
        self.lblName.text = data.therapyName
        self.btnAction.isSelected =  data.isSelected
    }
    override func layoutSubviews() {
        super.layoutSubviews()
       // self.vwBg?.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
