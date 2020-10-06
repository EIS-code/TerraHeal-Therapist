//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

struct NewsTblCellDetail {
    var header:String = "Lorem ipsum"
    var subHeader:String = "Lorem ipsum dolor sit amet"
    var date: Double = Date().millisecondsSince1970
    var isRead: Bool = false
    var details: String = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor. elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet."
}

class NewsTblCell: TableCell {

    @IBOutlet weak var lblHeader: ThemeLabel!
    @IBOutlet weak var lblSubHeader: ThemeLabel!
    @IBOutlet weak var lblDetail: ThemeVerticalAlignLabel!
    @IBOutlet weak var lblDate: ThemeLabel!
    @IBOutlet weak var lblRead: ThemeLabel!
    @IBOutlet weak var vwCellBg: UIView!
    @IBOutlet weak var btnCheck: JDCheckboxButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblHeader?.setFont(name: FontName.SemiBold, size: FontSize.subHeader)
        self.lblSubHeader?.setFont(name: FontName.Light, size: FontSize.detail)
        self.lblDetail?.setFont(name: FontName.Regular, size: FontSize.regular)
        self.lblDate?.setFont(name: FontName.Light, size: FontSize.detail)
        self.lblRead?.setFont(name: FontName.Light, size: FontSize.small)
    
    }

    func setData(data: NewsTblCellDetail ) {
        self.lblHeader?.text = data.header
        self.lblSubHeader?.text = data.subHeader
        self.lblDetail?.text = data.details
        self.lblDate?.text = Date.milliSecToDate(milliseconds: data.date, format: DateFormat.DD_MM_YYYY)
        self.lblRead?.text = "Read"
        self.btnCheck.isSelected = data.isRead
    }

    override func layoutSubviews() {
        super.layoutSubviews()
       
    }
    @IBAction func btnCheckBoxTapped(_ sender: Any) {
        btnCheck.checkboxAnimation {
            print(self.btnCheck.isSelected)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
