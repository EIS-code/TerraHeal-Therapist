//
//  DefaultViewModel.swift
//  JZCalendarViewExample
//
//  Created by Jeff Zhang on 3/4/18.
//  Copyright © 2018 Jeff Zhang. All rights reserved.
//

import UIKit

class DefaultViewModel: NSObject {


    private let firstDate = "14-10-2020 01:00".toDate(format: "dd-MM-yyyy HH:mm")//Date().add(component: .hour, value: 1)
    private let secondDate = "14-10-2020 02:00".toDate(format: "dd-MM-yyyy HH:mm")//Date().add(component: .day, value: 1)
    private let thirdDate = "14-10-2020 03:00".toDate(format: "dd-MM-yyyy HH:mm") //Date().add(component: .day, value: 2)
    private let forthdDate = "15-10-2020 04:00".toDate(format: "dd-MM-yyyy HH:mm") //Date().add(component: .day, value: 2)

    lazy var events = [
        DefaultEvent(id: "0", title: firstDate.toString(format: "dd MM yyyy, HH:mm"), startDate: firstDate, endDate: firstDate.add(component: .hour, value: 1)),
        DefaultEvent(id: "1", title: "Two", startDate: secondDate, endDate: secondDate.add(component: .minute, value: 15)),
        DefaultEvent(id: "2", title: "Three", startDate: thirdDate, endDate: thirdDate.add(component: .minute, value: 15)),
        DefaultEvent(id: "3", title: "Four", startDate: thirdDate, endDate: thirdDate.add(component: .minute, value: 15))]
    lazy var eventsByDate = JZWeekViewHelper.getIntraEventsByDate(originalEvents: events)
    var currentSelectedData: OptionsSelectedData! = OptionsSelectedData.init(viewType: .defaultView, date: Date(), numOfDays: 7, scrollType: .pageScroll, firstDayOfWeek: .Monday, hourGridDivision: .noneDiv, scrollableRange: (nil,nil) )
}
