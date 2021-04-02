//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit




class EditProfileVC: BaseVC {
    @IBOutlet weak var ivProfilePic: UIImageView!
    @IBOutlet weak var vwBg: UIView!
    @IBOutlet weak var scrVw: UIScrollView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var btnAddPicture: UIButton!
    @IBOutlet weak var collectionVwForProfile: UICollectionView!
    var kTableHeaderHeight:CGFloat = 150.0
    var selectedCountry: String? = nil
    var selectedCity: String? = nil
    var arrForProfile: [EditProfileTextFieldDetail] = []
    var selectedProfileDoc: UploadDocumentDetail? = nil
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
        self.setUserData()
        self.setupCollectionView(collectionView: collectionVwForProfile)
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        singleTap.cancelsTouchesInView = false
        singleTap.numberOfTapsRequired = 1
        scrVw.addGestureRecognizer(singleTap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.headerView.layoutIfNeeded()
        self.kTableHeaderHeight = self.headerView.bounds.height
        scrVw.contentInset = UIEdgeInsets(top: kTableHeaderHeight, left: 0, bottom: 0, right: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if self.isViewAvailable() {
            self.vwBg?.setRound(withBorderColor: UIColor.clear, andCornerRadious: 20.0, borderWidth: 1.0)
            self.vwBg?.setShadow(radius: 2.0, opacity: 1.0, offset: CGSize.init(width: 1.0, height: 0.0), color: UIColor.init(hex: "#B2B3B5"))
            self.ivProfilePic?.setRound()
            self.btnAddPicture?.setRound()
            //self.collectionVwForProfile?.reloadData()
        }
    }
    
    private func initialViewSetup() {
        self.setBackground(color: .themeWhite)
        self.setNavigationTitle(title: "Edit profile")
    }
    
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        super.btnLeftTapped()
        self.popVC()
    }
    
    @IBAction func btnAddPictureTapped(_ sender: Any) {
        btnAddPicture.isUserInteractionEnabled = false
        self.openPhotoPicker()
    }
    // MARK: - Other Methods
    

    
    func setUserData() {
        let user = appSingleton.user
        self.ivProfilePic.downloadedFrom(link: appSingleton.user.profilePhoto)

        self.arrForProfile = [
            EditProfileTextFieldDetail.init(value: user.accountNumber, type: .AccountNumber, rightImage: ""),
            EditProfileTextFieldDetail.init(value: user.name, type: .Name, rightImage: ""),
            EditProfileTextFieldDetail.init(value: user.surname, type: .Surname, rightImage: ""),
            EditProfileTextFieldDetail.init(value: user.gender, type: .Gender, rightImage: ""),
            EditProfileTextFieldDetail.init(value: user.dob, type: .DOB, rightImage: ""),
            EditProfileTextFieldDetail.init(value: user.nif, type: .Nif, rightImage: ""),
            EditProfileTextFieldDetail.init(value: user.socialSecurityNumber, type: .Ssn, rightImage: ""),
            EditProfileTextFieldDetail.init(value: user.cityName, type: .City, rightImage: ""),
            EditProfileTextFieldDetail.init(value: user.countryName, type: .Country, rightImage: ""),
            EditProfileTextFieldDetail.init(value: user.mobileNumber, type: .Phone, rightImage: ""),
            EditProfileTextFieldDetail.init(value: user.emergenceContactNumber, type: .EmergencyContact, rightImage: ""),
            EditProfileTextFieldDetail.init(value: user.email, type: .Email, rightImage: ""),
            EditProfileTextFieldDetail.init(value: user.languageSpoken, type: .LanguageSpoken, rightImage: "1"),
            EditProfileTextFieldDetail.init(value: "", type: .Documents, rightImage: "1"),
            EditProfileTextFieldDetail.init(value: "", type: .Services, rightImage: "1"),
            EditProfileTextFieldDetail.init(value: "", type: .Experience, rightImage: "1"),
            EditProfileTextFieldDetail.init(value: user.personalDescription, type: .Description, rightImage: "1"),
            EditProfileTextFieldDetail.init(value: user.healthConditionsAllergies, type: .HealthCodndition, rightImage: ""),

        ]

        self.selectedCity = appSingleton.user.cityId
        self.selectedCountry = appSingleton.user.countryId
        self.collectionVwForProfile.reloadData()
        
    }
}
//MARK: Dialogs
extension EditProfileVC {
    func openPhotoPicker() {
        let photoPickerAlert: CustomPhotoPicker = CustomPhotoPicker.fromNib()
        photoPickerAlert.initialize(title:"PHOTO_DIALOG_EDIT_PROFILE_TITLE".localized(), buttonTitle: "".localized(),cancelButtonTitle: "BTN_CANCEL".localized())
        photoPickerAlert.show(animated: true)
        photoPickerAlert.onBtnCancelTapped = { [weak photoPickerAlert, weak self] in
            photoPickerAlert?.dismiss()
            guard let self = self else { return } ;
            self.btnAddPicture.isUserInteractionEnabled = true
        }
        photoPickerAlert.onBtnDoneTapped = { [weak photoPickerAlert, weak self] in
            photoPickerAlert?.dismiss()

            guard let self = self else { return } ;
            self.btnAddPicture.isUserInteractionEnabled = true
        }
        photoPickerAlert.onBtnInfoTapped = { [/*weak photoPickerAlert,*/ weak self] in
            guard let self = self else { return } ;
            self.btnAddPicture.isUserInteractionEnabled = true
            self.openProfilePicInfoDialog()

        }
        photoPickerAlert.onBtnCameraTapped = { [weak photoPickerAlert, weak self] (doc) in
            photoPickerAlert?.dismiss()
            guard let self = self else { return } ; print(self)
            self.btnAddPicture.isUserInteractionEnabled = true
            self.selectedProfileDoc = doc
            self.selectedProfileDoc?.paramName = "profile_photo"
            self.openCropper(image: doc.image ?? UIImage())

        }
        photoPickerAlert.onBtnGallaryTapped = { [weak photoPickerAlert, weak self] (doc) in
            photoPickerAlert?.dismiss()
            guard let self = self else { return } ; print(self)
            self.selectedProfileDoc = doc
            self.selectedProfileDoc?.paramName = "profile_photo"
            self.openCropper(image: doc.image ?? UIImage())
            //let gallaryVC:GallaryVC = Common.appDelegate.loadGallaryVC(navigaionVC: self.navigationController)
        }
    }

