//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

class WorkingScheduleTblCell: TableCell {

    @IBOutlet weak var lblDetails: ThemeLabel!
    @IBOutlet weak var vwBg: UIView!
    @IBOutlet weak var ivDocument: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblDetails?.setFont(name: FontName.SemiBold, size: FontSize.subHeader)

    }

    func setData(data: UploadDocumentDetail ) {
        self.lblDetails.text = data.name
        //self.ivDocument?.image = data.image
        //self.btnDelete.isHidden = !data.isCompleted
       
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
