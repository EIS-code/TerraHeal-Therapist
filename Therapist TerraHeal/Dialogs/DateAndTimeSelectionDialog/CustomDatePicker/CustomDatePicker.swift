//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Jaydeep. All rights reserved.
//

import UIKit
//import FSCalendar

class CustomDatePicker: ThemeBottomDialogView {


    @IBOutlet weak var vwSelectionDate: UIView!
    @IBOutlet weak var lblSelectedYear: ThemeLabel!
    @IBOutlet weak var lblSelectedDate: ThemeLabel!
    @IBOutlet weak var vwCalendar: FSCalendar!
    @IBOutlet weak var btnPreviousMonth: ThemeButton!
    @IBOutlet weak var btnNextMonth: ThemeButton!
    @IBOutlet weak var vwMainCalender: UIView!

    var onBtnDoneTapped: ((_ date:Double) -> Void)? = nil
    var selectedMilli:Double = 0
    var minDate = Date()
    var maxDate = Date()
    
    var selectionColor: UIColor = UIColor.themePrimary
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()

    fileprivate let gregorian: NSCalendar! = NSCalendar(calendarIdentifier:NSCalendar.Identifier.gregorian)

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func initialize(title:String, buttonTitle:String, cancelButtonTitle:String) {

        self.initialSetup()
        
        self.lblTitle.setText(title)
        self.btnDone.setText(buttonTitle, for: .normal)
        if cancelButtonTitle.isEmpty() {
            self.btnCancel.isHidden = true
        } else {
            self.btnCancel.setText(cancelButtonTitle, for: .normal)
            self.btnCancel.isHidden = false
        }
    }

    override func initialSetup() {
        super.initialSetup()
        self.btnPreviousMonth.setText(FontSymbol.back_arrow, for: .normal)
        self.btnPreviousMonth.setFont(name: FontName.SemiBold, size: FontSize.button_22)
        self.btnNextMonth.setText(FontSymbol.next_arrow, for: .normal)
        self.btnNextMonth.setFont(name: FontName.SemiBold, size: FontSize.button_22)
        self.lblTitle.setFont(name: FontName.Bold, size: FontSize.header)
        self.lblSelectedDate.setFont(name: FontName.Bold, size: FontSize.doubleExLarge)
        self.lblSelectedYear.setFont(name: FontName.Regular, size: FontSize.subHeader)
        self.setupCalendarView(calendar: vwCalendar)
        self.vwSelectionDate.backgroundColor = self.selectionColor
        self.selectDate(date: Date())
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        //vwMainCalender?.setRound(withBorderColor: .clear, andCornerRadious: 5.0, borderWidth: 1.0)
        vwMainCalender?.setShadow()
    }



    @IBAction func btnPreviousTapped(_ sender: Any) {
        let currentPage = self.vwCalendar.currentPage.previousMonth()
        self.vwCalendar.setCurrentPage(currentPage, animated: true)
    }
    @IBAction func btnNextTapped(_ sender: Any) {
        let currentPage = self.vwCalendar.currentPage.nextMonth()
        self.vwCalendar.setCurrentPage(currentPage, animated: true)
    }

    @IBAction func btnDoneTapped(_ sender: Any) {
        if selectedMilli == 0 {
            Common.showAlert(message: "VALIDATION_MSG_PLEASE_SELECT_DATE".localized())
        } else {
            if self.onBtnDoneTapped != nil {
                self.onBtnDoneTapped!(selectedMilli);
            }
        }

    }
    
    func setDate(minDate:Date, maxDate: Date) {
        self.minDate = minDate
        self.maxDate = maxDate
        self.vwCalendar.reloadData()
    }

}



extension CustomDatePicker: FSCalendarDataSource, FSCalendarDelegate {

    func setupCalendarView(calendar: FSCalendar) {
        calendar.delegate = self
        calendar.dataSource = self
        calendar.allowsMultipleSelection = false
        calendar.appearance.todaySelectionColor = self.selectionColor
        calendar.appearance.todayColor = UIColor.themeSecondary
        calendar.appearance.selectionColor =  self.selectionColor
        calendar.appearance.caseOptions = .weekdayUsesSingleUpperCase

        calendar.appearance.weekdayFont = FontHelper.font(name: FontName.Regular, size: JDDeviceHelper.offseter(offset: FontSize.detail))
        calendar.appearance.weekdayTextColor = UIColor.themeHintText
        calendar.appearance.headerTitleFont = FontHelper.font(name: FontName.Regular, size: JDDeviceHelper.offseter(offset: FontSize.subHeader))
        calendar.appearance.headerTitleColor = UIColor.themeDarkText
        calendar.appearance.subtitleFont = FontHelper.font(name: FontName.Regular, size: JDDeviceHelper.offseter(offset: FontSize.subHeader))
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("change page to \(self.formatter.string(from: calendar.currentPage))")
    }

    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("calendar did select date \(self.formatter.string(from: date))")
            self.selectDate(date: date)
            if monthPosition == .previous || monthPosition == .next {
                calendar.setCurrentPage(date, animated: true)
            }
        
    }
    func minimumDate(for calendar: FSCalendar) -> Date {
        return minDate
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        return maxDate
    }
    
    func selectDate(date:Date) {
        self.lblSelectedDate.setText(date.toString(format: "E, MMM dd"))
        self.lblSelectedYear.setText(date.toString(format: "yyyy"))
        self.vwCalendar.select(date)
        self.selectedMilli = date.millisecondsSince1970
    }
}
