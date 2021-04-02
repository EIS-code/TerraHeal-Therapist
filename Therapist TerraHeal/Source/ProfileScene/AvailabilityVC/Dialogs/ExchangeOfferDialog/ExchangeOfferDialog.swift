//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Jaydeep. All rights reserved.
//

import UIKit



class ExchangeOfferDialog: ThemeBottomDialogView {

    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var vwForSelectedTime: UIView!
    @IBOutlet weak var vwCalendar: FSCalendar!
    @IBOutlet weak var btnPreviousMonth: ThemeButton!
    @IBOutlet weak var btnNextMonth: ThemeButton!
    @IBOutlet weak var btnSelectWeek: ThemeButton!
    @IBOutlet weak var lblMonthYear: ThemeLabel!
    @IBOutlet weak var searchVw: UIView!
    @IBOutlet weak var txtSearchBar: ThemeTextField!

    var onBtnDoneTapped: (() -> Void)? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func initialize(title:String,buttonTitle:String,cancelButtonTitle:String) {
        self.initialSetup()
        self.lblTitle.setText(title)
        if cancelButtonTitle.isEmpty() {
            self.btnCancel.isHidden = true
        } else {
            self.btnCancel.setText(cancelButtonTitle, for: .normal)
            self.btnCancel.isHidden = false
        }
        if buttonTitle.isEmpty() {
            self.btnDone.isHidden = true
        } else {
            self.btnDone.setText(buttonTitle, for: .normal)
            self.btnDone.isHidden = false
        }
        vwForSelectedTime.setRound(withBorderColor: UIColor.themePrimary, andCornerRadious: 1.0, borderWidth: 1.0)
        self.setupCalendarView(calendar: self.vwCalendar)
        self.setupSearchbar(searchBar: txtSearchBar)
        self.wsGetTherapist()
    }

    override func initialSetup() {
        super.initialSetup()
        self.lblTitle.setFont(name: FontName.Bold, size: FontSize.header)
        self.timePicker.backgroundColor = UIColor.clear
        self.timePicker.setValue(UIColor.themeSecondary, forKeyPath: "textColor")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.searchVw.setRound(withBorderColor: .clear, andCornerRadious: self.searchVw.bounds.height/2.0, borderWidth: 1.0)
    }

    @IBAction func btnDoneTapped(_ sender: Any) {
        if self.onBtnDoneTapped != nil {
                self.onBtnDoneTapped!();
            }
    }

    @IBAction func btnSelectWeekTapped(_ sender: Any) {
         let currentPage = self.vwCalendar.currentPage.nextWeek()
         self.vwCalendar.setCurrentPage(currentPage, animated: true)
     }

     @IBAction func btnPreviousTapped(_ sender: Any) {
            let currentPage = self.vwCalendar.currentPage.previousMonth()
            self.vwCalendar.setCurrentPage(currentPage, animated: true)
     }

     @IBAction func btnNextTapped(_ sender: Any) {
            let currentPage = self.vwCalendar.currentPage.nextMonth()
            self.vwCalendar.setCurrentPage(currentPage, animated: true)
     }
}




extension ExchangeOfferDialog : UITextFieldDelegate {

    private func setupSearchbar(searchBar: UITextField) {
        self.txtSearchBar.delegate = self
        self.txtSearchBar.setFont(name: FontName.Regular, size: FontSize.textField_regular)
        self.txtSearchBar.addTarget(self, action: #selector(searching(_:)), for: .editingChanged)
        self.txtSearchBar.textColor = UIColor.themeDarkText
        self.txtSearchBar.changePlaceHolder(color: UIColor.themeDarkText)
        self.txtSearchBar.placeholder = "TXT_SEARCH_FOR_NAME".localized()
    }

    func searchData(for text: String) {
        self.wsGetTherapist()
    }

    @IBAction func searching(_ sender: UITextField) {
        searchData(for: sender.text ?? "")
    }
    func wsGetTherapist() {
        Loader.showLoading()
        ExchangeWithOtherWebService.requestToGetTherapistList(params: ExchangeWithOtherWebService.RequestToTherapistList.init(name: txtSearchBar.text!)) { (response) in
            Loader.hideLoading()
            if ResponseModel.isSuccess(response: response) {

            }
        }
    }
}
