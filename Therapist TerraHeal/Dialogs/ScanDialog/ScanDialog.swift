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


class ScanDialog: ThemeBottomDialogView {

    @IBOutlet weak var vwCamera: UIView!
    @IBOutlet weak var btnCamera: UIButton!
    @IBOutlet weak var lblCamera: ThemeLabel!

    var imageSelected:UploadDocumentDetail?;
    var onBtnCameraTapped: ((_ image: UploadDocumentDetail) -> Void)? = nil
    var onBtnDoneTapped: (() -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func initialize(title:String,buttonTitle:String,cancelButtonTitle:String) {
        self.initialSetup()
        self.lblTitle.text = title
       
    }



    override func initialSetup() {
        super.initialSetup()
        self.lblCamera.text = "DIALOG_BTN_SCAN".localized()
        self.lblCamera.setFont(name: FontName.Bold, size: FontSize.subHeader)
        self.lblTitle.setFont(name: FontName.Bold, size: FontSize.header)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    @IBAction func btnCameraTapped(_ sender: Any) {
        self.photoFromCamera()
    }

   
    @IBAction func btnDoneTapped(_ sender: Any) {
            if self.onBtnDoneTapped != nil {
                self.onBtnDoneTapped!();
            }
    }




}

extension ScanDialog:  UIImagePickerControllerDelegate {
    
    func photoFromCamera() {
        let cameraVC:CameraVC =  CameraVC.fromNib()
        cameraVC.modalPresentationStyle = .fullScreen
        
        DispatchQueue.main.async {
                Common.appDelegate.getTopViewController()?.present(cameraVC, animated: true, completion: nil)
                
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

}
