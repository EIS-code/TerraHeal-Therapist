//  EvolutionDemo
//
//  Created by Jaydeep on 19/03/20.
//  Copyright © 2020 com.evolutiondemo. All rights reserved.
//
import UIKit
import Foundation

class ServiceCltCell: CollectionCell {

    @IBOutlet weak var lblName: ThemeLabel!
    @IBOutlet weak var ivUser: UIImageView!
    @IBOutlet weak var btnFavourite: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.ivUser?.setRound(withBorderColor: .clear, andCornerRadious: JDDeviceHelper.offseter(offset: 10), borderWidth: 1.0)
        self.lblName?.setFont(name: FontName.SemiBold, size: FontSize.regular)
    }

    func setData(data:Service) {
        self.lblName.setText(data.name)
        self.ivUser.downloadedFrom(link: data.image)
        self.btnFavourite.isSelected = data.isSelected
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.ivUser?.layoutIfNeeded()
        self.ivUser?.setRound(withBorderColor: .themeHintText, andCornerRadious: JDDeviceHelper.offseter(offset: 10), borderWidth: 1.0)
    }
    @IBAction func btnFavouriteTapped(_ sender: Any) {
        self.btnFavourite.isSelected.toggle()
    }
}




