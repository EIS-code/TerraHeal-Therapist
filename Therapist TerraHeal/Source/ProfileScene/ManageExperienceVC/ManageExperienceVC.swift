//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit


class ManageExperienceVC: BaseVC {
    
    @IBOutlet weak var btnCancel: CancelButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var vwForEmpty: UIView!
    @IBOutlet weak var vwBg: UIView!
    @IBOutlet weak var lblEmptyTitle: ThemeLabel!
    @IBOutlet weak var lblEmptyMsg: ThemeLabel!
    @IBOutlet weak var btnSubmit: FilledRoundedButton!
    @IBOutlet weak var lblDocumentId: ThemeLabel!
    
    var arrForData: [UploadDocumentDetail] = [UploadDocumentDetail.init(id: "0", name: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English."),UploadDocumentDetail.init(id: "1", name: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.")]
    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    private func setup() {
        
        
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialViewSetup()
        self.updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if self.isViewAvailable() {
            self.tableView?.reloadData({
            })
           self.tableView?.contentInset = self.getGradientInset()
        }
    }
        
    private func initialViewSetup() {
        self.setBackground(color: UIColor.themeLightBackground)
        self.setupTableView(tableView: self.tableView)
        self.setNavigationTitle(title: "MANAGE_EXPERIENCE_TITLE".localized())
        self.lblTitle?.textAlignment = .left
        self.lblTitle?.setFont(name: FontName.Bold, size: FontSize.large)
        self.lblEmptyTitle.setFont(name: FontName.Bold, size: FontSize.subHeader)
        self.lblEmptyMsg.setFont(name: FontName.Regular, size: FontSize.detail)
        self.lblEmptyTitle.text = "MANAGE_EXPERIENCE_EMPTY_TITLE".localized()
        self.lblEmptyMsg.text = "MANAGE_EXPERIENCET_EMPTY_MSG".localized()
        self.btnSubmit?.setTitle("MANAGE_EXPERIENCE_BTN_ADD_NEW".localized(), for: .normal)
        self.lblDocumentId.setFont(name: FontName.Regular, size: FontSize.detail)
    }
    
    @IBAction func btnCancelTapped(_ sender: Any) {
         self.popVC()
    }
    
    @IBAction func btnSubmitTapped(_ sender: Any) {
        self.btnSubmit.isEnabled = false
        self.openPhotoPicker()
    }
    
    func updateUI()  {
        if arrForData.isEmpty {
            self.vwForEmpty.isHidden = false
            self.tableView.isHidden = true
        } else {
            self.vwForEmpty.isHidden = true
            self.tableView.isHidden = false
        }
        self.tableView.reloadData()

    }
  
   
   
    func openPhotoPicker() {

        let photoPickerAlert: ExperienceDialog = ExperienceDialog.fromNib()
        photoPickerAlert.initialize(title: "DIALOG_EXPERIENCE_TITLE".localized(), placeholder: "DIALOG_EXPERIENCE_PLACEHOLDER".localized(), data: "", buttonTitle: "DIALOG_EXPERIENCE_BTN_SAVE".localized(), cancelButtonTitle: "BTN_CANCEL".localized())
        photoPickerAlert.show(animated: true)
        photoPickerAlert.onBtnCancelTapped = { [weak photoPickerAlert, weak self] in
            photoPickerAlert?.dismiss()
             guard let self = self else { return } ; print(self)
            self.btnSubmit.isEnabled = true
        }
        photoPickerAlert.onBtnDoneTapped = { [weak photoPickerAlert, weak self] (image,description) in
            photoPickerAlert?.dismiss()
            guard let self = self else { return } ; print(self)
            self.btnSubmit.isEnabled = true
            self.openCropper(image: image.image!)
        }
    }
    
    func openCropper(image: UIImage) {
        let cropper: UIImageCropperVC = UIImageCropperVC.fromNib()
        cropper.cropRatio = 1/1
        cropper.delegate = self
        cropper.picker = nil
        cropper.image = image
        cropper.cancelButtonText = "BTN_CANCEL".localized()
        cropper.view.layoutIfNeeded()
        cropper.modalPresentationStyle = .fullScreen
        DispatchQueue.main.async {
            self.btnSubmit.isEnabled = true
            Common.appDelegate.getTopViewController()?.present(cropper, animated: true, completion: nil)
        }
    }
}


extension ManageExperienceVC: UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate {
    
    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.register(ManageExperienceTblCell.nib()
            , forCellReuseIdentifier: ManageExperienceTblCell.name)
        tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrForData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: ManageExperienceTblCell.name, for: indexPath) as?  ManageExperienceTblCell
        cell?.layoutIfNeeded()
        cell?.setData(data: arrForData[indexPath.row])
        cell?.layoutIfNeeded()
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //self.openNewAddressDialog(index: indexPath.row)
    }
    
}


extension ManageExperienceVC: UIImageCropperProtocol {
    func didCropImage(originalImage: UIImage?, croppedImage: UIImage?) {

        if arrForData.isEmpty {
                self.arrForData.append(UploadDocumentDetail.init(id: "599905", name:"Front Side", image: croppedImage, data: nil, isCompleted: true, paramName: "document_personal_experience"))
        } else {
            self.arrForData.append(UploadDocumentDetail.init(id: "599905", name:"Back Side", image: croppedImage, data: nil, isCompleted: true, paramName: "document_personal_experience"))
        }
        self.updateUI()
    }
    
    //optional
    func didCancel() {
        print("did cancel")
         self.popVC()
        //self.wsUpdateProfile()
    }
}
extension ManageExperienceVC {
    func wsUpdateProfile(request: UserWebService.RequestProfile) {
        Loader.showLoading()
        AppWebApi.updateDocuments(params: UserWebService.RequestProfile.init(), documents: self.arrForData) { (response) in
            Loader.hideLoading()
            if ResponseModel.isSuccess(response: response, withSuccessToast: false, andErrorToast: true) {
                let user = response.data
                PreferenceHelper.shared.setUserId(user.id)
                appSingleton.user = user
                Singleton.saveInDb()
                self.popVC()
            }
        }
    }
}
