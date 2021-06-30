//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit
import Mantis

class ManageDocumentVC: BaseVC {
    
    @IBOutlet weak var btnCancel: CancelButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var vwForEmpty: UIView!
    @IBOutlet weak var vwBg: UIView!
    @IBOutlet weak var lblEmptyTitle: ThemeLabel!
    @IBOutlet weak var lblEmptyMsg: ThemeLabel!
    @IBOutlet weak var btnSubmit: FilledRoundedButton!
    @IBOutlet weak var lblDocumentId: ThemeLabel!
    var documentID: String = ""
    var selectedDocType: DocumentType = DocumentType.init(rawValue: "") ?? .AddressProof
    var arrForData: [Document] = []
    var selectedDocument: UploadDocumentDetail? = nil
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
        self.setNavigationTitle(title: self.selectedDocType.name())
        self.lblTitle?.textAlignment = .left
        self.lblTitle?.setFont(name: FontName.Bold, size: FontSize.large)
        self.lblEmptyTitle.setFont(name: FontName.Bold, size: FontSize.subHeader)
        self.lblEmptyMsg.setFont(name: FontName.Regular, size: FontSize.detail)
        self.lblEmptyTitle.text = "DOCUMENT_EMPTY_TITLE".localized()
        self.lblEmptyMsg.text = "DOCUMENT_EMPTY_MSG".localized()
        self.btnSubmit?.setTitle("MANAGE_DOCUMENT_BTN_ADD_NEW".localized(), for: .normal)
        self.lblDocumentId.setFont(name: FontName.Regular, size: FontSize.detail)
        self.updateUI()
    }
    
    @IBAction func btnCancelTapped(_ sender: Any) {
        self.popVC()
    }
    
    @IBAction func btnSubmitTapped(_ sender: Any) {
        self.view.tempDisable()
        self.btnSubmit.isEnabled = false
        if self.selectedDocType == .PersonalExperience {
            self.openExpriencePicker()
        } else {
            self.openPhotoPicker()
        }
    }
    
    func updateUI()  {
        let documents =  appSingleton.user.documents.filter { (document) -> Bool in
            document.type == self.selectedDocType.rawValue
        }
        if documents.isEmpty {
            self.tableView.isHidden = true
            self.vwForEmpty.isHidden = false
        } else {

            self.arrForData.removeAll()
            for doc in documents {
                self.arrForData.append(doc)
            }
            self.tableView.isHidden = false
            self.vwForEmpty.isHidden = true
        }
        self.tableView.reloadData()
    }



    func openPhotoPicker() {
        
        let photoPickerAlert: CustomDocumentPicker = CustomDocumentPicker.fromNib()
        photoPickerAlert.isForDocument = true
        photoPickerAlert.initialize(title: "ADD_NEW_DOCUMENT_TITLE".localized())
        photoPickerAlert.show(animated: true)
        photoPickerAlert.onBtnCancelTapped = { [weak photoPickerAlert, weak self] in
            photoPickerAlert?.dismiss()
            guard let self = self else { return } ; print(self)
            self.btnSubmit.isEnabled = true
        }
        photoPickerAlert.onBtnDoneTapped = { [weak photoPickerAlert, weak self] in
            photoPickerAlert?.dismiss()
            guard let self = self else { return } ; print(self)
            self.btnSubmit.isEnabled = true
        }
        photoPickerAlert.onBtnCameraTapped = { [weak photoPickerAlert, weak self] (doc) in
            photoPickerAlert?.dismiss()
            guard let self = self else { return } ; print(self)
            self.btnSubmit.isEnabled = true
            Common.appDelegate.openImageCropper(vc: self, image: doc.image)
        }
        photoPickerAlert.onBtnGallaryTapped = { [weak photoPickerAlert, weak self] (doc) in
            photoPickerAlert?.dismiss()
            guard let self = self else { return } ; print(self)
            self.btnSubmit.isEnabled = true
            if doc.name.isImage() {
                Common.appDelegate.openImageCropper(vc: self, image: doc.image)
            } else {
                self.selectedDocument = UploadDocumentDetail.init()
                self.selectedDocument?.paramName = self.selectedDocType.paramName()
                self.selectedDocument?.image = nil
                self.selectedDocument?.data = doc.data
                self.wsUpdateDocument()
            }

        }
    }
    

}


