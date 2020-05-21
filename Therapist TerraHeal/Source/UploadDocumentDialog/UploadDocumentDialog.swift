//
//  CustomAlert.swift
//  ModalView
//
//  Created by Aatish Rajkarnikar on 3/20/17.
//  Copyright © 2017 Aatish. All rights reserved.
//

import UIKit
import Photos
import MobileCoreServices

class UploadDocumentDialog: ThemeDialogView {

    @IBOutlet weak var vwBgForAddFile: UIView!
    @IBOutlet weak var lblTitle: ThemeLabel!
    @IBOutlet weak var lblMessage: ThemeLabel!
    @IBOutlet weak var btnVerify: ThemeButton!
    @IBOutlet weak var btnDone: ThemeButton!
    @IBOutlet weak var dialogView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var hwTblVw: NSLayoutConstraint!
    @IBOutlet weak var btnAddFile: UIButton!
    @IBOutlet weak var lblAddFile: ThemeLabel!
    @IBOutlet weak var tblDocuments: UITableView!

    var picker: UIImagePickerController! = UIImagePickerController()
    var imageSelected:UIImage?;
    var arrForUploadDocuments:[UploadDocumentDetail] = []
    var numberOfDocuments: Int = 1
    var onBtnDoneTapped: ((_ documents:[UploadDocumentDetail]) -> Void)? = nil
    var onBtnCancelTapped: (() -> Void)? = nil

    //Animation Properties
    var animationDirection: AnimationDirection = .undefined
    var transitionAnimator: UIViewPropertyAnimator? = nil
    var animationProgress: CGFloat = 0
    var yPostion: CGFloat = 0.0

    func initialize(message:String, documentCount:Int) {
        self.lblTitle.text = "UPLOAD_DOCUMENT_LBL_TITLE".localized()
        self.lblMessage.text =  message
        self.numberOfDocuments = documentCount
        self.lblAddFile.text = "UPLOAD_DOCUMENT_BTN_ADD_FILE".localized()
        self.btnVerify.setTitle("UPLOAD_DOCUMENT_BTN_SUBMIT".localized(), for: .normal)
        self.initialSetup()
    }

