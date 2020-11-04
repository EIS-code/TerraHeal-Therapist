//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit



class AddCardVC: BaseVC {
    
    
    @IBOutlet weak var lblTitleMessage: ThemeLabel!
    @IBOutlet weak var btnAddCard: FilledRoundedButton!
    @IBOutlet weak var txtCardName: ACFloatingTextfield!
    @IBOutlet weak var txtCardNumber: ACFloatingTextfield!
    @IBOutlet weak var txtExpiryDate: ACFloatingTextfield!
    @IBOutlet weak var txtCvv: ACFloatingTextfield!
    @IBOutlet weak var lblAccept: ThemeLabel!
    @IBOutlet weak var btnCheckBox: JDCheckboxButton!
    @IBOutlet weak var lblSaveDetailMsg: ThemeLabel!
    // MARK: Object lifecycle
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialViewSetup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if self.isViewAvailable() {
        }
    }
    
    private func initialViewSetup() {
        
        self.setBackground(color: UIColor.themeLightBackground)
        self.btnAddCard?.setTitle("ADD_CARD_BTN_ADD_CARD".localized(), for: .normal)
        self.btnAddCard?.setFont(name: FontName.SemiBold, size: FontSize.button_22)
        self.setNavigationTitle(title:"ADD_CARD_TITLE".localized())
        self.lblTitleMessage?.text = "ADD_CARD_TITLE_MESSAGE".localized()
        self.lblTitleMessage?.setFont(name: FontName.SemiBold, size: FontSize.detail)
        self.txtCardName?.placeholder = "ADD_CARD_TXT_NAME".localized()
        self.txtCardName.configureTextField(InputTextFieldDetail.getNameConfiguration())
        self.txtCardName?.delegate = self
        self.txtCardNumber?.placeholder = "ADD_CARD_TXT_CARD_NUMBER".localized()
        self.txtCardNumber?.delegate = self
        self.txtExpiryDate?.placeholder = "ADD_CARD_TXT_EXPIRY".localized()
        self.txtExpiryDate?.delegate = self
        self.txtCvv?.placeholder = "ADD_CARD_TXT_CVV_NUMBER".localized()
        self.txtCvv?.delegate = self
        self.btnAddCard?.setTitle("ADD_CARD_BTN_ADD_CARD".localized(), for: .normal)
        self.lblAccept?.text = "ADD_CARD_SAVE_CARD_DETAILS".localized()
        self.lblAccept?.setFont(name: FontName.SemiBold, size: FontSize.detail)
        self.lblSaveDetailMsg?.text = "ADD_CARD_SAVE_CARD_DETAIL_MESSAGE".localized()
        self.lblSaveDetailMsg?.setFont(name: FontName.Regular, size: FontSize.detail)
    }
    
    // MARK: - Action Methods
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
         _ = (self.navigationController as? NC)?.popVC()
    }
    
    @IBAction func btnCheckBoxTapped(_ sender: Any) {
        self.btnCheckBox.checkboxAnimation {
            
        }
    }

    @IBAction func btnAddCardTapped(_ sender: Any) {

    }
    func openMonthYearDialog() {
        
       let monthYearPicker: MonthYearDialog = MonthYearDialog.fromNib()
        monthYearPicker.initialize(title: "DATE_DIALOG_LBL_SELECT_TIME".localized(), buttonTitle: "BTN_PROCEED".localized(),cancelButtonTitle: "BTN_BACK".localized())
        monthYearPicker.show(animated: true)
        monthYearPicker.onBtnCancelTapped = {
            [weak monthYearPicker, weak self] in
            guard let self = self else { return } ; print(self)
            monthYearPicker?.dismiss()
        }
        monthYearPicker.onBtnDoneTapped = {
            [weak monthYearPicker, weak self] (month,year) in
            guard let self = self else { return } ; print(self)
            monthYearPicker?.dismiss()
            self.txtExpiryDate.text = month.toString() + "/" + year.toString()
        }
    }
    
}



extension AddCardVC : UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtExpiryDate {
            self.openMonthYearDialog()
            return false
        }
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else { return true }
        
        if textField == txtCardNumber {
            txtCardNumber.text = currentText.grouping(every: 4, with: " ")
            return false
        }
        if textField == txtExpiryDate {
            txtExpiryDate.text = currentText.grouping(every: 2, with: "/")
            return false
        }
        
        
        return true
    }
    
}
