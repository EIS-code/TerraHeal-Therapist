//
//  SideVC.swift
//  Dumparoo
//  Created by Jaydeep Vyas on 03/05/19.
//  Copyright © 2019 Jaydeepvyas. All rights reserved.
//

import UIKit

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
        SideMenuItem.init(id: SideMenu.Notifications, image: "", isVerticle: false),
    ]

    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.lblMenu.setText("MENU_TITLE".localized())
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
extension SideVC: PinterestLayoutDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
        return (collectionView.bounds.width/4.0)
        /*let heightSizes =  [(collectionView.bounds.height/3.5),(collectionView.bounds.height/7)]
         return CGFloat(heightSizes[arrForMenu[indexPath.row].isVerticle ? 0 : 1])*/


    }
}
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
                self.openQuitCollaboration()
                break
            case .SuggesionAndComplaints:
                Common.appDelegate.loadSuggestionVC(navigaionVC: baseVC)
                break
            case .SuspendCollaboration:
                self.openSuspendCollaboration()
                break
            case .TakeBreak:
                self.openTimeBreakDialog()
                break
            }
        }

    }

    func openSuspendCollaboration(index:Int = 0) {
        let alert: CustomTextViewDialog = CustomTextViewDialog.fromNib()
        alert.initialize(title:SideMenu.SuspendCollaboration.name()
                         , placeholder: "DIALOG_SUSPEND_COLLABORATION_TYPE_REASON_HERE".localized(), data: arrForMenu[index].value, buttonTitle: "DIALOG_SUSPEND_COLLABORATION_BTN_REQUEST".localized(), cancelButtonTitle: "BTN_SKIP".localized())
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
            if description.isEmpty() {
                Common.showAlert(message: "DIALOG_VALIDATION_SUSPEND_COLLABORATION_MSG".localized())
            } else {
                self.wsSuspendCollaboration(reason: description)
            }
        }
    }

    func openQuitCollaboration(index:Int = 0) {
        let alert: CustomTextViewDialog = CustomTextViewDialog.fromNib()
        alert.initialize(title: SideMenu.QuitColobration.name(),
                         placeholder: "DIALOG_QUIT_COLLABORATION_TYPE_REASON_HERE".localized(),
                         data: "",
                         buttonTitle: "DIALOG_QUIT_COLLABORATION_BTN_REQUEST".localized(),
                         cancelButtonTitle: "BTN_SKIP".localized())
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
            if description.isEmpty() {
                Common.showAlert(message: "DIALOG_VALIDATION_QUIT_COLLABORATION_MSG".localized())
            } else {
                self.wsQuitCollaboration(reason: description)
            }
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
            [weak alert, weak self] (request) in
            guard let self = self else { return } ; print(self)
            alert?.dismiss()
            self.wsTimeBreak(request: request)
        }
    }
}



//MARK: Web Service Call

extension SideVC {
    func wsQuitCollaboration(reason:String) {
        MenuWebService.requestQuitCollaboration(params: MenuWebService.RequestQuitCollaboration.init(reason: reason)) { (response) in
            if ResponseModel.isSuccess(response: response, withSuccessToast: true, andErrorToast: true) {

            }
        }
    }
    func wsSuspendCollaboration(reason:String) {
        MenuWebService.requestSuspendCollaboration(params: MenuWebService.RequestSuspendCollaboration.init(reason: reason)) { (response) in
            if ResponseModel.isSuccess(response: response, withSuccessToast: true, andErrorToast: true) {
            }
        }
    }

    func wsTimeBreak(request:MenuWebService.RequestTakeBreak) {
        MenuWebService.requestTakeBreak(params: request) { (response) in
            if ResponseModel.isSuccess(response: response, withSuccessToast: true, andErrorToast: true) {
            }
        }
    }

}
