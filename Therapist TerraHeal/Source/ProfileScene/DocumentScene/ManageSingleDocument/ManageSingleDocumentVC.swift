//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit


class ManageSingleDocumentVC: BaseVC {
    
    @IBOutlet weak var btnCancel: CancelButton!
    @IBOutlet weak var vwForEmpty: UIView!
    @IBOutlet weak var vwBg: UIView!
    @IBOutlet weak var lblEmptyTitle: ThemeLabel!
    @IBOutlet weak var lblEmptyMsg: ThemeLabel!
    @IBOutlet weak var btnSubmit: FilledRoundedButton!
    @IBOutlet weak var lblDocumentId: ThemeLabel!
    @IBOutlet weak var vwForDocument: UIView!
    @IBOutlet weak var imgDocument: UIImageView!
    @IBOutlet weak var btnDeleteDocument: UIButton!


    var selectedDocType: DocumentType = DocumentType.init(rawValue: "") ?? .AddressProof
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

    }
        
    private func initialViewSetup() {
        self.setBackground(color: UIColor.themeLightBackground)
        self.setNavigationTitle(title: "MANAGE_DOCUMENT_TITLE".localized())
        self.lblTitle?.textAlignment = .left
        self.lblTitle?.setFont(name: FontName.Bold, size: FontSize.large)
        self.lblEmptyTitle.setFont(name: FontName.Bold, size: FontSize.subHeader)
        self.lblEmptyMsg.setFont(name: FontName.Regular, size: FontSize.detail)
        self.lblEmptyTitle.text = "DOCUMENT_EMPTY_TITLE".localized()
        self.lblEmptyMsg.text = "DOCUMENT_EMPTY_MSG".localized()
        self.btnSubmit?.setTitle("MANAGE_DOCUMENT_BTN_ADD_NEW".localized(), for: .normal)
        self.lblDocumentId.setFont(name: FontName.Regular, size: FontSize.detail)
    }
    func updateUI() {
        if let document = appSingleton.user.documents.first(where: { (document) -> Bool in
            document.type == self.selectedDocType.rawValue
        }) {
            self.imgDocument.downloadedFrom(link: document.fileName)
            self.vwForEmpty.isHidden = true
            self.vwForDocument.isHidden = false
        } else {
            self.vwForEmpty.isHidden = false
            self.vwForDocument.isHidden = true
        }
    }
    @IBAction func btnCancelTapped(_ sender: Any) {
         self.popVC()
    }
    
    @IBAction func btnSubmitTapped(_ sender: Any) {
        self.btnSubmit.isEnabled = false
        self.openPhotoPicker()
    }
    
    func openConfirmationDialog() {
        
        let alert: CustomAlertConfirmation = CustomAlertConfirmation.fromNib()
        
        alert.initialize(title: "Remove Document", message: "Are you you want to delete this document",buttonTitle: "Ok", cancelButtonTitle: "Cancel")
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
            self.updateUI()
        }
    }
    @IBAction func btnDeleteTapped(_ sender: Any) {
        self.openConfirmationDialog()
    }


}




extension ManageSingleDocumentVC: UIImageCropperProtocol {
    func openPhotoPicker() {
        let photoPickerAlert: CustomDocumentPicker = CustomDocumentPicker.fromNib()
        photoPickerAlert.initialize(title:"ADD_NEW_DOCUMENT_TITLE".localized(), buttonTitle: "".localized(),cancelButtonTitle: "BTN_CANCEL".localized())
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
            self.openCropper(image: doc.image ?? UIImage())

        }
        photoPickerAlert.onBtnGallaryTapped = { [weak photoPickerAlert, weak self] (doc) in
            photoPickerAlert?.dismiss()
             guard let self = self else { return } ; print(self)
            self.openCropper(image: doc.image ?? UIImage())
            //let gallaryVC:GallaryVC = Common.appDelegate.loadGallaryVC(navigaionVC: self.navigationController)
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
    func didCropImage(originalImage: UIImage?, croppedImage: UIImage?) {
        self.selectedDocument?.paramName = self.selectedDocType.paramName()
        self.selectedDocument?.image = croppedImage
        self.selectedDocument?.data = croppedImage?.jpegData(compressionQuality: 1.0)
        self.wsUpdateDocument()
    }
    
    //optional
    func didCancel() {
        print("did cancel")
         self.popVC()

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
                self.popVC()
            }
        }
    }
}
