//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Jaydeep. All rights reserved.
//

import UIKit

enum PreferLanguage: String {
    case English  = "en"
    case Portugues  = "pt"
    case NoPreference = ""

    func name()-> String {
        switch self {
        // Use Internationalization, as appropriate.
        case .English: return "LANGUAGE_ENGLISH".localized()
        case .Portugues: return "LANGUAGE_PORTUGUES".localized()
        default: return "LANGUAGE_NO_PREFERENCE".localized()
        }
    }

    func flag() -> String {
        switch self {
        // Use Internationalization, as appropriate.
        case .English: return "🇬🇧"
        case .Portugues: return "🇵🇹"
        default: return "--"
        }
    }
    func code() -> String {
        switch self {
        // Use Internationalization, as appropriate.
        case .English: return "en"
        case .Portugues: return "pt-PT"
        default: return "--"
        }
    }




}

struct LanguageDetail {
    var type: PreferLanguage = PreferLanguage.English
    var fluency: LanguageFluent = .Basic
    var name: String = ""
    var image: String = ""
    var isSelected: Bool = false
}
class LanguageSelectionDialog: ThemeBottomDialogView {

    @IBOutlet weak var hTblVw: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchVw: UIView!
    @IBOutlet weak var txtSearchBar: ThemeTextField!

    var onBtnDoneTapped: ((_ Language:LanguageDetail) -> Void)? = nil
    var selectedLanguage: LanguageDetail?  = nil
    var arrForFilteredData: [LanguageDetail] = [
        LanguageDetail.init(type: PreferLanguage.English, name: PreferLanguage.English.name(), image: PreferLanguage.English.flag(), isSelected: true),
        LanguageDetail.init(type: PreferLanguage.Portugues, name: PreferLanguage.Portugues.name(),image: PreferLanguage.Portugues.flag(), isSelected: false),
    ]
    var arrForForOriginalData: [LanguageDetail] = [
        LanguageDetail.init(type: PreferLanguage.English, name: PreferLanguage.English.name(), image: PreferLanguage.English.flag(), isSelected: true),
        LanguageDetail.init(type: PreferLanguage.Portugues, name: PreferLanguage.Portugues.name(),image: PreferLanguage.Portugues.flag(), isSelected: false),
    ]

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
        self.setupSearchbar(searchBar: self.txtSearchBar)
    }

    override func initialSetup() {
        super.initialSetup()
        self.lblTitle.setFont(name: FontName.Bold, size: FontSize.header)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.reloadTableDataToFitHeight(tableView: self.tableView)
    }

    @IBAction func btnDoneTapped(_ sender: Any) {
        if self.selectedLanguage != nil {
            self.openLanguageFluencyDialog()
        }
    }

    func openLanguageFluencyDialog(){

        let alert: LanguageFluencyDialog = LanguageFluencyDialog.fromNib()
        alert.selectedLanguage = self.selectedLanguage!
        alert.initialize(title: self.lblTitle.text ?? "", buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_BACK".localized())
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            guard let self = self else { return } ; print(self)
            alert?.dismiss()
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self] (language) in
            guard let self = self else { return } ; print(self)
            self.selectedLanguage = language
            alert?.dismiss()
            if self.onBtnDoneTapped != nil {
                self.onBtnDoneTapped!(self.selectedLanguage!);
            }
        }
    }
   
}

extension LanguageSelectionDialog : UITextFieldDelegate {

    private func setupSearchbar(searchBar: UITextField) {
        txtSearchBar.delegate = self
        txtSearchBar.setFont(name: FontName.Regular, size: FontSize.textField_regular)
        txtSearchBar.addTarget(self, action: #selector(searching(_:)), for: .editingChanged)
        txtSearchBar.textColor = UIColor.themeDarkText
        txtSearchBar.changePlaceHolder(color: UIColor.themeDarkText)
        txtSearchBar.placeholder = "TXT_SEARCH_COUNTRY".localized()
    }

    func searchData(for text: String) {
        if text.isEmpty {
            self.arrForFilteredData.removeAll()
            for data in self.arrForForOriginalData {
                    self.arrForFilteredData.append(data)
            }
        } else {
            self.arrForFilteredData.removeAll()
            for data in self.arrForForOriginalData {
                if data.name.lowercased().hasPrefix(text.lowercased()) {
                    self.arrForFilteredData.append(data)
                }
            }
        }
        self.reloadTableDataToFitHeight(tableView: tableView)
    }

    @IBAction func searching(_ sender: UITextField) {
        searchData(for: sender.text ?? "")
    }
}

extension LanguageSelectionDialog : UITableViewDelegate,UITableViewDataSource {

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
        tableView.register(LanguageTableCell.nib()
            , forCellReuseIdentifier: LanguageTableCell.name)
        tableView.tableFooterView = UIView()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrForFilteredData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: LanguageTableCell.name, for: indexPath) as?  LanguageTableCell
        cell?.layoutIfNeeded()
        cell?.setData(data: arrForFilteredData[indexPath.row])
        cell?.layoutIfNeeded()
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        for i in 0..<arrForFilteredData.count {
            arrForFilteredData[i].isSelected = false
        }
        self.arrForFilteredData[indexPath.row].isSelected = true
        self.selectedLanguage = self.arrForFilteredData[indexPath.row]
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}



