//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

class ManageDocumentTblCell: TableCell {

    @IBOutlet weak var lblName: ThemeLabel!
    @IBOutlet weak var btnDelete: FloatingRoundButton!
    @IBOutlet weak var imgDocument: UIImageView!
    @IBOutlet weak var lblDetail: ThemeLabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblName?.setFont(name: FontName.Bold, size: FontSize.header)
        self.btnDelete?.setRound()
    }

    func setData(data: Document ) {
        self.lblName.text = data.getDocumentType().name()
        self.imgDocument.downloadedFrom(link: data.fileName)
        self.lblDetail.setText(data.fileName)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.imgDocument?.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
        self.btnDelete?.setRound()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
