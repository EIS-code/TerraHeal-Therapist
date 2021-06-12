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
    var millisecondsSince1970WithUTC:Double {
        let seconds = Double(self.timeIntervalSince1970) + Double(TimeZone.current.secondsFromGMT())

        return Double(seconds * 1000.0).rounded()
    }
    init(milliseconds:Double) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }

    func startOfMonth(utc:Bool = true) -> Date {
        if utc {
            return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!.addingTimeInterval(TimeInterval(TimeZone.current.secondsFromGMT()))
        }
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

    func nextYear() -> Date {
        var dateComponent = DateComponents()
        dateComponent.year = 1
        return Calendar.current.date(byAdding: dateComponent, to: self) ?? Date()
    }
    func previousMonth() ->  Date {
        var dateComponent = DateComponents()
        dateComponent.month = -1
        return Calendar.current.date(byAdding: dateComponent, to: self) ?? Date()
    }

    func previousYear() ->  Date {
        var dateComponent = DateComponents()
        dateComponent.year = -1
        return Calendar.current.date(byAdding: dateComponent, to: self) ?? Date()
    }

    func nextWeek() -> Date {
        var dateComponent = DateComponents()
        dateComponent.weekOfMonth = 1
        return Calendar.current.date(byAdding: dateComponent, to: self) ?? Date()
    }

    func previousWeek() -> Date {
        var dateComponent = DateComponents()
        dateComponent.weekOfMonth = -1
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

    func daySuffix(from date: Date) -> String {
        let calendar = Calendar.current
        let dayOfMonth = calendar.component(.day, from: date)
        switch dayOfMonth {
        case 1, 21, 31: return "st"
        case 2, 22: return "nd"
        case 3, 23: return "rd"
        default: return "th"
        }
    }

    func convertDateFormate() -> String{
        // Day
        let calendar = Calendar.current
        let anchorComponents = calendar.dateComponents([.day, .month, .year], from: self)

        // Formate
        let dateFormate = DateFormatter()
        dateFormate.dateFormat = "MMMM yyyy"
        let newDate = dateFormate.string(from: self)

        var day  = "\(anchorComponents.day!)"
        switch (day) {
        case "1" , "21" , "31":
            day.append("st")
        case "2" , "22":
            day.append("nd")
        case "3" ,"23":
            day.append("rd")
        default:
            day.append("th")
        }
        return day + " " + newDate
    }
}