    func initialSetup() {
        self.dialogView.clipsToBounds = true
        self.backgroundColor = .clear
        self.backgroundView.backgroundColor = UIColor.black
        self.backgroundView.alpha = 0.0
        self.backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))
        self.dialogView.setRound(withBorderColor: .clear, andCornerRadious: 20.0, borderWidth: 1.0)
        self.vwBgForAddFile.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
        self.lblTitle.setFont(name: FontName.GradDuke, size: FontSize.label_22)
        self.lblMessage.setFont(name: FontName.Ovo, size: FontSize.label_20)
        self.lblAddFile.setFont(name: FontName.GradDuke, size: FontSize.button_22)
        self.setupTableView()
        self.addPanGesture(view: self)
        transitionAnimator = UIViewPropertyAnimator.init(duration: 0.25, curve: UIView.AnimationCurve.easeInOut, animations: nil)
    }

    func setupTableView() {
        self.tblDocuments?.delegate = self
        self.tblDocuments?.dataSource = self
        self.tblDocuments?.rowHeight = UITableView.automaticDimension
        self.tblDocuments?.backgroundColor = .clear
        self.tblDocuments?.estimatedRowHeight = 60
        self.tblDocuments?.estimatedRowHeight = UITableView.automaticDimension
        self.tblDocuments?.register(DocumentTblCell.nib(), forCellReuseIdentifier: DocumentTblCell.name)
        self.tblDocuments?.tableFooterView = UIView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.btnDone?.setUpRoundedButton()
    }
    func show(animated:Bool){

        self.isAnimated = animated
        self.backgroundView.alpha = 0
        self.frame = UIScreen.main.bounds
        if let topController = Common.appDelegate.getTopViewController() {
            topController.view.addSubview(self)
        }

        if animated {
            self.isUserInteractionEnabled = false
            self.dialogView.alpha = 0.1
            self.dialogView.transform = CGAffineTransform(translationX: 0.0, y: self.frame.maxY)
            UIView.animate(withDuration: 0.25, delay: 0, options: [.curveEaseInOut], animations: {
                self.dialogView.transform = CGAffineTransform.identity
                self.backgroundView.alpha = 0.66
                self.dialogView.alpha = 1.0
            }) { (completion) in



                //self.animationVw.shake()
                self.isUserInteractionEnabled = true
            }
        }
        else {
            self.backgroundView.alpha = 0.66
        }

    }

    func dismiss(){
        if self.isAnimated {
            self.dialogView.transform = CGAffineTransform.identity
            self.backgroundView.alpha = 0.66
            self.dialogView.alpha = 1.0
            UIView.animate(withDuration: 0.25, delay: 0.0, options: [.curveEaseInOut], animations: {

                self.dialogView.transform = CGAffineTransform(translationX: 0, y: self.frame.maxY)
                self.backgroundView.alpha = 0.0
                self.dialogView.alpha = 0.1

            }) { (completion) in
                self.removeFromSuperview()
            }
        }else{
            self.removeFromSuperview()
        }

    }


    @objc func didTappedOnBackgroundView(){
        if isCancellable {
            dismiss()
        }
    }

    @IBAction func btnAddFileTapped(_ sender: UIButton) {
        self.openDocumentPicker()
        //self.photoFromGallary()

    }


    @IBAction func btnDoneTapped(_ sender: Any) {
        if self.onBtnDoneTapped != nil {
            self.onBtnDoneTapped!(self.arrForUploadDocuments);
        }
        /*
        if self.arrForUploadDocuments.count == 0{
            Common.showAlert(message: "VALIDATION_MSG_PLEASE_UPLOAD_ALL_DOCUMENTS".localized() + self.numberOfDocuments.toString())
        } else {
            if self.onBtnDoneTapped != nil {
                self.onBtnDoneTapped!(self.arrForUploadDocuments);
            }
        }*/


    }

    func addFileToArray(document:UploadDocumentDetail) {
        self.arrForUploadDocuments.append(document)
        self.tblDocuments.reloadData()
        if self.dialogView.bounds.height < (UIScreen.main.bounds.height * 0.8) {
            self.tblDocuments.reloadData(heightToFit: self.hwTblVw) {
            }
        } else  {
            // self.hwTblVw.constant = (self.dialogView.bounds.height * 0.5)
        }
       /* if self.arrForUploadDocuments.count == numberOfDocuments {
            self.btnAddFile.isEnabled = false
        } else {
            self.btnAddFile.isEnabled = true
        }*/

    }
}

extension UploadDocumentDialog:  UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return arrForUploadDocuments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: DocumentTblCell.name) as? DocumentTblCell
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: DocumentTblCell.name) as? DocumentTblCell
        }
        cell?.setData(data: arrForUploadDocuments[indexPath.row])

        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //self.openDocumentDialog()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


extension UploadDocumentDialog:  UIImagePickerControllerDelegate {
     func photoFromGallary() {
            picker.delegate = self
            picker.allowsEditing = true
            picker.sourceType = .savedPhotosAlbum
            picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            DispatchQueue.main.async {
                Common.appDelegate.getTopViewController()?.present(self.picker, animated: true, completion: nil)
        }
    }

    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            imageSelected = image
            let fileManager = FileManager.default
            let documentsPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
            let imagePath = documentsPath?.appendingPathComponent("image.jpg")
            var imageName: String = "mydocumentImage"
            if let asset = info[UIImagePickerController.InfoKey.phAsset] as? PHAsset {
                let assetResources = PHAssetResource.assetResources(for: asset)
                print(assetResources.first!.originalFilename)
                if let name  = assetResources.first?.originalFilename {
                    imageName = name
                }

            }
            let document: UploadDocumentDetail = UploadDocumentDetail(id: imagePath?.description ?? "", name: imageName,image: self.imageSelected, isCompleted: true)
            self.addFileToArray(document: document)
        }

        else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageSelected = image
            let fileManager = FileManager.default
            let documentsPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
            let imagePath = documentsPath?.appendingPathComponent("image.jpg")
            var imageName: String = "mydocumentImage"
            if let asset = info[UIImagePickerController.InfoKey.phAsset] as? PHAsset {
                let assetResources = PHAssetResource.assetResources(for: asset)
                print(assetResources.first!.originalFilename)
                if let name  = assetResources.first?.originalFilename {
                    imageName = name
                }

            }
            let document: UploadDocumentDetail = UploadDocumentDetail(id: imagePath?.description ?? "", name: imageName,image: self.imageSelected ,isCompleted: true)

            self.addFileToArray(document: document)
        }
        else {
            imageSelected = nil
            

        }
         Common.appDelegate.getTopViewController()?.dismiss(animated: true, completion: nil)
    }

    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        Common.appDelegate.getTopViewController()?.dismiss(animated: true, completion: nil)
    }


}
//MARK:   - Interative Animation
extension  UploadDocumentDialog {