    func openProfilePicInfoDialog() {


        let alert: CustomInformationDialog = CustomInformationDialog.fromNib()
        alert.initialize(title: "PHOTO_DIALOG_PROFILE_PIC_INFO_TITLE".localized(), data:"PHOTO_DIALOG_PROFILE_PIC_INFO_MSG".localized(), buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_BACK".localized())
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            guard let self = self else {return} ; print(self)
            alert?.dismiss()
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self]  in
            guard let self = self else {return} ; print(self)
            alert?.dismiss()
        }
    }

    func openServiceSelection(index:Int = 0) {
        let servicePicker: ServiceSelectionDialog = ServiceSelectionDialog.fromNib()
        servicePicker.initialize(title:arrForProfile[index].type.getPlaceHolder(), buttonTitle: "BTN_PROCEED".localized(),cancelButtonTitle: "BTN_BACK".localized())
        servicePicker.show(animated: true)
        servicePicker.onBtnCancelTapped = { [weak servicePicker, weak self] in
                   guard let self = self else { return } ; print(self)
                   servicePicker?.dismiss()
        }
        servicePicker.onBtnDoneTapped = { [weak servicePicker, weak self] in
                   guard let self = self else { return } ; print(self)
                   servicePicker?.dismiss()
        }
    }
    func openCropper(image: UIImage) {

        let cropper: UIImageCropperVC = UIImageCropperVC.fromNib()
        cropper.cropRatio = 1/1
        cropper.delegate = self
        cropper.picker = nil
        cropper.image = image
        cropper.cancelButtonText = "Cancel"
        cropper.view.layoutIfNeeded()
        self.navigationController?.pushViewController(cropper, animated: true)
    }

    func openCountryPicker(index:Int = 0) {
        let countryPickerAlert: CustomCountryPicker = CustomCountryPicker.fromNib()
        countryPickerAlert.initialize(title:arrForProfile[index].type.getPlaceHolder(), buttonTitle: "BTN_PROCEED".localized(),cancelButtonTitle: "BTN_BACK".localized())
        countryPickerAlert.show(animated: true)
        countryPickerAlert.onBtnCancelTapped = { [weak countryPickerAlert, weak self] in
            guard let self = self else { return } ; print(self)
            countryPickerAlert?.dismiss()
        }
        countryPickerAlert.onBtnDoneTapped = { [weak countryPickerAlert, weak self] (country) in
            guard let self = self else { return } ; print(self)
            countryPickerAlert?.dismiss()
            self.selectedCountry = country.id
            var request: UserWebService.RequestProfile = UserWebService.RequestProfile()
            request.country_id = country.id
            self.wsUpdateProfile(request: request)
        }
    }

    func openCityPicker(index:Int = 0,countryId:String) {

        if countryId.isEmpty() {
            Common.showAlert(message: "VALIDATION_MSG_SELECT_COUNTRY_FIRST".localized())
            return
        }
        let cityPickerAlert: CustomCityPicker = CustomCityPicker.fromNib()
        cityPickerAlert.initialize(title: arrForProfile[index].type.getPlaceHolder(), buttonTitle: "BTN_PROCEED".localized(),cancelButtonTitle: "BTN_BACK".localized(), countryId: selectedCountry ?? "")
        cityPickerAlert.show(animated: true)
        cityPickerAlert.onBtnCancelTapped = {
            [weak cityPickerAlert, weak self] in
            guard let self = self else { return } ; print(self)
            cityPickerAlert?.dismiss()
        }
        cityPickerAlert.onBtnDoneTapped = {
            [weak cityPickerAlert, weak self] (city) in
            guard let self = self else { return } ; print(self)
            cityPickerAlert?.dismiss()
            self.selectedCity = city.id
            var request: UserWebService.RequestProfile = UserWebService.RequestProfile()
            request.city_id = city.id
            self.wsUpdateProfile(request: request)
        }
    }
    func openTextFieldPicker(index:Int = 0) {
        let alert: CustomTextFieldDialog = CustomTextFieldDialog.fromNib()
        alert.initialize(title: arrForProfile[index].type.getPlaceHolder(), data: arrForProfile[index].value, buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_SKIP".localized(), isMandatory: false)
        alert.show(animated: true)
        let data =  self.arrForProfile[index]
        alert.configTextField(data: data.type.getInputConfiguration())
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            guard let self = self else { return } ; print(self)
            alert?.dismiss()
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self] (description) in
            guard let self = self else { return } ; print(self)
            alert?.dismiss()
            self.arrForProfile[index].value = description
            var request: UserWebService.RequestProfile = UserWebService.RequestProfile()
            switch self.arrForProfile[index].type
            {
            case .AccountNumber:
                request.account_number = description
            case .Name:
                request.name = description
            case .Surname:
                request.surname = description
            case .Nif :
                request.nif = description
            case .Ssn :
                request.social_security_number = description
            case .Email :
                request.email = description
            default : print("Default")
            }
            self.wsUpdateProfile(request: request)
        }
    }

    func openPersonalDetailDialog(index:Int) {
         let alert: CustomTextViewDialog = CustomTextViewDialog.fromNib()
               alert.initialize(title: "DIALOG_PERSONAL_DESCRIPTION_TITLE".localized(), placeholder: "DIALOG_PERSONAL_DESCRIPTION_PLACEHOLDER".localized(), data: "", buttonTitle: "DIALOG_PERSONAL_DESCRIPTION_BTN_SAVE".localized(), cancelButtonTitle: "BTN_CANCEL".localized())
               alert.show(animated: true)
               alert.onBtnCancelTapped = {
                   [weak alert, weak self] in
                   guard let self = self else {return}; print(self)
                   alert?.dismiss()
               }
               alert.onBtnDoneTapped = {
                   [weak alert, weak self] (description) in
                    alert?.dismiss()
                   guard let self = self else { return } ; print(self)
                   self.arrForProfile[index].value = description
                   self.collectionVwForProfile.reloadData()
                self.wsUpdateProfile(request: UserWebService.RequestProfile.init( personal_description: description))
               }
    }

    func openHeathConditionDialog(index:Int) {
        let alert: CustomTextViewDialog = CustomTextViewDialog.fromNib()
        alert.initialize(title: "DIALOG_HEALTH_CONDITION_OR_ALLERGIES_TITLE".localized(), placeholder: "DIALOG_HEALTH_CONDITION_OR_ALLERGIES_PLACEHOLDER".localized(), data: "", buttonTitle: "DIALOG_HEALTH_CONDITION_OR_ALLERGIES_BTN_SAVE".localized(), cancelButtonTitle: "BTN_CANCEL".localized())
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            guard let self = self else {return}; print(self)
            alert?.dismiss()
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self] (description) in
            alert?.dismiss()
            guard let self = self else { return } ; print(self)
            self.arrForProfile[index].value = description
            self.collectionVwForProfile.reloadData()
            self.wsUpdateProfile(request:UserWebService.RequestProfile.init(health_conditions_allergies: description))
        }
    }

    func openMobileNumberDialog(index:Int = 0) {
        let alert: CustomMobileNumberDialog = CustomMobileNumberDialog.fromNib()
        switch self.arrForProfile[index].type {
        case .EmergencyContact:
            let emergencyNumber: [String] = appSingleton.user.emergenceContactNumber.components(separatedBy: " ")
            alert.initialize(title: arrForProfile[index].type.getPlaceHolder(),countryPhoneCode: emergencyNumber.first ?? "",phoneNumber: emergencyNumber.last ?? "", buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_SKIP".localized())
        case .Phone:
            let mobileNumber: [String] = appSingleton.user.mobileNumber.components(separatedBy: " ")
            alert.initialize(title: arrForProfile[index].type.getPlaceHolder(),countryPhoneCode: mobileNumber.first ?? "",phoneNumber: mobileNumber.last ?? "", buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_SKIP".localized())
        default : print("Default")
        }


        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            guard let self = self else { return } ; print(self)
            alert?.dismiss()
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self] (countryPhoneCode,mobileNumber) in
            guard let self = self else { return } ; print(self)
            alert?.dismiss()
            var request: UserWebService.RequestProfile = UserWebService.RequestProfile()
            switch self.arrForProfile[index].type
            {
            case .EmergencyContact:
                request.emergence_contact_number = countryPhoneCode + " " + mobileNumber
            case .Phone:
                request.mobile_number = countryPhoneCode + " " + mobileNumber
            default : print("Default")
            }
            self.wsUpdateProfile(request: request)

        }
    }

    func openDatePicker(index:Int = 0) {
        let datePickerAlert: CustomDatePicker = CustomDatePicker.fromNib()
        datePickerAlert.initialize(title: arrForProfile[index].type.getPlaceHolder(), buttonTitle: "BTN_PROCEED".localized(),cancelButtonTitle: "BTN_BACK".localized())

        let minimumDate = Calendar.current.date(byAdding: .year, value: -100, to: Date()) ?? Date()

        datePickerAlert.setDate(minDate: minimumDate , maxDate: Date())
        datePickerAlert.show(animated: true)
        datePickerAlert.onBtnCancelTapped = {
            [weak datePickerAlert, weak self] in
            guard let self = self else { return } ; print(self)
            datePickerAlert?.dismiss()
        }
        datePickerAlert.onBtnDoneTapped = {
            [weak datePickerAlert, weak self] (date) in
            guard let self = self else { return } ; print(self)
            datePickerAlert?.dismiss()
            var request: UserWebService.RequestProfile = UserWebService.RequestProfile()
            request.dob = date.toString()
            self.wsUpdateProfile(request: request)
        }
    }

    func openLanguageSelectionDialog(index:Int) {

        let languagePicker: LanguageSelectionDialog = LanguageSelectionDialog.fromNib()
        languagePicker.initialize(title: arrForProfile[index].type.getPlaceHolder(), buttonTitle: "BTN_PROCEED".localized(),cancelButtonTitle: "BTN_BACK".localized())
        languagePicker.show(animated: true)
        languagePicker.onBtnCancelTapped = {
            [weak languagePicker, weak self] in
            guard let self = self else { return } ; print(self)
            languagePicker?.dismiss()
        }
        languagePicker.onBtnDoneTapped = {
            [weak languagePicker, weak self] (language) in
            guard let self = self else { return } ; print(self)
            languagePicker?.dismiss()
            self.arrForProfile[index].value = language.name
            print(language.fluency.rawValue)
            print(language.name)
            self.collectionVwForProfile.reloadData()
        }
    }

    func openGenderPicker(index:Int = 0) {
        let genderPickerAlert: CustomGenderPicker = CustomGenderPicker.fromNib()
        genderPickerAlert.selectedGender = Gender.Female
        genderPickerAlert.initialize(title: arrForProfile[index].type.getPlaceHolder(), buttonTitle: "BTN_PROCEED".localized(),cancelButtonTitle: "BTN_BACK".localized())
        genderPickerAlert.show(animated: true)
        genderPickerAlert.onBtnCancelTapped = {
            [weak genderPickerAlert, weak self] in
            guard let self = self else { return } ; print(self)
            genderPickerAlert?.dismiss()
        }
        genderPickerAlert.onBtnDoneTapped = {
            [weak genderPickerAlert, weak self] (gender) in
            guard let self = self else { return } ; print(self)
            genderPickerAlert?.dismiss()
            var request: UserWebService.RequestProfile = UserWebService.RequestProfile()
            request.gender = gender.rawValue
            self.wsUpdateProfile(request: request)

        }
    }
}

//MARK: Web Service Calls
extension EditProfileVC {
    func wsUpdateProfile(request: UserWebService.RequestProfile) {
        Loader.showLoading()
        AppWebApi.updateProfileDetail(params: request, image: self.selectedProfileDoc, document: selectedProfileDoc) { (response) in
            Loader.hideLoading()
            if ResponseModel.isSuccess(response: response, withSuccessToast: false, andErrorToast: true) {
                let user = response.data
                PreferenceHelper.shared.setUserId(user.id)
                appSingleton.user = user
                Singleton.saveInDb()
                self.setUserData()
            }
        }
    }
}

extension EditProfileVC: UIImageCropperProtocol {
    func didCropImage(originalImage: UIImage?, croppedImage: UIImage?) {
        ivProfilePic.image = croppedImage
        self.popVC()
        self.ivProfilePic.image = croppedImage
        self.selectedProfileDoc?.image = croppedImage
        self.wsUpdateProfile(request: UserWebService.RequestProfile.init())
    }
    
    //optional
    func didCancel() {
        print("did cancel")
        self.popVC()
        //self.wsUpdateProfile()
    }
}
