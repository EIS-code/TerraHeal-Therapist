//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit


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

    func setData(data: NewsWebService.NewsData ) {
        self.lblHeader?.setText(data.title)
        self.lblSubHeader?.setText(data.subTitle)
        self.lblDetail?.setText(data.descriptionField)
        self.lblDate?.setText(Date.milliSecToDate(milliseconds: data.updatedAt.toDouble, format: DateFormat.DD_MM_YYYY))
        self.lblRead?.setText("Read")
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
