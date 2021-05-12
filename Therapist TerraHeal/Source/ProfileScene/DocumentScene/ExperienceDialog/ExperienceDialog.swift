//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Jaydeep. All rights reserved.
//

import UIKit
import Photos
import MobileCoreServices

class ExperienceDialog: ThemeBottomDialogView {

    @IBOutlet weak var vwForUploadDocument: UIView!
    @IBOutlet weak var txtDescription: ThemeTextView!
    @IBOutlet weak var imgDocument: UIImageView!
    @IBOutlet weak var lblUploaded: ThemeLabel!
    var picker: UIImagePickerController! = UIImagePickerController()
    var imageSelected:UploadDocumentDetail?;

    var strEnteredData: String = ""
    var onBtnDoneTapped: ((_ data:UploadDocumentDetail, _ description: String) -> Void)? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func initialize(title:String,placeholder:String = "",  data: String = "" , buttonTitle:String,cancelButtonTitle:String) {
        self.initialSetup()
        self.lblTitle.setText(title)
        
        self.txtDescription.setText(data)
        if cancelButtonTitle.isEmpty() {
            self.btnCancel.isHidden = true
        } else {
            self.btnCancel.setText(cancelButtonTitle, for: .normal)
            self.btnCancel.isHidden = false
        }
        if buttonTitle.isEmpty() {
            self.btnDone.isHidden = true
        } else {
            self.btnDone.setText(buttonTitle, for: .normal)
            self.btnDone.isHidden = false
        }
        self.txtDescription.placeholder = placeholder
    }

    override func initialSetup() {
        super.initialSetup()
        self.txtDescription.setFont(name: FontName.Regular, size: FontSize.subHeader)
        self.txtDescription.setPlaceholderFont(name: FontName.Regular, size: FontSize.subHeader)
        self.txtDescription.placeholder = "Lorem ipsum dolor"
        self.lblTitle.setFont(name: FontName.Bold, size: FontSize.header)
        self.txtDescription?.delegate = self
        self.txtDescription.borderLineColor = .themePrimary
        self.txtDescription.bgColor = .themeWhite
        self.lblUploaded.setText("PHOTO_DIALOG_UPLODED".localized())
        self.lblUploaded.setFont(name: FontName.SemiBold, size: FontSize.header)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    @IBAction func btnDoneTapped(_ sender: Any) {
        strEnteredData = txtDescription.text?.trim() ?? ""
        if strEnteredData.isEmpty() {
            Common.showAlert(message: "VALIDATION_MSG_INVALID_DATA".localized())
        } else if self.imageSelected == nil {
            Common.showAlert(message: "VALIDATION_MSG_UPLOAD_EXPERIANCE_CERTIFICATE".localized())
        }
        else {
            if self.onBtnDoneTapped != nil {
                self.onBtnDoneTapped!(self.imageSelected!, strEnteredData);
            }
        }
    }

    @IBAction func btnGalleryTapped(_ sender: Any) {
        self.photoFromGallary()
    }

}

extension ExperienceDialog: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {

    }
}

extension ExperienceDialog:  UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func photoFromGallary() {
        picker.modalPresentationStyle = .fullScreen
        picker.delegate = self
        picker.allowsEditing = false
        picker.sourceType = .savedPhotosAlbum
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        DispatchQueue.main.async {
            Common.appDelegate.getTopViewController()?.present(self.picker, animated: true, completion: nil)
        }
    }

    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            let fileManager = FileManager.default
            let documentsPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
            _ = documentsPath?.appendingPathComponent("image.jpg")
            var imageName: String = "mydocumentImage"
            if let asset = info[UIImagePickerController.InfoKey.phAsset] as? PHAsset {
                let assetResources = PHAssetResource.assetResources(for: asset)
                print(assetResources.first!.originalFilename)
                if let name  = assetResources.first?.originalFilename {
                    imageName = name
                }
            }

            self.imageSelected = UploadDocumentDetail.init(id: appSingleton.user.id, name: imageName, image: image, data: image.pngData(), isCompleted: true)
        }
        else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let fileManager = FileManager.default
            let documentsPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
            _ = documentsPath?.appendingPathComponent("image.jpg")
            var imageName: String = "mydocumentImage"
            if let asset = info[UIImagePickerController.InfoKey.phAsset] as? PHAsset {
                let assetResources = PHAssetResource.assetResources(for: asset)
                print(assetResources.first!.originalFilename)
                if let name  = assetResources.first?.originalFilename {
                    imageName = name
                }
            }
            self.imageSelected = UploadDocumentDetail.init(id: appSingleton.user.id, name: imageName, image: image, data: image.pngData(), isCompleted: true)
        }
        else {
            imageSelected = nil
        }
        Common.appDelegate.getTopViewController()?.dismiss(animated: true, completion: {
            self.imgDocument.image = self.imageSelected?.image
        })
    }

    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        Common.appDelegate.getTopViewController()?.dismiss(animated: true, completion: nil)
    }
}
