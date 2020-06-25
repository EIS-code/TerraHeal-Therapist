//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit



class TherapistProfileVC: MainVC {

    @IBOutlet weak var lblHeader: ThemeLabel!
    @IBOutlet weak var vwProfilePic: UIView!
    @IBOutlet weak var imgProfilePic: UIImageView!
    @IBOutlet weak var lblProfilePic: ThemeLabel!
    @IBOutlet weak var btnProfilePic: ThemeButton!
    @IBOutlet weak var lblProfilePicMessage: ThemeLabel!
    @IBOutlet weak var txtName: ACFloatingTextfield!

    @IBOutlet weak var stkGender: UIStackView!
    @IBOutlet weak var lblGender: ThemeLabel!
    @IBOutlet weak var btnMale: ThemeButton!
    @IBOutlet weak var btnFemale: ThemeButton!
    @IBOutlet weak var txtDob: ACFloatingTextfield!
    @IBOutlet weak var txtEmergencyContact: ACFloatingTextfield!

    @IBOutlet weak var btnBio: ThemeButton!
    @IBOutlet weak var btnThingsIcanDo: ThemeButton!

    @IBOutlet weak var btnSubmit: ThemeButton!
    @IBOutlet weak var btnDone: ThemeButton!


    var aboutMe:String = ""
    var selectedDate: Date? = nil
    var selectedTherapies:[String]  = []
    var selectedMassages:[String]  = []
    var picker: UIImagePickerController! = UIImagePickerController()
    var imageSelected:UIImage?;
    var gender: String = Gender.Other
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

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.lblProfilePic?.setRound()
        self.imgProfilePic?.setRound()
        //self.btnMale?.setRound()
        //self.btnFemale?.setRound()
        self.btnDone?.setUpRoundedButton()
        self.btnThingsIcanDo?.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
        //self.btnBio?.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)

    }

    private func initialViewSetup() {
        self.vwBar?.backgroundColor = UIColor.clear
        self.lblHeader?.text = "T_PROFILE_LBL_TITLE".localized()
        self.lblHeader.setFont(name: FontName.GradDuke, size: FontSize.label_26)
        self.lblProfilePic?.text = "LBL_UPLOAD".localized()
        self.lblProfilePic.setFont(name: FontName.Ovo, size: FontSize.label_20)
        self.lblProfilePicMessage?.text = "T_PROFILE_LBL_PROFILE_PICTURE".localized()
        self.lblProfilePicMessage?.setFont(name: FontName.Ovo, size: FontSize.label_22)
        self.txtName.placeholder = "T_PROFILE_TXT_NAME".localized()
        self.txtDob.placeholder = "T_PROFILE_TXT_DOB".localized()
        self.txtDob.setInputViewDatePicker(target: self, selector: #selector(dateSelected))
        self.txtEmergencyContact.placeholder = "T_PROFILE_TXT_EMERGENCEY_CONTACT".localized()
        self.lblGender?.text = "T_PROFILE_LBL_GENDER".localized()
        self.lblGender?.setFont(name: FontName.Ovo, size: FontSize.label_22)
        self.btnMale.setTitle("T_PROFILE_GENDER_MALE".localized(), for: .normal)
        self.btnMale.setFont(name: FontName.GradDuke, size: FontSize.button_14)
        self.btnFemale.setTitle("T_PROFILE_GENDER_FEMALE".localized(), for: .normal)
        self.btnFemale.setFont(name: FontName.GradDuke, size: FontSize.button_14)
        self.btnBio.setTitle("T_PROFILE_LBL_BIO".localized(), for: .normal)
        self.btnBio.setFont(name: FontName.GradDuke, size: FontSize.button_14)
        self.btnThingsIcanDo.setTitle("T_PROFILE_LBL_THINGS_I_DO".localized(), for: .normal)
        self.btnThingsIcanDo.setFont(name: FontName.GradDuke, size: FontSize.button_14)
        self.btnSubmit.setTitle("BTN_SUBMIT".localized(), for: .normal)
        self.btnSubmit.setFont(name: FontName.GradDuke, size: FontSize.button_22)
        self.setUserData()
    }

    func setUserData() {
        self.txtName.text = appSingleton.user.name
        self.txtDob.text = appSingleton.user.dob.formatDate(from: DateFormat.DOB, to: DateFormat.DD_MM_YYYY)
        self.txtEmergencyContact.text = appSingleton.user.telNumber
        self.aboutMe = appSingleton.user.shortDescription
        if !self.aboutMe.isEmpty() {
            self.btnBio.setRound(withBorderColor: UIColor.themePrimary, andCornerRadious: 10.0, borderWidth: 1.0)
        }
        if appSingleton.user.gender == Gender.Male {
            self.btnMaleTapped(self.btnMale)
        } else {
            self.btnFemaleTapped(self.btnFemale)
        }
        self.selectedMassages = appSingleton.user.selectedMassages
    }

    @IBAction func btnMaleTapped(_ sender: UIButton) {
        self.gender = Gender.Male
        btnFemale.setDeselect()
        btnMale.setSelected()
    }

    @IBAction func btnFemaleTapped(_ sender: UIButton) {
        self.gender = Gender.Female
        btnMale.setDeselect()
        btnFemale.setSelected()
    }

    // MARK: Action Buttons
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        super.btnLeftTapped()
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnDoneTapped(_ sender: Any) {
        self.btnDone.isEnabled = false
        self.btnSubmit.isEnabled = false
        self.wsProfile()
    }
    @IBAction func dateSelected() {
        if let datePicker = self.txtDob.inputView as? UIDatePicker {
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = .medium
            self.selectedDate = datePicker.date
            self.txtDob.text = datePicker.date.toString(format: DateFormat.DD_MM_YYYY)
        }
        _ = self.txtDob.resignFirstResponder()
    }

    @IBAction func btnThingsIcanDoTapped(_ sender: UIButton) {
        sender.isEnabled = false
        let alert: TherapistWorkDialog = TherapistWorkDialog.fromNib()
        alert.initialize(selectedMassages: self.selectedMassages, selectedTherapies: self.selectedTherapies, data: "")
        alert.show(animated: true)
        alert.onBtnDoneTapped = { [weak alert, weak self] (massages:[String],therapies:[String]) in
            alert?.dismiss()
            sender.isEnabled = true
            self?.selectedMassages = massages
            self?.selectedTherapies = therapies
        }
        alert.onBtnCancelTapped = { [weak alert/*,weak self*/] in
            alert?.dismiss()
            sender.isEnabled = true
        }
    }
    @IBAction func btnBioTapped(_ sender: UIButton) {
        sender.isEnabled = false
        let alert: TextViewDialog = TextViewDialog.fromNib()
        alert.initialize(title: "T_PROFILE_BIO_LBL_TITLE".localized(), message: "T_PROFILE_BIO_LBL_MESSAGE".localized(), data: self.aboutMe)
        alert.show(animated: true)
        alert.onBtnDoneTapped = { [weak alert, weak self] (data:String) in
            alert?.dismiss()
            self?.aboutMe = data
            sender.isEnabled = true
        }
        alert.onBtnCancelTapped = { [weak alert/*,weak self*/] in
            alert?.dismiss()
            sender.isEnabled = true
        }
    }

    @IBAction func btnProfilePicTapped(_ sender: Any) {
        self.photoFromGallary()
    }
    // MARK: Other Functions
}


