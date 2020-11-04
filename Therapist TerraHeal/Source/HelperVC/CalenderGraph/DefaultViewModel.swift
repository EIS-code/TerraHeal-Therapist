//
//  DefaultViewModel.swift
//  JZCalendarViewExample
//
//  Created by Jeff Zhang on 3/4/18.
//  Copyright © 2018 Jeff Zhang. All rights reserved.
//

import UIKit
import Foundation

class DefaultViewModel: NSObject {


    private let firstDate = Date().add(component: .hour, value: 1)
    private let secondDate = Date().add(component: .day, value: 1)
    private let thirdDate = Date().add(component: .day, value: 2)
    private let forthdDate = Date().add(component: .day, value: 3)


    lazy var events = [
        DefaultEvent(id: "0", title: firstDate.toString(format: "dd MM yyyy, HH:mm"), startDate: firstDate, endDate: firstDate.add(component: .hour, value: 1)),
        DefaultEvent(id: "1", title: "Two", startDate: secondDate, endDate: secondDate.add(component: .minute, value: 15)),
        DefaultEvent(id: "2", title: "Three", startDate: thirdDate, endDate: thirdDate.add(component: .minute, value: 15)),
        DefaultEvent(id: "3", title: "Four", startDate: thirdDate, endDate: thirdDate.add(component: .minute, value: 15))]
    lazy var eventsByDate = JZWeekViewHelper.getIntraEventsByDate(originalEvents: events)
    var currentSelectedData: OptionsSelectedData! = OptionsSelectedData.init(viewType: .defaultView, date: Date(), numOfDays: 7, scrollType: .pageScroll, firstDayOfWeek: .Monday, hourGridDivision: .noneDiv, scrollableRange: (nil,nil) )
}
