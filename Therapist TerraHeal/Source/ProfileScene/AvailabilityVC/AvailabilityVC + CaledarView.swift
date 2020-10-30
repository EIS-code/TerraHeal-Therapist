//
//  WorkingScheduleVC + CaledarView.swift
//  Therapist TerraHeal
//
//  Created by Jaydeep Vyas on 28/10/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import Foundation

//import FSCalendar

extension AvailabilityVC: FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {

    func setupCalendarView(calendar: FSCalendar) {
        calendar.delegate = self
        calendar.dataSource = self
        calendar.scope = .week
        calendar.allowsMultipleSelection = false
        calendar.headerHeight = 0.0
        calendar.appearance.todayColor = UIColor.themeSecondary
        calendar.appearance.selectionColor =  UIColor.themePrimary
        calendar.appearance.caseOptions = .weekdayUsesSingleUpperCase

        calendar.appearance.weekdayFont = FontHelper.font(name: FontName.Regular, size: JDDeviceHelper.offseter(offset: FontSize.detail))
        calendar.appearance.weekdayTextColor = UIColor.themeHintText
        calendar.appearance.headerTitleFont = FontHelper.font(name: FontName.Regular, size: JDDeviceHelper.offseter(offset: FontSize.subHeader))
        calendar.appearance.headerTitleColor = UIColor.themeDarkText
        calendar.appearance.subtitleFont = FontHelper.font(name: FontName.Regular, size: JDDeviceHelper.offseter(offset: FontSize.subHeader))
        calendar.rowHeight = JDDeviceHelper.offseter(offset: 48)
        calendar.reloadData()


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

    }
    /*func minimumDate(for calendar: FSCalendar) -> Date {
        return minDate
    }

    func maximumDate(for calendar: FSCalendar) -> Date {
        return maxDate
    }*/

    func selectDate(date:Date) {
        self.vwCalendar.select(date)
    }
}
