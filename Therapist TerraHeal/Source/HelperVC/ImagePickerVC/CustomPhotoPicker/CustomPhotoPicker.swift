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


class CustomPhotoPicker: ThemeBottomDialogView {

    @IBOutlet weak var vwCamera: UIView!
    @IBOutlet weak var btnCamera: UIButton!
    @IBOutlet weak var lblCamera: ThemeLabel!

    @IBOutlet weak var vwGallary: UIView!
    @IBOutlet weak var btnGallary: UIButton!
    @IBOutlet weak var lblGallary: ThemeLabel!
    @IBOutlet weak var btnInfo: ThemeButton!

    var picker: UIImagePickerController! = UIImagePickerController()
    var imageSelected:UploadDocumentDetail?;

    var onBtnCameraTapped: ((_ image: UploadDocumentDetail) -> Void)? = nil
    var onBtnGallaryTapped: ((_ image: UploadDocumentDetail) -> Void)? = nil
    var onBtnDoneTapped: (() -> Void)? = nil
    var onBtnInfoTapped: (() -> Void)? = nil
    var cameraData: CameraMessageInfo = CameraMessageInfo.init(cameraMsg: "CAMERA_FACE_MSG".localized(), hintImage: ImageAsset.Camera.face)
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func initialize(title:String,buttonTitle:String,cancelButtonTitle:String) {
        self.initialSetup()
        self.lblTitle.text = title
        if cancelButtonTitle.isEmpty() {
            self.btnCancel.isHidden = true
        } else {
            self.btnCancel.setTitle(cancelButtonTitle, for: .normal)
            self.btnCancel.isHidden = false
        }
        if buttonTitle.isEmpty() {
            self.btnDone.isHidden = true
        } else {
            self.btnDone.setTitle(buttonTitle, for: .normal)
            self.btnDone.isHidden = false
        }
    }



    override func initialSetup() {
        super.initialSetup()
        self.lblCamera.text = "PHOTO_DIALOG_FROM_CAMERA".localized()
        self.lblCamera.setFont(name: FontName.Bold, size: FontSize.subHeader)
        self.lblGallary.text = "PHOTO_DIALOG_FROM_GALLARY".localized()
        self.lblGallary.setFont(name: FontName.Bold, size: FontSize.subHeader)
        self.lblTitle.setFont(name: FontName.Bold, size: FontSize.header)
        self.btnInfo.setRound(withBorderColor: .themePrimary, andCornerRadious: 0.0, borderWidth: 1.0)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    @IBAction func btnCameraTapped(_ sender: Any) {
        self.photoFromCamera()
    }

    @IBAction func btnGallaryTapped(_ sender: Any) {
        self.photoFromGallary()
    }

    @IBAction func btnDoneTapped(_ sender: Any) {
        if self.onBtnDoneTapped != nil {
            self.onBtnDoneTapped!();
        }
    }

    @IBAction func btnInfoTapped(_ sender: Any) {
        if self.onBtnInfoTapped != nil {
            self.onBtnInfoTapped!();
        }
    }



}

extension CustomPhotoPicker:  UIImagePickerControllerDelegate {
    
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
    func photoFromCamera() {
        let cameraVC:CameraVC =  CameraVC.fromNib()
        cameraVC.modalPresentationStyle = .fullScreen
        DispatchQueue.main.async {
            Common.appDelegate.getTopViewController()?.present(cameraVC, animated: true, completion: nil)
            cameraVC.showHint(data: self.cameraData)
        }
        cameraVC.onBtnCaptureTapped = { [weak self] (document)  in
            guard let self = self else {
                return
            }
            self.imageSelected = document
            
            Common.appDelegate.getTopViewController()?.dismiss(animated: true, completion: {
                if self.onBtnCameraTapped != nil {
                    if let image = self.imageSelected {
                        self.onBtnCameraTapped!(image);
                    }

                }
            })
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
            if self.onBtnGallaryTapped != nil {
                if let image = self.imageSelected {
                    self.onBtnGallaryTapped!(image);
                }

            }
        })
    }

    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        Common.appDelegate.getTopViewController()?.dismiss(animated: true, completion: nil)
    }

    
}

extension CustomPhotoPicker: UIDocumentPickerDelegate, UINavigationControllerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        for url in urls {
            let data = try! Data(contentsOf: url)
            let _: UploadDocumentDetail = UploadDocumentDetail(id: url.absoluteString, name: url.pathComponents.last!,image: nil , data: data,isCompleted: true)
            //self.addFileToArray(document: document)

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
