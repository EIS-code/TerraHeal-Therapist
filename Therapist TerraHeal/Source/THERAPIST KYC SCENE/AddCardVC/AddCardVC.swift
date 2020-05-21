//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit



class AddCardVC: MainVC {



    @IBOutlet weak var btnAddCard: ThemeButton!
    @IBOutlet weak var lblHeader: ThemeLabel!
    @IBOutlet weak var lblMessage: ThemeLabel!
    @IBOutlet weak var txtCardNumber: ACFloatingTextfield!
    @IBOutlet weak var txtExpiryDate: ACFloatingTextfield!

    @IBOutlet weak var lblCardNumber: ThemeLabel!
    @IBOutlet weak var lblExpiryDate: ThemeLabel!

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
        self.btnAddCard?.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
    }

    private func initialViewSetup() {
        self.vwBar?.backgroundColor = UIColor.clear

        self.btnAddCard?.setTitle("ADD_CARD_BTN_ADD_CARD".localized(), for: .normal)
        self.btnAddCard?.setFont(name: FontName.GradDuke, size: FontSize.button_22)

        self.lblHeader?.text = "ADD_CARD_LBL_TITLE".localized()
        self.lblHeader?.setFont(name: FontName.GradDuke, size: FontSize.label_26)

        self.lblMessage?.text = "ADD_CARD_LBL_MESSAGE".localized()
        self.lblMessage?.setFont(name: FontName.Ovo, size: FontSize.label_18)

        self.lblCardNumber?.text = "ADD_CARD_LBL_CARD_NUMBER".localized()
        self.lblCardNumber?.setFont(name: FontName.Ovo, size: FontSize.label_18)

        self.lblExpiryDate?.text = "ADD_CARD_LBL_EXPIRY_DATE".localized()
        self.lblExpiryDate?.setFont(name: FontName.Ovo, size: FontSize.label_18)

        self.txtCardNumber?.placeholder = "ADD_CARD_TXT_CARD_NUMBER".localized()
        self.txtCardNumber?.delegate = self

        self.txtExpiryDate?.placeholder = "ADD_CARD_TXT_EXPIRY_DATE".localized()
        self.txtExpiryDate?.delegate = self


    }

    // MARK: - Action Methods
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        self.navigationController?.popViewController(animated: true)
    }


    @IBAction func btnAddCardTapped(_ sender: Any) {
        //Common.appDelegate.loadCompleteIdentityVerificationVC()
    }


}



extension AddCardVC: UITextFieldDelegate {


    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else { return true }
        if textField == txtCardNumber {
            txtCardNumber.text = currentText.grouping(every: 4, with: " ")
        }
        if textField == txtExpiryDate {
            txtExpiryDate.text = currentText.grouping(every: 2, with: " ")
        }


        return true
    }

}
