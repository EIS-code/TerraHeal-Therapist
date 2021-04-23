//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit
import Mantis


class ManageIdPassportVC: BaseVC {
    
    @IBOutlet weak var btnCancel: CancelButton!
    @IBOutlet weak var tableView: UITableView!

    var documentID: String = ""
    var selectedDocType: DocumentType = .AddressProof
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
        self.setNavigationTitle(title: "MANAGE_EXPERIENCE_TITLE".localized())
        self.lblTitle?.textAlignment = .left
        self.lblTitle?.setFont(name: FontName.Bold, size: FontSize.large)

    }
    
    @IBAction func btnCancelTapped(_ sender: Any) {
         self.popVC()
    }
    
    @IBAction func btnSubmitTapped(_ sender: Any) {
        self.openPhotoPicker()
    }
    
    func updateUI() {
        self.arrForData.removeAll()
        if let frontDocument =  appSingleton.user.documents.first(where: { (document) -> Bool in
            document.type == DocumentType.IdentityProofFront.rawValue
        }) {
            self.arrForData.append(frontDocument)
        } else {
            let document = Document.init(fromDictionary: [:])
            document.type = DocumentType.IdentityProofFront.rawValue
            self.arrForData.append(document)
        }
        if let backDocument =  appSingleton.user.documents.first(where: { (document) -> Bool in
            document.type == DocumentType.IdentityProofBack.rawValue
        })  {
            self.arrForData.append(backDocument)
        } else {
            let document = Document.init(fromDictionary: [:])
            document.type = DocumentType.IdentityProofBack.rawValue
            self.arrForData.append(document)
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
        }
        photoPickerAlert.onBtnDoneTapped = { [weak photoPickerAlert, weak self] in
            photoPickerAlert?.dismiss()
            guard let self = self else { return } ; print(self)
        }
        photoPickerAlert.onBtnCameraTapped = { [weak photoPickerAlert, weak self] (doc) in
            photoPickerAlert?.dismiss()
            guard let self = self else { return } ; print(self)
            Common.appDelegate.openImageCropper(vc: self, image: doc.image)
        }
        photoPickerAlert.onBtnGallaryTapped = { [weak photoPickerAlert, weak self] (doc) in
            photoPickerAlert?.dismiss()
            guard let self = self else { return } ; print(self)
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


extension ManageIdPassportVC: UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate {
    
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

        cell?.lblName.setText(arrForData[indexPath.row].getDocumentType().name())
        if arrForData[indexPath.row].id.isEmpty() {
            cell?.btnDelete.isHidden = true
            cell?.imgDocument.image = ImageAsset.getImage(ImageAsset.Placeholder.uploadDoc)
        } else {
            cell?.setData(data: arrForData[indexPath.row])
            cell?.btnDelete.isHidden = false
            cell?.btnDelete.tag = indexPath.row
            cell?.btnDelete.addTarget(self, action: #selector(removeDocument), for: .touchUpInside)
        }
        cell?.layoutIfNeeded()
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if arrForData[indexPath.row].id.isEmpty() {
            self.selectedDocType = self.arrForData[indexPath.row].getDocumentType()
            self.openPhotoPicker()
        }
    }
    
}
extension ManageIdPassportVC: CropViewControllerDelegate {

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

extension ManageIdPassportVC {
    func openConfirmationDialog(index:Int) {
        let alert: CustomAlertConfirmation = CustomAlertConfirmation.fromNib()
        alert.initialize(title: "DIALOG_REMOVE_DOCUMENT".localized(), message: "DIALOG_REMOVE_DOCUMENT_MESSAGE".localized(), buttonTitle: "DIALOG_REMOVE_DOCUMENT_BTN_OK".localized(), cancelButtonTitle: "DIALOG_REMOVE_DOCUMENT_BTN_CANCEL".localized())
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