    func addPanGesture(view: UIView) {
        let recognizer = UIPanGestureRecognizer()
        recognizer.addTarget(self, action: #selector(viewPanned(recognizer:))) // will be defined later!
        view.addGestureRecognizer(recognizer)
    }

    func dismissWithInteractiveAnimation() {

    }

    private func directionFromVelocity(_ velocity: CGPoint) -> AnimationDirection {
        guard velocity != .zero else { return .undefined }
        let isVertical = abs(velocity.y) > abs(velocity.x)
        var derivedDirection: AnimationDirection = .undefined
        if isVertical {
            derivedDirection = velocity.y < 0 ? .up: .down
        }
        else {
            derivedDirection = velocity.x < 0 ? .left: .right
        }
        return derivedDirection
    }


    @objc func viewPanned(recognizer: UIPanGestureRecognizer) {
        let velocity = recognizer.velocity(in: self)
        let translate: CGPoint = recognizer.translation(in: self)
        let direction:AnimationDirection =  directionFromVelocity(velocity)

        switch recognizer.state {
        case .began:

            if transitionAnimator?.isRunning ?? true {
                transitionAnimator?.stopAnimation(true)
            }
            animationProgress = transitionAnimator?.fractionComplete ??  0
            self.addDissmissAnimation(direction: direction)
            transitionAnimator?.pauseAnimation()
            yPostion = translate.y
        case .changed:
            let totalYSwipe: CGFloat = translate.x - yPostion
            let height: CGFloat = UIScreen.main.bounds.size.height
            let percentage = CGFloat(abs(Float(totalYSwipe))) / height
            animationProgress  = percentage
            transitionAnimator?.fractionComplete = animationProgress

        case .ended, .failed , .cancelled:
            transitionAnimator?.stopAnimation(true)
            self.addDissmissAnimation(direction: direction)
            transitionAnimator?.startAnimation()

        default:
            break
        }
    }
    func addDissmissAnimation(direction:AnimationDirection) {

        print("Direction \(direction)")
        switch  direction {
        case .up:
            print("No Animation")
            transitionAnimator?.stopAnimation(true)
            transitionAnimator?.addAnimations {
                self.dialogView.transform = CGAffineTransform.identity
                self.backgroundView.alpha = 0.66
                self.dialogView.alpha = 1.0
            }
            transitionAnimator?.addCompletion({ (position) in
                self.isUserInteractionEnabled = true
            })

        case .down:
            transitionAnimator?.stopAnimation(true)
            transitionAnimator?.addAnimations {
                self.dialogView.transform = CGAffineTransform(translationX:0, y: self.frame.maxY)
                self.backgroundView.alpha = 0.0
                self.dialogView.alpha = 0.1
            }
            transitionAnimator?.addCompletion({ (position) in
                self.removeFromSuperview()
                if self.onBtnCancelTapped != nil {
                    self.onBtnCancelTapped!();
                }
            })
        case .left,.right:
            print("No Animation")
        default:
            print("No Animation")

        }



    }


}

extension UploadDocumentDialog: UIDocumentPickerDelegate, UINavigationControllerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        for url in urls {
            let data = try! Data(contentsOf: url)
            let document: UploadDocumentDetail = UploadDocumentDetail(id: url.absoluteString, name: url.pathComponents.last!,image: nil , data: data,isCompleted: true)
            self.addFileToArray(document: document)

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