extension TherapistProfileVC:  UIImagePickerControllerDelegate,UINavigationControllerDelegate {
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
            self.imgProfilePic.image = imageSelected
            self.lblProfilePic.isHidden = true
        }

        else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageSelected = image
            self.imgProfilePic.image = imageSelected
            self.lblProfilePic.isHidden = true
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

//MARK:  Web Service Calls
extension TherapistProfileVC {

    func wsProfile() {
        Loader.showLoading()
        var request: User.RequestProfile = User.RequestProfile()
        request.name = txtName.text?.trim() ??  ""
        request.email = appSingleton.user.email
        request.dob = (txtDob.text?.trim() ?? "").formatDate(from: DateFormat.DD_MM_YYYY, to: DateFormat.DOB)
        request.gender =  self.gender
        if txtEmergencyContact.text?.isEmpty() ?? true {
           request.tel_number = appSingleton.user.telNumber
        } else {
           request.tel_number = txtEmergencyContact.text?.trim()
        }
        request.hobbies = "Reading"
        request.short_description = self.aboutMe
        request.paid_percentage = "50"
        request.selected_massages = selectedMassages
        request.selected_therapies = selectedTherapies
        var document:  UploadDocumentDetail? = nil
        if imageSelected != nil {
            document  = UploadDocumentDetail(id: "", name: PreferenceHelper.shared.getUserId(), image: imageSelected, data: imageSelected?.jpegData(compressionQuality: 0.8), isCompleted: true)
        }
        AppWebApi.profile(params: request, image: document) { (response) in
            let _: ResponseModel = ResponseModel.init(fromDictionary: response.toDictionary())
            Loader.hideLoading()
            let model: ResponseModel = ResponseModel.init(fromDictionary: response.toDictionary())
            if ResponseModel.isSuccess(response: model, withSuccessToast: true, andErrorToast: true) {
                if let user = response.data.first {
                    PreferenceHelper.shared.setUserId(user.id)
                    //PreferenceHelper.shared.setSessionToken(user.token)
                    appSingleton.user = user
                    Singleton.saveInDb()
                    self.setUserData()
                }
            }
            self.btnDone?.isEnabled = true
            self.btnSubmit?.isEnabled = true
        }
    }
}
