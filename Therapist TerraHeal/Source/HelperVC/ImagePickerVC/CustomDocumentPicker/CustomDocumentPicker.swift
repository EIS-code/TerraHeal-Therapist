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


class CustomDocumentPicker: ThemeBottomDialogView {

    @IBOutlet weak var vwCamera: UIView!
    @IBOutlet weak var btnCamera: UIButton!
    @IBOutlet weak var lblCamera: ThemeLabel!

    @IBOutlet weak var vwGallary: UIView!
    @IBOutlet weak var btnGallary: UIButton!
    @IBOutlet weak var lblGallary: ThemeLabel!
    var isForDocument: Bool = false
    var picker: UIImagePickerController! = UIImagePickerController()
    var documentSelected:UploadDocumentDetail?;
    var onBtnCameraTapped: ((_ image: UploadDocumentDetail) -> Void)? = nil
    var onBtnGallaryTapped: ((_ image: UploadDocumentDetail) -> Void)? = nil
    var onBtnDoneTapped: (() -> Void)? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        self.isCancellable = true
    }

    func initialize(title:String) {
        self.initialSetup()
        self.lblTitle.text = title
    }



    override func initialSetup() {
        super.initialSetup()
        self.lblCamera.text = "PHOTO_DIALOG_SCAN_DOCUMENT".localized()
        self.lblCamera.setFont(name: FontName.Regular, size: FontSize.header)
        self.lblGallary.text = "PHOTO_DIALOG_UPLODED".localized()
        self.lblGallary.setFont(name: FontName.Regular, size: FontSize.header)
        self.lblTitle.setFont(name: FontName.Bold, size: FontSize.header)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    @IBAction func btnCameraTapped(_ sender: Any) {
        self.photoFromCamera()
    }

    @IBAction func btnGallaryTapped(_ sender: Any) {
        if isForDocument {
            self.openDocumentPicker()
        } else {
            self.photoFromGallary()
        }
    }

    @IBAction func btnDoneTapped(_ sender: Any) {
        if self.onBtnDoneTapped != nil {
            self.onBtnDoneTapped!();
        }
    }




}

extension CustomDocumentPicker:  UIImagePickerControllerDelegate {

    func photoFromGallary() {
        picker.modalPresentationStyle = .fullScreen
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .savedPhotosAlbum
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        DispatchQueue.main.async {
            Common.appDelegate.getTopViewController()?.present(self.picker, animated: true, completion: nil)
        }
    }
    func photoFromCamera() {
        picker.delegate = self
        picker.allowsEditing = true
        picker.modalPresentationStyle = .fullScreen

        if UIImagePickerController.isSourceTypeAvailable(.camera) {
         picker.sourceType = .camera
            DispatchQueue.main.async {
                Common.appDelegate.getTopViewController()?.present(self.picker, animated: true, completion: nil)
            }
        } else {
            DispatchQueue.main.async {
                Common.showAlert(message: "Device doesn't have a " + "Camera")
            }
        }

    }

    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            let fileManager = FileManager.default
            let documentsPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
            _ = documentsPath?.appendingPathComponent("image.jpg")
            var imageName: String = "mydocumentImage.png"
            if let asset = info[UIImagePickerController.InfoKey.phAsset] as? PHAsset {
                let assetResources = PHAssetResource.assetResources(for: asset)
                print(assetResources.first!.originalFilename)
                if let name  = assetResources.first?.originalFilename {
                    imageName = name
                }
            }

            self.documentSelected = UploadDocumentDetail.init(id: appSingleton.user.id, name: imageName, image: image, data: image.pngData())
        }
        else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let fileManager = FileManager.default
            let documentsPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
            _ = documentsPath?.appendingPathComponent("image.jpg")
            var imageName: String = "mydocumentImage.png"
            print(documentsPath?.pathExtension)

            if let asset = info[UIImagePickerController.InfoKey.phAsset] as? PHAsset {
                let assetResources = PHAssetResource.assetResources(for: asset)
                print(assetResources.first!.originalFilename)
                if let name  = assetResources.first?.originalFilename {
                    imageName = name
                }
            }
            self.documentSelected = UploadDocumentDetail.init(id: appSingleton.user.id, name: imageName, image: image, data: image.pngData())
        }
        else {
            documentSelected = nil
        }
        Common.appDelegate.getTopViewController()?.dismiss(animated: true, completion: {
            if self.onBtnGallaryTapped != nil {
                if let image = self.documentSelected {
                    self.onBtnGallaryTapped!(image);
                }

            }
        })
    }

    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        Common.appDelegate.getTopViewController()?.dismiss(animated: true, completion: nil)
    }


}

extension CustomDocumentPicker: UIDocumentPickerDelegate, UINavigationControllerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        if let url = urls.first {
            let data = try! Data(contentsOf: url)
            if url.absoluteString.isImage() {
                self.documentSelected = UploadDocumentDetail(id: url.absoluteString, name: url.pathComponents.last!,image: UIImage.init(data: data), data: data)
            } else {
                self.documentSelected = UploadDocumentDetail(id: url.absoluteString, name: url.pathComponents.last!,image: nil , data: data)
            }
        }
        if self.onBtnGallaryTapped != nil {
            if let image = self.documentSelected {
                self.onBtnGallaryTapped!(image);
            }
        }

    }

    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }

    func openDocumentPicker() {
        let types: [String] = ["public.item"]
        let documentPicker = UIDocumentPickerViewController(documentTypes: types, in: .import)
        documentPicker.delegate = self
        documentPicker.modalPresentationStyle = .formSheet
        Common.appDelegate.getTopViewController()?.present(documentPicker, animated: true, completion: nil)
    }
}

