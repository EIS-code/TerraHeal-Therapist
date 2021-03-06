//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit
import Mantis

class ManageSingleDocumentVC: BaseVC {
    
    @IBOutlet weak var btnCancel: CancelButton!
    @IBOutlet weak var btnAddPicture: ThemeButton!
    @IBOutlet weak var vwForDocument: UIView!
    @IBOutlet weak var imgDocument: UIImageView!
    @IBOutlet weak var btnDeleteDocument: UIButton!


    var selectedDocType: DocumentType = DocumentType.init(rawValue: "") ?? .AddressProof
    var selectedDocument: UploadDocumentDetail? = nil
    var documentID:String = ""
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

    }
        
    private func initialViewSetup() {
        self.setBackground(color: UIColor.themeLightBackground)
        self.setNavigationTitle(title: self.selectedDocType.name())
        self.lblTitle?.textAlignment = .left
        self.lblTitle?.setFont(name: FontName.Bold, size: FontSize.large)

    }
    func updateUI() {
        if let document = appSingleton.user.documents.first(where: { (document) -> Bool in
            document.type == self.selectedDocType.rawValue
        }) {
            self.documentID = document.id
            self.imgDocument.downloadedFrom(link: document.fileName)
            self.btnAddPicture.isHidden = true
            self.btnDeleteDocument.isHidden = false
        } else {
            self.imgDocument.image = ImageAsset.getImage(ImageAsset.Placeholder.uploadDoc)
            self.btnAddPicture.isHidden = false
            self.btnDeleteDocument.isHidden = true
        }
    }
    @IBAction func btnCancelTapped(_ sender: Any) {
         self.popVC()
    }
    
    @IBAction func btnSubmitTapped(_ sender: Any) {
        self.view.tempDisable()
        self.openPhotoPicker()
    }
    
    func openConfirmationDialog() {
        self.view.tempDisable()
        let alert: CustomAlertConfirmation = CustomAlertConfirmation.fromNib()
        alert.initialize(title: "DIALOG_REMOVE_DOCUMENT".localized(), message: "DIALOG_REMOVE_DOCUMENT_MESSAGE".localized(),buttonTitle: "DIALOG_REMOVE_DOCUMENT_BTN_OK", cancelButtonTitle: "DIALOG_REMOVE_DOCUMENT_BTN_CANCEL".localized())
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
            self.wsRemoveDocument()

        }
    }
    @IBAction func btnDeleteTapped(_ sender: Any) {
        self.openConfirmationDialog()
    }
}




extension ManageSingleDocumentVC {
    func openPhotoPicker() {
        let photoPickerAlert: CustomDocumentPicker = CustomDocumentPicker.fromNib()
        photoPickerAlert.isForDocument = true
        photoPickerAlert.initialize(title:"ADD_NEW_DOCUMENT_TITLE".localized())
        photoPickerAlert.show(animated: true)
        photoPickerAlert.onBtnCancelTapped = { [weak photoPickerAlert, weak self] in
            photoPickerAlert?.dismiss()
             guard let self = self else { return } ; print(self)
            self.btnAddPicture.isEnabled = true
        }
        photoPickerAlert.onBtnDoneTapped = { [weak photoPickerAlert, weak self] in
            photoPickerAlert?.dismiss()
            guard let self = self else { return } ; print(self)
            self.btnAddPicture.isEnabled = true
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
extension ManageSingleDocumentVC: CropViewControllerDelegate {

    func cropViewControllerDidCrop(_ cropViewController: CropViewController, cropped: UIImage, transformation: Transformation) {
        //self.uploadFileDetail?.image = cropped
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

extension ManageSingleDocumentVC {
    func wsUpdateDocument() {
        Loader.showLoading()
        AppWebApi.updateDocuments(documents: [self.selectedDocument!]) { (response) in
            Loader.hideLoading()
            if ResponseModel.isSuccess(response: response, withSuccessToast: false, andErrorToast: true) {
                let user = response.data
                PreferenceHelper.shared.setUserId(user.id)
                appSingleton.user = user
                Singleton.saveInDb()
                //self.popVC()
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
                    return data.type == self.selectedDocType.rawValue
                }) {
                    appSingleton.user.documents.remove(at: index)
                }
                Singleton.saveInDb()
                self.updateUI()
                //self.popVC()
            }
        }
    }
}
