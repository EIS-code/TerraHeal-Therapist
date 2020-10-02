//  EvolutionDemo
//
//  Created by Jaydeep on 19/03/20.
//  Copyright © 2020 com.evolutiondemo. All rights reserved.
//
import UIKit
import Foundation



class MenuCellHorizontal: CollectionShadowCell {

    @IBOutlet weak var lblTitle: ThemeLabel!
    @IBOutlet weak var ivBg: UIImageView!
    @IBOutlet weak var ivMenu: UIImageView!
    @IBOutlet weak var vwCellBg: UIView!
    
    override func awakeFromNib()  {
        super.awakeFromNib()
        self.radius = 15.0
        self.shadowProperty.color = UIColor.init(hex: "#00000029")
        self.shadowProperty.opacity = 1.0
        self.shadowProperty.radius = 4.0
        self.shadowProperty.offset = CGSize.init(width: 1.0, height: 0.0)
    }

    func setData(menuDetail:SideMenuItem) {
        self.lblTitle?.setFont(name: FontName.Regular, size: FontSize.detail)
        //self.lblTitle?.font = FontHelper.font(name: FontName.Regular, size: FontSize.detail)
        self.lblTitle.text = menuDetail.id.name()
        self.ivMenu.image = UIImage.init(named: menuDetail.id.image())
        self.ivBg.image = UIImage.init(named: menuDetail.id.backgroundImage())
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.vwCellBg?.setRound(withBorderColor: .clear, andCornerRadious: self.radius, borderWidth: 1.0)
        self.addShadow(viewForShadow: self.vwCellBg)


    }
}




