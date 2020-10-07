//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit



class SuggestionAndComplaintVC: BaseVC {
    
    @IBOutlet weak var tblForData: UITableView!
    @IBOutlet weak var btnSubmit: FilledRoundedButton!

    private struct SuggesionType {
        static let Suggestion: String = "0"
        static let Complaint: String = "1"
    }
    var arrForData: [SuggestionTblCellDetail] = [SuggestionTblCellDetail.init(),SuggestionTblCellDetail.init(),SuggestionTblCellDetail.init(),SuggestionTblCellDetail.init()]
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
        self.wsGetMenuDetail()
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
            self.tblForData?.reloadData({
            })
            self.tblForData?.contentInset = self.getGradientInset()
        }
    }
    
    private func initialViewSetup() {
        self.setupTableView(tableView: self.tblForData)
        self.setNavigationTitle(title: "SUGGESTIONS_AND_COMPLAINTS_TITLE".localized())
        self.setBackground(color: UIColor.themeLightBackground)
        self.btnSubmit?.setText("SUGGESTIONS_AND_COMPLAINTS_BTN_ADD".localized(), for: .normal)
    }

    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        super.btnLeftTapped()
         _ = (self.navigationController as? NC)?.popVC()
    }

    @IBAction func btnSubmitTapped(_ sender: Any) {
        self.btnSubmit.isEnabled = false
        self.openAddNewDialog()
    }


}

//Add New Complaint OR Suggesion Dialogs
extension SuggestionAndComplaintVC {

    func openAddNewDialog() {
        let suggestionDetail: SelectionBorderTableCellDetail = SelectionBorderTableCellDetail.init(id: SuggesionType.Suggestion, title: "SUGGESTIONS".localized())
        let complations: SelectionBorderTableCellDetail = SelectionBorderTableCellDetail.init(id: SuggesionType.Complaint, title: "COMPLATIONS".localized())
        let arrForData: [SelectionBorderTableCellDetail] = [suggestionDetail,complations]
        let addNewDialog: CustomTblSelectionDialog = CustomTblSelectionDialog.fromNib()
        addNewDialog.initialize(title: "ADD_SUGGESTIONS_OR_COMPLAINTS_DIALOG_TITLE".localized(), buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_BACK".localized())
        addNewDialog.setDataSource(dataList: arrForData)
        addNewDialog.show(animated: true)
        addNewDialog.onBtnCancelTapped = {
            [weak addNewDialog, weak self] in
            guard let self = self else {return}; print(self)
            addNewDialog?.dismiss();
            self.btnSubmit.isEnabled = true
        }
        addNewDialog.onBtnDoneTapped = {
            [weak addNewDialog, weak self] (selectionData) in
            guard let self = self else {return}; print(self)
            addNewDialog?.dismiss();
            if selectionData.id == SuggesionType.Suggestion {
                self.openAddNewSuggestionDialog()
            } else {
                self.openAddNewComplaintDialog()
            }
            self.btnSubmit.isEnabled = true

        }
    }






    func openAddNewComplaintDialog() {
        let alert: CustomTextViewDialog = CustomTextViewDialog.fromNib()
        alert.initialize(title: "ADD_COMPLAINTS_DIALOG_TITLE".localized(), placeholder: "ADD_COMPLAINTS_DIALOG_PLACEHOLDER".localized(), data: "", buttonTitle: "BTN_SEND".localized(), cancelButtonTitle: "BTN_SKIP".localized())
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            guard let self = self else {return}; print(self)
            alert?.dismiss()
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self] (description) in
            guard let self = self else { return } ; print(self)
            alert?.dismiss()
        }
    }

    func openAddNewSuggestionDialog() {
        let alert: CustomTextViewDialog = CustomTextViewDialog.fromNib()
        alert.initialize(title: "ADD_SUGGESTION_DIALOG_TITLE".localized(), placeholder: "ADD_SUGGESTION_DIALOG_PLACEHOLDER".localized(), data: "", buttonTitle: "BTN_SEND".localized(), cancelButtonTitle: "BTN_SKIP".localized())
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            guard let self = self else {return}; print(self)
            alert?.dismiss()
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self] (description) in
            guard let self = self else { return } ; print(self)
            alert?.dismiss()
        }
    }
}

extension SuggestionAndComplaintVC: UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate {
    
    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(SuggestionTblCell.nib()
            , forCellReuseIdentifier: SuggestionTblCell.name)
        tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrForData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SuggestionTblCell.name, for: indexPath) as?  SuggestionTblCell
        cell?.setData(data: arrForData[indexPath.row])
        return cell!
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: Web Service Call
extension SuggestionAndComplaintVC {
    func wsGetMenuDetail() {
       /* Loader.showLoading()
        AppWebApi.getMenuDetail(completionHandler: { (response) in
            self.arrForData.removeAll()
            if ResponseModel.isSuccess(response: response, withSuccessToast: false, andErrorToast: false) {
                for data in response.dataList {
                    self.arrForData.append(data)
                }
                self.tableView.reloadData()
            }
            Loader.hideLoading()
        })*/
    }
}