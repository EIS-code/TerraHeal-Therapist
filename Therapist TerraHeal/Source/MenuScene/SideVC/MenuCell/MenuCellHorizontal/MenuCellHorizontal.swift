//  EvolutionDemo
//
//  Created by Jaydeep on 19/03/20.
//  Copyright © 2020 com.evolutiondemo. All rights reserved.
//
import UIKit
import Foundation



struct SideMenuItem {
    var id: SideMenu = SideMenu.QuitColobration
    var image: String = ""
    var isVerticle: Bool = true
    var value:String = ""
}
enum SideMenu: String {
    case QuitColobration = "0"
    case SuggesionAndComplaints = "1"
    case SuspendCollaboration = "2"
    case TakeBreak = "3"
    case Notifications = "4"

    func name() -> String {
        switch self {
        case .QuitColobration:
            return "MENU_QUIT_COLLABORATION".localized()
        case .SuggesionAndComplaints:
            return "MENU_SUGGESTIONS_AND_COMPLAINTS".localized()
        case .SuspendCollaboration:
            return "MENU_SUSPEND_COLLABORATION".localized()
        case .TakeBreak:
            return "MENU_TAKE_BREAK".localized()
        case .Notifications:
            return "MENU_NOTIFICATIONS".localized()
        }
    }

    func image() -> String {
        switch self {
        case .QuitColobration:

            return ImageAsset.SideMenu.quitCollaboration
        case .SuggesionAndComplaints:
            return ImageAsset.SideMenu.suggestionCollaboration
        case .SuspendCollaboration:
            return ImageAsset.SideMenu.suspendCollaboration
        case .TakeBreak:
            return ImageAsset.SideMenu.takeBreak
        case .Notifications:
            return ImageAsset.SideMenu.notifications
        }
    }

    func backgroundImage() -> String {
        switch self {
        case .QuitColobration:
            return "MENU_QUIT_COLLABORATION".localized()
        case .SuggesionAndComplaints:
            return "MENU_SUSPEND_COLLABORATION".localized()
        case .SuspendCollaboration:
            return "MENU_SUGGESTIONS_AND_COMPLAINTS".localized()
        case .TakeBreak:
            return "MENU_TAKE_BREAK".localized()
        case .Notifications:
            return "MENU_NOTIFICATIONS".localized()
        }
    }
}

class MenuCellHorizontal: CollectionShadowCell {

    @IBOutlet weak var lblTitle: ThemeLabel!
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
        self.lblTitle.setText(menuDetail.id.name())
        self.ivMenu.image = UIImage.init(named: menuDetail.id.image())
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.vwCellBg?.setRound(withBorderColor: .clear, andCornerRadious: self.radius, borderWidth: 1.0)
        self.addShadow(viewForShadow: self.vwCellBg)


    }
}