extension ManageDocumentVC: UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate {
    
    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.register(ManageDocumentTblCell.nib()
                           , forCellReuseIdentifier: ManageDocumentTblCell.name)
        tableView.tableFooterView = UIView()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrForData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ManageDocumentTblCell.name, for: indexPath) as?  ManageDocumentTblCell
        cell?.layoutIfNeeded()
        cell?.setData(data: arrForData[indexPath.row])
        cell?.btnDelete.tag = indexPath.row
        cell?.btnDelete.addTarget(self, action: #selector(removeDocument), for: .touchUpInside)
        cell?.layoutIfNeeded()
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ManageDocumentVC: CropViewControllerDelegate {
    func openExpriencePicker() {
        let photoPickerAlert: ExperienceDialog = ExperienceDialog.fromNib()
        photoPickerAlert.initialize(title: "DIALOG_EXPERIENCE_TITLE".localized(), placeholder: "DIALOG_EXPERIENCE_PLACEHOLDER".localized(), data: "", buttonTitle: "DIALOG_EXPERIENCE_BTN_SAVE".localized(), cancelButtonTitle: "BTN_CANCEL".localized())
        photoPickerAlert.show(animated: true)
        photoPickerAlert.onBtnCancelTapped = { [weak photoPickerAlert, weak self] in
            photoPickerAlert?.dismiss()
             guard let self = self else { return } ; print(self)
            self.btnSubmit.isEnabled = true
        }
        photoPickerAlert.onBtnDoneTapped = { [weak photoPickerAlert, weak self] (doc,description) in
            photoPickerAlert?.dismiss()
            guard let self = self else { return } ; print(self)
            self.btnSubmit.isEnabled = true
            Common.appDelegate.openImageCropper(vc: self, image: doc.image)
        }
    }

    func cropViewControllerDidCrop(_ cropViewController: CropViewController, cropped: UIImage, transformation: Transformation) {
        do {
            try cropped.compressImage(100, completion: { (image, compressRatio) in
                print(image.size)
                self.selectedDocument = UploadDocumentDetail.init()
                self.selectedDocument?.paramName = self.selectedDocType.paramName()
                self.selectedDocument?.image = image
                self.selectedDocument?.data = image.sd_imageData(as: .JPEG)
                self.wsUpdateDocument()
            })
        } catch {
            print("Error")
        }
        self.navigationController?.popViewController(animated: true)
    }

    func cropViewControllerDidCancel(_ cropViewController: CropViewController, original: UIImage) {
        self.navigationController?.popViewController(animated: true)

    }
}
//MARK:- Web Service Calls

extension ManageDocumentVC {

    func openConfirmationDialog(index:Int) {

        let alert: CustomAlertConfirmation = CustomAlertConfirmation.fromNib()

        alert.initialize(title: "Remove Document", message: "Are you you want to delete this address",buttonTitle: "Ok", cancelButtonTitle: "Cancel")
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            guard let self = self else {return}; print(self)
            alert?.dismiss()
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self]  in
            guard let self = self else {return}; print(self)
            alert?.dismiss()
            self.documentID = self.arrForData[index].id
            self.wsRemoveDocument()
        }
    }
    @objc func removeDocument(button: UIButton) {
        self.openConfirmationDialog(index: button.tag)
    }

    func wsUpdateDocument() {
        Loader.showLoading()
        AppWebApi.updateDocuments(documents: [self.selectedDocument!]) { (response) in
            Loader.hideLoading()
            if ResponseModel.isSuccess(response: response, withSuccessToast: false, andErrorToast: true) {
                let user = response.data
                PreferenceHelper.shared.setUserId(user.id)
                appSingleton.user = user
                Singleton.saveInDb()
                self.updateUI()
            }
        }
    }
    func wsRemoveDocument() {
        Loader.showLoading()
        AppWebApi.removeDocument(params: UserWebService.RequestRemoveDocument.init(document_id: self.documentID)) { (response) in
            Loader.hideLoading()
            if ResponseModel.isSuccess(response: response, withSuccessToast: false, andErrorToast: true) {
                if let index = appSingleton.user.documents.firstIndex(where: { (data) -> Bool in
                    return data.id == self.documentID
                }) {
                    appSingleton.user.documents.remove(at: index)
                }
                Singleton.saveInDb()
                self.updateUI()
            }
        }
    }
}
