//
//  CustomFilterDialog + DateFilter.swift
//  Therapist TerraHeal
//
//  Created by Jaydeep Vyas on 07/10/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import Foundation
import UIKit
//import FSCalendar

extension CustomFilterDialog: FSCalendarDataSource, FSCalendarDelegate {

    func setupDateView() {
        self.dateView.frame = self.activeView.bounds
        self.activeView.addSubview(dateView)
        self.setupCalendarView(calendar: self.vwCalendar)

    }

    func setupCalendarView(calendar: FSCalendar) {
        calendar.delegate = self
        calendar.dataSource = self
        calendar.allowsMultipleSelection = false
        calendar.appearance.todaySelectionColor = UIColor.themePrimary
        calendar.appearance.todayColor = UIColor.themePrimary
        calendar.appearance.selectionColor =  UIColor.themePrimary
        calendar.appearance.caseOptions = .weekdayUsesSingleUpperCase
        calendar.headerHeight = 0.0
        calendar.appearance.weekdayFont = FontHelper.font(name: FontName.Regular, size: JDDeviceHelper.offseter(offset: FontSize.detail))
        calendar.appearance.weekdayTextColor = UIColor.themeHintText
        calendar.appearance.headerTitleFont = FontHelper.font(name: FontName.Regular, size: JDDeviceHelper.offseter(offset: FontSize.subHeader))
        calendar.appearance.headerTitleColor = UIColor.themeDarkText
        calendar.appearance.subtitleFont = FontHelper.font(name: FontName.Regular, size: JDDeviceHelper.offseter(offset: FontSize.subHeader))
        self.lblMonthYear.setFont(name: FontName.Regular, size: FontSize.subHeader)
        self.lblMonthYear.setText(Date().toString(format: "MMM yyyy"))
    }

    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        let currentMonth: String = calendar.currentPage.toString(format: "MMM yyyy")
        self.lblMonthYear.setTextWithAnimation(text:currentMonth )

    }

    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        self.selectDate(date: date)
        if monthPosition == .previous || monthPosition == .next {
            calendar.setCurrentPage(date, animated: true)
        }
        self.selectedValue =  self.selectedMilli.toString()//date.toString(format: DateFormat.BookingDateSelection)
        self.selectedFilterValues.massage_date = self.selectedMilli.toString()
    }


    func selectDate(date:Date) {
        self.vwCalendar.select(date)
        self.selectedMilli = date.millisecondsSince1970
    }

}
