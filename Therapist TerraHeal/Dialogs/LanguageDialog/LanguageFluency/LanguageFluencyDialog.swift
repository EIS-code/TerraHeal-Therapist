//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Jaydeep. All rights reserved.
//

import UIKit
enum LanguageFluent: String {
    case Basic  = "basic"
    case Good  = "good"
    case Fluent = "fluent"

    func name()-> String {
        switch self {
        // Use Internationalization, as appropriate.
        case .Basic: return "LANGUAGE_FLUENT_BASIC".localized()
        case .Good: return "LANGUAGE_FLUENT_GOOD".localized()
        case .Fluent: return "LANGUAGE_FLUENT_FLUENT".localized()
        default: return "LANGUAGE_NO_PREFERENCE".localized()
        }
    }

}

class LanguageFluencyDialog: ThemeBottomDialogView {

    @IBOutlet weak var hTblVw: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchVw: UIView!
    @IBOutlet weak var txtSearchBar: ThemeTextField!

    var onBtnDoneTapped: ((_ Language:LanguageDetail) -> Void)? = nil
    var selectedLanguage: LanguageDetail = LanguageDetail.init()
    var arrForOrignalData: [LanguageFluent] = [LanguageFluent.Basic,LanguageFluent.Good,LanguageFluent.Fluent]

    var arrForData: [RadioSelectionTblCellDetail] = [
        RadioSelectionTblCellDetail.init(id: "0", title: LanguageFluent.Basic.name()),
        RadioSelectionTblCellDetail.init(id: "1", title: LanguageFluent.Good.name()),
        RadioSelectionTblCellDetail.init(id: "2", title: LanguageFluent.Fluent.name())]

    @IBOutlet weak var vwSelectedLanguage: UIView!
    @IBOutlet weak var lblLanguageName: ThemeLabel!
    @IBOutlet weak var lblLanguageFlag: ThemeLabel!
    var languageShadow = CellShadowProperty.init()
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
        self.setupTableView(tableView: self.tableView)
        self.vwSelectedLanguage.backgroundColor = .themeWhite
        self.lblLanguageFlag.setText(self.selectedLanguage.image)
        self.lblLanguageName.setText(self.selectedLanguage.name)
    }

    override func initialSetup() {
        super.initialSetup()
        self.lblTitle.setFont(name: FontName.Bold, size: FontSize.header)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.reloadTableDataToFitHeight(tableView: self.tableView)
        self.vwSelectedLanguage?.setRound(withBorderColor: UIColor.themePrimary, andCornerRadious: JDDeviceHelper.offseter(offset: 15), borderWidth: 1.0)
        self.vwSelectedLanguage.setShadow(radius: languageShadow.radius, opacity: languageShadow.opacity, offset: languageShadow.offset, color: languageShadow.color)
    }

    @IBAction func btnDoneTapped(_ sender: Any) {
            if self.onBtnDoneTapped != nil {
                self.onBtnDoneTapped!(selectedLanguage);
            }
    }


}


extension LanguageFluencyDialog : UITableViewDelegate,UITableViewDataSource {

    private func reloadTableDataToFitHeight(tableView: UITableView) {
        tableView.reloadData(heightToFit: self.hTblVw) {

        }
    }
    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(RadioSelectionTblCell.nib()
            , forCellReuseIdentifier: RadioSelectionTblCell.name)
        tableView.tableFooterView = UIView()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrForData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: RadioSelectionTblCell.name, for: indexPath) as?  RadioSelectionTblCell
        cell?.layoutIfNeeded()
        cell?.setData(data: arrForData[indexPath.row])
        cell?.layoutIfNeeded()
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        for i in 0..<arrForData.count {
            arrForData[i].isSelected = false
        }
        self.arrForData[indexPath.row].isSelected = true
        self.selectedLanguage.fluency = self.arrForOrignalData[indexPath.row]
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}



