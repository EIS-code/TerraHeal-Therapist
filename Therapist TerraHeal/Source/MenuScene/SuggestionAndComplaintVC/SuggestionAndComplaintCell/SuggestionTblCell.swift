//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

struct SuggestionTblCellDetail {
    var name:String = ""
    var photo:String = ""
    var designation:String = ""
    var date: Double = Date().millisecondsSince1970
    var type: String = ""
    var details: String = ""
}

class SuggestionTblCell: TableCell {

    @IBOutlet weak var lblName: ThemeLabel!
    @IBOutlet weak var lblDesignation: ThemeLabel!
    @IBOutlet weak var lblDetail: ThemeVerticalAlignLabel!
    @IBOutlet weak var lblDate: ThemeLabel!
    @IBOutlet weak var lblType: ThemeLabel!
    @IBOutlet weak var ivCell: UIImageView!
    @IBOutlet weak var vwCellBg: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblName?.setFont(name: FontName.SemiBold, size: FontSize.subHeader)
        self.lblDesignation?.setFont(name: FontName.Light, size: FontSize.detail)
        self.lblDetail?.setFont(name: FontName.Regular, size: FontSize.regular)
        self.lblDate?.setFont(name: FontName.Light, size: FontSize.detail)
        self.lblType?.setFont(name: FontName.Light, size: FontSize.small)
    
    }

    func setData(data: SuggestionTblCellDetail ) {
        self.lblName?.setText(data.name)
        self.lblDesignation?.setText(data.designation)
        self.lblDetail?.setText(data.details)
        self.lblDate?.setText(Date.milliSecToDate(milliseconds: data.date, format: DateFormat.DD_MM_YYYY))
        self.ivCell.downloadedFrom(link: data.photo)
        self.lblType?.setText(data.type)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.ivCell?.setRound()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
