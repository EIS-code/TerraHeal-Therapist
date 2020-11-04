//
//  WorkingScheduleVC + CaledarView.swift
//  Therapist TerraHeal
//
//  Created by Jaydeep Vyas on 28/10/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import Foundation

//import FSCalendar

extension WorkingScheduleVC: FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {

    func setupCalendarView(calendar: FSCalendar) {
        calendar.delegate = self
        calendar.dataSource = self
        calendar.allowsMultipleSelection = false
        calendar.appearance.todaySelectionColor = UIColor.themePrimary
        calendar.appearance.todayColor = UIColor.themeSecondary
        calendar.headerHeight = 0.0
        //calendar.appearance.selectionColor =  self.selectionColor
        calendar.appearance.caseOptions = .weekdayUsesSingleUpperCase

        calendar.appearance.weekdayFont = FontHelper.font(name: FontName.Regular, size: JDDeviceHelper.offseter(offset: FontSize.detail))
        calendar.appearance.weekdayTextColor = UIColor.themeHintText
        calendar.appearance.headerTitleFont = FontHelper.font(name: FontName.Regular, size: JDDeviceHelper.offseter(offset: FontSize.subHeader))
        calendar.appearance.headerTitleColor = UIColor.themeDarkText
        calendar.appearance.subtitleFont = FontHelper.font(name: FontName.Regular, size: JDDeviceHelper.offseter(offset: FontSize.subHeader))
       self.lblMonthYear.setFont(name: FontName.Regular, size: FontSize.subHeader)
       self.lblMonthYear.setText(Date().toString(format: "MMM yyyy"))

    }

    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {

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
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        if arrForWorkingDays.contains(date.millisecondsSince1970) {
            return UIColor.init(hex: "#33B199")
        } else if arrForNotAvailableDays.contains(date.millisecondsSince1970) {
            return UIColor.init(hex: "#FD3A58")
        }
        return UIColor.init(hex: "#000000DE")
    }
    func selectDate(date:Date) {
        self.vwCalendar.select(date)
    }
}
