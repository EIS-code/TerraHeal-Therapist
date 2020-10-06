//
//  SideVC.swift
//  Dumparoo
//  Created by Jaydeep Vyas on 03/05/19.
//  Copyright © 2019 Jaydeepvyas. All rights reserved.
//

import UIKit

struct SideMenuItem {
    var id: SideMenu = SideMenu.News
    var image: String = ""
    var isVerticle: Bool = true
    var value:String = ""
}
enum SideMenu: String {
    case QuitColobration = "0"
    case SuggesionAndComplaints = "1"
    case SuspendCollaboration = "2"
    case TakeBreak = "3"
    case News = "4"
    case Notifications = "5"

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
        case .News:
            return "MENU_NEWS".localized()
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
        case .News:
            return ImageAsset.SideMenu.news
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
        case .News:
            return "MENU_NEWS".localized()
        case .Notifications:
            return "MENU_NOTIFICATIONS".localized()
        }
    }
}

class SideVC: BaseVC {

    @IBOutlet weak var lblMenu: ThemeLabel!
    @IBOutlet weak var btnClose: CancelButton!
    @IBOutlet weak var cvForMenu: UICollectionView!
    var idxPathSelected: IndexPath = IndexPath(row: -1, section: -1)



    var arrForMenu: [SideMenuItem] = [
        SideMenuItem.init(id: SideMenu.QuitColobration, image: "", isVerticle: false),
        SideMenuItem.init(id: SideMenu.SuggesionAndComplaints, image: "", isVerticle: false),
        SideMenuItem.init(id: SideMenu.SuspendCollaboration, image: "", isVerticle: false),
        SideMenuItem.init(id: SideMenu.TakeBreak, image: "", isVerticle: false),
        SideMenuItem.init(id: SideMenu.News, image: "", isVerticle: false),
        SideMenuItem.init(id: SideMenu.Notifications, image: "", isVerticle: false),
    ]

    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.lblMenu.text = "MENU_TITLE".localized()
        //self.lblMenu?.font = FontHelper.font(name: FontName.Bold, size: FontSize.large)
        self.lblMenu.setFont(name: FontName.Bold, size: FontSize.large)
        self.setupCollectionView()
    }

    @IBAction func btnCloseTapped(_ sender: Any) {
        self.revealViewController()?.revealLeftView()
        //SideVC.shared.hide()
    }
}

// MARK: -

extension UITableView {

    func setBackgroundImage(image:UIImage?) {
        if let img = image {
            let backgroundImage = UIImageView(image: img)
            backgroundImage.contentMode = UIView.ContentMode.scaleToFill
            backgroundImage.clipsToBounds = false
            self.backgroundColor = UIColor.clear
            self.backgroundView = backgroundImage
        }
    }

}


// MARK: - CollectionView Methods
extension SideVC:  UICollectionViewDelegate, UICollectionViewDataSource {

    private func setupCollectionView() {
        cvForMenu?.backgroundColor = UIColor.white
        cvForMenu?.isUserInteractionEnabled = true
        cvForMenu?.isPagingEnabled = true
        cvForMenu?.delegate = self
        cvForMenu?.dataSource = self
        cvForMenu?.showsVerticalScrollIndicator = false
        cvForMenu?.showsHorizontalScrollIndicator = false

        if let layout = cvForMenu?.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
        cvForMenu?.register(MenuCellVerticle.nib()
            , forCellWithReuseIdentifier: MenuCellVerticle.name)
        cvForMenu?.register(MenuCellHorizontal.nib()
            , forCellWithReuseIdentifier: MenuCellHorizontal.name)
    }

    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrForMenu.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = arrForMenu[indexPath.row]
        if data.isVerticle {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCellVerticle.name, for: indexPath) as! MenuCellVerticle
            cell.layoutIfNeeded()
            cell.setData(menuDetail: data)
            cell.layoutIfNeeded()
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCellHorizontal.name, for: indexPath) as! MenuCellHorizontal
            cell.layoutIfNeeded()
            cell.setData(menuDetail: data)
            cell.layoutIfNeeded()
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if  let baseVC = self.revealViewController()?.leftViewController as? NC{
            switch self.arrForMenu[indexPath.row].id {
            case SideMenu.Notifications:
                Common.appDelegate.loadNotificationVC(navigaionVC: baseVC)
            case .QuitColobration:
                self.openTextViewPicker(index: indexPath.item)
                break
            case .SuggesionAndComplaints:
                //self.openTextViewPicker(index: indexPath.item)
                Common.appDelegate.loadSuggestionVC(navigaionVC: baseVC)
                break
            case .SuspendCollaboration:
                self.openTextViewPicker(index: indexPath.item)
                break
            case .TakeBreak:
                self.openTimeBreakDialog()
                break
            case .News:
                Common.appDelegate.loadNewsVC(navigaionVC: self.navigationController)
                //Common.appDelegate.loadNotificationVC(navigaionVC: baseVC)
                break
            }
        }

    }

    func openTextViewPicker(index:Int = 0) {
        let alert: CustomTextViewDialog = CustomTextViewDialog.fromNib()
        alert.initialize(title: arrForMenu[index].id.name()
            , data: arrForMenu[index].value, buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_SKIP".localized())
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            guard let self = self else {return}; print(self)
            alert?.dismiss()
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self] (description) in
            guard let self = self else { return } ; print(self)
            alert?.dismiss()
            self.arrForMenu[index].value = description
        }
    }

    func openTimeBreakDialog() {
        let alert: TimeBreakDialog = TimeBreakDialog.fromNib()
        alert.initialize(title: "TIME_BREAK_DIALOG_TITLE".localized(), buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_SKIP".localized())
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            guard let self = self else {return}; print(self)
            alert?.dismiss()
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self] (description) in
            guard let self = self else { return } ; print(self)
            alert?.dismiss()
        }
    }


}

extension SideVC: PinterestLayoutDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
        return (collectionView.bounds.width/4.0)
        /*let heightSizes =  [(collectionView.bounds.height/3.5),(collectionView.bounds.height/7)]
         return CGFloat(heightSizes[arrForMenu[indexPath.row].isVerticle ? 0 : 1])*/


    }
}
