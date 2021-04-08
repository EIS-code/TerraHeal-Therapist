//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit


class MyDocumentsVC: BaseVC {
    
    @IBOutlet weak var btnCancel: CancelButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var vwForEmpty: UIView!
    @IBOutlet weak var vwBg: UIView!
    @IBOutlet weak var lblEmptyTitle: ThemeLabel!
    @IBOutlet weak var lblEmptyMsg: ThemeLabel!
    @IBOutlet weak var btnSubmit: FilledRoundedButton!

    var arrForData: [DocumentType] = [.AddressProof,
                                      .Insurance,
                                      .FreelancerFinancialDocument,
                                      .Certificates,
                                      .CV,
                                      .ReferenceLatter,
                                      .Others]
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
        self.setBackground(color: UIColor.themeBackground)
        self.setupTableView(tableView: self.tableView)
        self.setNavigationTitle(title: "MY_DOCUMENT_TITLE".localized())
        self.lblTitle?.textAlignment = .left
        self.lblTitle?.setFont(name: FontName.Bold, size: FontSize.large)
        self.lblEmptyTitle.setFont(name: FontName.Bold, size: FontSize.subHeader)
        self.lblEmptyMsg.setFont(name: FontName.Regular, size: FontSize.detail)
        self.lblEmptyTitle.text = "MY_DOCUMENT_EMPTY_TITLE".localized()
        self.lblEmptyMsg.text = "MY_DOCUMENT_EMPTY_MSG".localized()
        self.btnSubmit?.setTitle("MY_DOCUMENT_BTN_ADD_NEW".localized(), for: .normal)
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
        if arrForData.count == 2 {
            self.btnSubmit.isEnabled = false
            self.btnSubmit.gone()
        } else {
            self.btnSubmit.visible()
            self.btnSubmit.isEnabled = true
        }
    }
  
    func openPhotoPicker() {
        
        let photoPickerAlert: CustomDocumentPicker = CustomDocumentPicker.fromNib()
        photoPickerAlert.initialize(title:"ADD_NEW_DOCUMENT_DIALOG_TITLE".localized(), buttonTitle: "".localized(),cancelButtonTitle: "BTN_CANCEL".localized())
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
}


extension MyDocumentsVC: UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate {
    
    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.register(DocumentTblCell.nib()
            , forCellReuseIdentifier: DocumentTblCell.name)
        tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrForData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: DocumentTblCell.name, for: indexPath) as?  DocumentTblCell
        cell?.layoutIfNeeded()
        cell?.setData(data: arrForData[indexPath.row])
        cell?.layoutIfNeeded()
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        Common.appDelegate.loadManageDocumentVC(navigaionVC: self.navigationController)
    }
    
}


extension MyDocumentsVC: UIImageCropperProtocol {
    func didCropImage(originalImage: UIImage?, croppedImage: UIImage?) {
        self.updateUI()
    }
    
    //optional
    func didCancel() {
        print("did cancel")
         self.popVC()
        //self.wsUpdateProfile()
    }
}
