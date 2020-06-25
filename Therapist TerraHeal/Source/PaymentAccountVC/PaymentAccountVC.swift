//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit



class PaymentAccountVC: MainVC {



    @IBOutlet weak var lblHeader: ThemeLabel!
    @IBOutlet weak var lblMessage: ThemeLabel!
    @IBOutlet var vwBg: UIView!
    @IBOutlet weak var btnPrivacyPolicy: ThemeButton!
    @IBOutlet weak var collectionView: UICollectionView!

    var arrForPayment: [PaymentAccountDetails] = [
        PaymentAccountDetails(id: 0, name: "PayPal", isConnected: false, image: UIImage()),
    PaymentAccountDetails(id: 1, name: "Stripe", isConnected: false, image: UIImage()),
    PaymentAccountDetails(id: 2, name: "Skrill", isConnected: false, image: UIImage()),
    PaymentAccountDetails(id: 3, name: "G Pay", isConnected: false, image: UIImage())]


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
        self.vwBg?.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)

    }

    private func initialViewSetup() {
        self.vwBar?.backgroundColor = UIColor.clear
        self.lblHeader?.text = "PAYMENT_ACCOOUNT_LBL_TITLE".localized()
        self.lblHeader?.setFont(name: FontName.GradDuke, size: FontSize.label_26)
        self.lblMessage?.text = "PAYMENT_ACCOOUNT_LBL_MESSAGE".localized()
        self.lblMessage?.setFont(name: FontName.Ovo, size: FontSize.label_18)
        let attributedString = NSMutableAttributedString.init(string: "PAYMENT_ACCOUNT_LBL_PRIVACY_POLICY_".localized())
        attributedString.append("PAYMENT_ACCOUNT_LBL_BTN_PRIVACY_POLICY_".localized().getUnderLineAttributedText())
        self.btnPrivacyPolicy.titleLabel?.numberOfLines = 0
        self.btnPrivacyPolicy.titleLabel?.lineBreakMode = .byWordWrapping
        self.btnPrivacyPolicy?.setAttributedTitle(attributedString, for: .normal)
        self.btnPrivacyPolicy?.setFont(name: FontName.Ovo, size: FontSize.button_18)
        self.setCollectionView()

    }


    @IBAction func btnPrivacyPolicyTapped(_ sender: Any) {
        Common.appDelegate.loadTherapistProfileVC(navigaionVC: self.navigationController)
    }



    // MARK: - Action Methods
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        self.navigationController?.popViewController(animated: true)
    }

    func openPaymentDialog(paymentDetail:PaymentAccountDetails) {
        let alert: PaymentVerificationDialog = PaymentVerificationDialog.fromNib()
        alert.initialize(title: paymentDetail.name, message: "Email", data: "")
        alert.show(animated: true)
        alert.onBtnDoneTapped = { [weak alert, weak self] (data:String) in
            alert?.dismiss()
            self?.arrForPayment[paymentDetail.id].isConnected = true
            appSingleton.user.isPaymentDetailAdded = Constant.True
            self?.collectionView.reloadData()
        }
        alert.onBtnCancelTapped = { [weak alert/*,weak self*/] in
            alert?.dismiss()

        }

    }

}
//MARK:- Collection View Setup
extension PaymentAccountVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout  {

    func setCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PaymetAccountCell.nib(), forCellWithReuseIdentifier: PaymetAccountCell.name)
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)
        layout.minimumLineSpacing = 1.0
        layout.minimumInteritemSpacing = 1.0
        self.collectionView?.collectionViewLayout = layout
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrForPayment.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PaymetAccountCell.name, for: indexPath) as! PaymetAccountCell
        cell.setData(self.arrForPayment[indexPath.row], indexPath)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        self.openPaymentDialog(paymentDetail: self.arrForPayment[indexPath.row])

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing:CGFloat = 1.0
        let numberOfItemsPerRow:CGFloat = 2
        let spacingBetweenCells:CGFloat = 1.0
        let totalSpacing = (2 * spacing) + ((numberOfItemsPerRow - 1) * spacingBetweenCells)
        if let collection = self.collectionView {
            let width = (collection.bounds.width - totalSpacing)/numberOfItemsPerRow
            return CGSize(width: width, height: width * 1.25)
        }else{
            return CGSize(width: 0, height: 0)
        }
    }
}

