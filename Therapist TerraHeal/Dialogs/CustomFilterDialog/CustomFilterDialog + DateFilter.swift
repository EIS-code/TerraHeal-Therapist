//
//  CustomFilterDialog + DateFilter.swift
//  Therapist TerraHeal
//
//  Created by Jaydeep Vyas on 07/10/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import Foundation
import UIKit
import FSCalendar

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
    calendar.appearance.todayColor = UIColor.darkGray
    calendar.appearance.selectionColor =  UIColor.themePrimary
    calendar.appearance.caseOptions = .weekdayUsesSingleUpperCase

    calendar.appearance.weekdayFont = FontHelper.font(name: FontName.Regular, size: JDDeviceHelper.offseter(offset: FontSize.detail))
    calendar.appearance.weekdayTextColor = UIColor.themeHintText
    calendar.appearance.headerTitleFont = FontHelper.font(name: FontName.Regular, size: JDDeviceHelper.offseter(offset: FontSize.subHeader))
    calendar.appearance.headerTitleColor = UIColor.themeDarkText
    calendar.appearance.subtitleFont = FontHelper.font(name: FontName.Regular, size: JDDeviceHelper.offseter(offset: FontSize.subHeader))
}

func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
}

func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        self.selectDate(date: date)
        if monthPosition == .previous || monthPosition == .next {
            calendar.setCurrentPage(date, animated: true)
        }
    self.selectedValue =  date.toString(format: DateFormat.BookingDateSelection)
}
func minimumDate(for calendar: FSCalendar) -> Date {
    return minDate
}

func maximumDate(for calendar: FSCalendar) -> Date {
    return maxDate
}

func selectDate(date:Date) {
    self.vwCalendar.select(date)
    self.selectedMilli = date.millisecondsSince1970
}

}
