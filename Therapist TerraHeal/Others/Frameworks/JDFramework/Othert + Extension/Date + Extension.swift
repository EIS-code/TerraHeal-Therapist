//
//  Date + Extension.swift
//  Terra Heal
//
//  Created by Jaydeep Vyas on 29/09/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import Foundation

public extension Date {

    var millisecondsSince1970:Double {
        return Double((self.timeIntervalSince1970 * 1000.0).rounded())
    }

    init(milliseconds:Double) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }

    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!

    }

    func startOfDay() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }

    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, second: -1), to: self.startOfMonth())!
    }

    func nextMonth() -> Date {
        var dateComponent = DateComponents()
        dateComponent.month = 1
        return Calendar.current.date(byAdding: dateComponent, to: self) ?? Date()
    }
    func previousMonth() ->  Date {
        var dateComponent = DateComponents()
        dateComponent.month = -1
        return Calendar.current.date(byAdding: dateComponent, to: self) ?? Date()
    }

    static func millisecondsOfDay(day: Int) -> Double {
        return Double(86400 * day)
    }
    func toString(format:String, timezone:TimeZone = TimeZone.current) -> String {
        let dtFormatter: DateFormatter = DateFormatter()
        dtFormatter.dateFormat = format
        dtFormatter.timeZone = timezone
        return dtFormatter.string(from: self)
    }

    func getOnlyHourAndMinutMilli () -> Double {
        var calendar: Calendar = Calendar.current
        calendar.timeZone = TimeZone.init(secondsFromGMT: 0) ?? TimeZone.current
        let comp = calendar.dateComponents([.hour,.minute], from: self)
        let hora = comp.hour ?? 0
        let minute = comp.minute ??  0
        let hours = hora*3600
        let minuts = minute*60
        let totseconds = (hours+minuts) * 1000
        return Double(totseconds)
    }

    static func milliSecToDate(milliseconds:Double, format:String,timezone:TimeZone = TimeZone.current) ->   String {
        let date = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
        return date.toString(format: format,timezone: timezone)
    }
}
