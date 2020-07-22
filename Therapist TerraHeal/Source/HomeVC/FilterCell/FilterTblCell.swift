//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

struct ImageWithTitle {
    var name:String = ""
    var imageName: String = ""
}
class FilterTblCell: TableCell {


    @IBOutlet weak var ivFilterImage: UIImageView!
    
    @IBOutlet weak var lblName: ThemeLabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        self.selectionStyle = .none
        self.contentView.backgroundColor = .clear
        self.lblName?.setFont(name: FontName.Bold, size: FontSize.label_18)
    }

    func setData(data: ImageWithTitle ) {
        self.lblName.text = data.name
        self.ivFilterImage.image = UIImage.init(named: data.imageName)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
