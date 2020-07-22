//
//  KycInfoTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

class DocumentTblCell: TableCell {

    @IBOutlet weak var imgChecked: ThemeButton!
    @IBOutlet weak var vwBg: UIView!
    @IBOutlet weak var imgArrow: UIImageView!
    @IBOutlet weak var lblDocName: ThemeLabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblDocName.setFont(name: FontName.Regular, size: FontSize.label_20)
        self.imgChecked.setRound()
        self.vwBg.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
        self.backgroundColor = .clear
        self.backgroundView?.backgroundColor = .clear
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setData(data: UploadDocumentDetail) {
        self.lblDocName.text = data.name
        self.updatedStatus(completed: data.isCompleted)
    }
    
    func updatedStatus(completed:Bool = false) {
        if completed {
            self.imgArrow.isHidden = true
            self.imgChecked.isHidden = false
        } else {
            self.imgArrow.isHidden = false
            self.imgChecked.isHidden = true
        }

    }
    
}
